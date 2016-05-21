#!/usr/bin/env python3
"""
D Vulkan bindings generator, based off of and using the Vulkan-Docs code.

Place in Vulkan-Docs/src/spec/ and run to generate bindings.
"""

import sys
import re
import os
from os import path
from itertools import islice, chain
from collections import OrderedDict

re_funcptr = re.compile(r"^typedef (.+) \(VKAPI_PTR \*$")
re_single_const = re.compile(r"^const\s+(.+)\*\s*$")
re_double_const = re.compile(r"^const\s+(.+)\*\s+const\*\s*$")
re_array = re.compile(r"^([^\[]+)\[(\d+)\]$")
re_camel_case = re.compile(r"([a-z])([A-Z])")
re_long_int = re.compile(r"([0-9]+)ULL")

try:
	from reg import *
	from generator import OutputGenerator, GeneratorOptions, write
except ImportError as e:
	print("Could not import Vulkan generator; ensure that this file is in Vulkan-Docs/src/spec", file=sys.stderr)
	print("-----", file=sys.stderr)
	raise

PKG_HEADER = """
module dvulkan;
public import dvulkan.types;
public import dvulkan.functions;
"""

TYPES_HEADER = """
module dvulkan.types;

alias uint8_t = ubyte;
alias uint16_t = ushort;
alias uint32_t = uint;
alias uint64_t = ulong;
alias int8_t = byte;
alias int16_t = short;
alias int32_t = int;
alias int64_t = long;

@nogc pure nothrow {
	uint VK_MAKE_VERSION(uint major, uint minor, uint patch) {
		return (major << 22) | (minor << 12) | (patch);
	}
	uint VK_VERSION_MAJOR(uint ver) {
		return ver >> 22;
	}
	uint VK_VERSION_MINOR(uint ver) {
		return (ver >> 12) & 0x3ff;
	}
	uint VK_VERSION_PATCH(uint ver) {
		return ver & 0xfff;
	}
}

/+
 + On 32-bit systems, VK_NULL_HANDLE must be compatible with both opaque struct pointers
 + (for dispatchable object) and integers (for nondispatchable objects). This is not possible
 + with D's type system, which doesn't implicitly convert 0 to the null pointer as in C
 + (for better or for worse). Either use the `VK_NULL_[NON_]DISPATCHABLE_HANDLE` constants or
 + `Vk(Type).init`.
 +
 + See also https://github.com/ColonelThirtyTwo/dvulkan/issues/13
 +/
deprecated("VK_NULL_HANDLE is impossible to implement portably in D. Use Vk(Type).init or VK_NULL_[NON_]DISPATCHABLE_HANDLE")
enum VK_NULL_HANDLE = null;

enum VK_DEFINE_HANDLE(string name) = "struct "~name~"_handle; alias "~name~" = "~name~"_handle*;";

enum VK_NULL_DISPATCHABLE_HANDLE = null;
version(X86_64) {
	alias VK_DEFINE_NON_DISPATCHABLE_HANDLE(string name) = VK_DEFINE_HANDLE!name;
	enum VK_NULL_NON_DISPATCHABLE_HANDLE = null;
} else {
	enum VK_DEFINE_NON_DISPATCHABLE_HANDLE(string name) = "alias "~name~" = ulong;";
	enum VK_NULL_NON_DISPATCHABLE_HANDLE = 0;
}
"""

DYNAMIC_HEADER = """
module dvulkan.functions;

import dvulkan.types;
import std.typetuple;
import std.traits : Parameters;
"""

class Extension:
	def __init__(self, name):
		self.name = name
		self.functions = OrderedDict()
		self.types = OrderedDict()
		self.enumConstants = []
	
	@property
	def version(self):
		return "DVulkan_"+self.name
	
	@property
	def funclist(self):
		return "EXTN_FUNCS_"+self.name

def getFullType(elem):
	typ = elem.find("type")
	typstr = (elem.text or "").lstrip() + \
		typ.text.strip() + (typ.tail or "").rstrip()
	
	arrlen = elem.find("enum")
	if arrlen is not None:
		return "%s[%s]" % (typstr, arrlen.text)
	else:
		name = elem.find("name")
		return typstr + (name.tail or "")

def convertTypeConst(typ):
	"""
	Converts C const syntax to D const syntax
	"""
	doubleConstMatch = re.match(re_double_const, typ)
	if doubleConstMatch:
		return "const(%s*)*" % doubleConstMatch.group(1)
	else:
		singleConstMatch = re.match(re_single_const, typ)
		if singleConstMatch:
			return "const(%s)*" % singleConstMatch.group(1)
	return typ

def convertTypeArray(typ, name):
	arrMatch = re.match(re_array, name)
	if arrMatch:
		return "%s[%s]" % (typ, arrMatch.group(2)), arrMatch.group(1)
	else:
		return typ, name

class DGenerator(OutputGenerator):
	def __init__(self, errFile=sys.stderr, warnFile=sys.stderr, diagFile=sys.stderr):
		super().__init__(errFile, warnFile, diagFile)
	
	def emitDVulkanAllExtensions(self, file):
		file.write("version(DVulkanAllExtensions) {\n")
		for ext in self.extensions:
			file.write("\tversion = DVulkan_{0};\n".format(ext.name))
		file.write("}\n")
	
	######################################################################################################
	
	def emitFunctionsFile(self):
		self.dynamicFile.write(DYNAMIC_HEADER)
		
		# Define versions for DVulkanAllExtensions
		self.emitDVulkanAllExtensions(self.dynamicFile)
		
		# Define function types
		self.dynamicFile.write("extern(System) @nogc nothrow {\n")
		for ext in self.extensions:
			self.dynamicFile.write("\tversion("+ext.version+") {\n")
			for name, cmd in ext.functions.items():
				proto = cmd.elem.find("proto")
				returnType = convertTypeConst(getFullType(proto).strip())
				params = ",".join(convertTypeConst(getFullType(param).strip())+" "+param.find("name").text for param in cmd.elem.findall("param"))
				print("\t\talias PFN_%s = %s function(%s);" % (name, returnType, params), file=self.dynamicFile)
			self.dynamicFile.write("\t}\n")
		self.dynamicFile.write("}\n")
		
		# Define global function pointers
		self.dynamicFile.write("__gshared {\n")
		for ext in self.extensions:
			self.dynamicFile.write("\tversion("+ext.version+") {\n")
			for name in ext.functions:
				self.dynamicFile.write("\t\tPFN_{0} {0};\n".format(name))
			self.dynamicFile.write("\t\tprivate alias "+ext.funclist+" = TypeTuple!(\n")
			for name in ext.functions:
				self.dynamicFile.write("\t\t\t"+name+",\n")
			self.dynamicFile.write("\t\t);\n");
			self.dynamicFile.write("\t} else { private alias "+ext.funclist+" = TypeTuple!(); }\n")
		
		self.dynamicFile.write("}\nprivate alias ALL_FUNCS = TypeTuple!(\n")
		for ext in self.extensions:
			self.dynamicFile.write("\t"+ext.funclist+",\n")
		
		self.dynamicFile.write(");\n")
		
		self.dynamicFile.write("""

struct DVulkanLoader {
	@disable this();
	@disable this(this);
	
	static void loadInstanceFunctions(typeof(vkGetInstanceProcAddr) getProcAddr) {
		vkGetInstanceProcAddr = getProcAddr;
		vkEnumerateInstanceExtensionProperties = cast(typeof(vkEnumerateInstanceExtensionProperties)) vkGetInstanceProcAddr(null, "vkEnumerateInstanceExtensionProperties");
		vkEnumerateInstanceLayerProperties = cast(typeof(vkEnumerateInstanceLayerProperties)) vkGetInstanceProcAddr(null, "vkEnumerateInstanceLayerProperties");
		vkCreateInstance = cast(typeof(vkCreateInstance)) vkGetInstanceProcAddr(null, "vkCreateInstance");
	}
	
	static void loadAllFunctions(VkInstance instance) {
		assert(vkGetInstanceProcAddr !is null, "Must call DVulkanLoader.loadInstanceFunctions before DVulkanLoader.loadAllFunctions");
		
		foreach(i, ref func; ALL_FUNCS) {
			static if(staticIndexOf!(ALL_FUNCS[i].stringof,
				"vkGetInstanceProcAddr",
				"vkEnumerateInstanceExtensionProperties",
				"vkEnumerateInstanceLayerProperties",
				"vkCreateInstance",
			) == -1) {
				func = cast(typeof(func)) vkGetInstanceProcAddr(instance, ALL_FUNCS[i].stringof);
			}
		}
	}
	static void loadAllFunctions(VkDevice device) {
		assert(vkGetDeviceProcAddr !is null, "reload(VkDevice) must be called after reload(VkInstance)");
		
		foreach(i, ref func; ALL_FUNCS) {
			static if(Parameters!func.length > 0 && staticIndexOf!(Parameters!func[0],
				VkDevice, VkQueue, VkCommandBuffer
			) != -1) {
				func = cast(typeof(func)) vkGetDeviceProcAddr(device, ALL_FUNCS[i].stringof);
			}
		}
	}
}

version(DVulkanLoadFromDerelict) {
	import derelict.util.loader;
	import derelict.util.system;
	
	private {
		version(Windows)
			enum libNames = "vulkan-1.dll";
		else version(linux)
			enum libNames = "libvulkan.so.1";
		else
			static assert(0,"Need to implement Vulkan libNames for this operating system.");
	}
	
	class DVulkanDerelictLoader : SharedLibLoader {
		this() {
			super(libNames);
		}
		
		protected override void loadSymbols() {
			typeof(vkGetInstanceProcAddr) getProcAddr;
			bindFunc(cast(void**)&getProcAddr, "vkGetInstanceProcAddr");
			DVulkanLoader.loadInstanceFunctions(getProcAddr);
		}
	}
	
	__gshared DVulkanDerelictLoader DVulkanDerelict;
	
	shared static this() {
		DVulkanDerelict = new DVulkanDerelictLoader();
	}
}
""")
		self.dynamicFile.close()
	
	######################################################################################################
	
	def emitTypesFile(self):
		self.typesFile.write(TYPES_HEADER)
		
		self.emitDVulkanAllExtensions(self.typesFile)
		
		def emitType(ext, name, typeinfo):
			if "requires" in typeinfo.elem.attrib:
				required = typeinfo.elem.attrib["requires"]
				if required.endswith(".h"):
					return
				elif required == "vk_platform":
					return
			typ = typeinfo.elem.attrib["category"]
			if typ == "handle":
				self.typesFile.write("\tmixin(%s!q{%s});\n" % (typeinfo.elem.find("type").text, name))
			elif typ == "basetype":
				self.typesFile.write("\talias %s = %s;\n" % (name, typeinfo.elem.find("type").text))
			elif typ == "bitmask":
				self.typesFile.write("\talias %s = VkFlags;\n" % name)
			elif typ == "funcpointer":
				returnType = re.match(re_funcptr, typeinfo.elem.text).group(1)
				params = "".join(islice(typeinfo.elem.itertext(), 2, None))[2:]
				if params == "void);":
					params = ");"
				self.typesFile.write("\talias %s = %s function(%s\n" % (name, returnType, params))
				
			elif typ == "struct" or typ == "union":
				emitStruct(ext, name, typeinfo)
			else:
				pass
		
		def emitStruct(ext, name, typeinfo):
			category = typeinfo.elem.attrib["category"]
			self.typesFile.write("\t%s %s {\n" % (category, name))
			for member in typeinfo.elem.findall("member"):
				memberType = convertTypeConst(getFullType(member).strip())
				memberName = member.find("name").text
				if memberName == "module":
					# don't use D identifiers
					memberName = "_module"
				
				memberType, memberName = convertTypeArray(memberType, memberName)
				if memberName == "sType" and memberType == "VkStructureType":
					enumname = re.sub(re_camel_case, "\g<1>_\g<2>", name[2:]).upper()
					self.typesFile.write("\t\tVkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_"+enumname+";\n")
				else:
					self.typesFile.write("\t\t%s %s;\n" % (memberType, memberName))
			self.typesFile.write("\t}\n")
		
		def emitGroup(ext, name, groupinfo):
			self.typesFile.write("\tenum %s {\n" % name)
			
			expand = "expand" in groupinfo.elem.attrib
			
			minName = None
			maxName = None
			minValue = float("+inf")
			maxValue = float("-inf")
			for elem in groupinfo.elem.findall("enum"):
				(numval, strval) = self.enumToValue(elem, True)
				fieldName = elem.get("name")
				self.typesFile.write("\t\t%s = %s,\n" % (fieldName, strval))
				ext.enumConstants.append((name, fieldName))
				
				if expand:
					if numval < minValue:
						minName = fieldName
						minValue = numval
					if numval > maxValue:
						maxName = fieldName
						maxValue = numval
			
			if name == "VkColorSpaceKHR":
				self.typesFile.write("\t\tVK_COLORSPACE_SRGB_NONLINEAR_KHR = VK_COLOR_SPACE_SRGB_NONLINEAR_KHR,\n")
				ext.enumConstants.append((name, "VK_COLORSPACE_SRGB_NONLINEAR_KHR"))
			
			if expand:
				prefix = groupinfo.elem.attrib["expand"]
				self.typesFile.write("\t\t%s_BEGIN_RANGE = %s,\n" % (prefix, minName))
				self.typesFile.write("\t\t%s_END_RANGE = %s,\n" % (prefix, maxName))
				self.typesFile.write("\t\t%s_RANGE_SIZE = (%s - %s + 1),\n" % (prefix, maxName, minName))
				self.typesFile.write("\t\t%s_MAX_ENUM = 0x7FFFFFFF,\n" % prefix)
				ext.enumConstants.append((name, prefix+"_BEGIN_RANGE"))
				ext.enumConstants.append((name, prefix+"_END_RANGE"))
				ext.enumConstants.append((name, prefix+"_RANGE_SIZE"))
				ext.enumConstants.append((name, prefix+"_MAX_ENUM"))
			self.typesFile.write("\t}\n")
		
		def emitEnum(ext, name, enuminfo):
			_,strVal = self.enumToValue(enuminfo.elem, False)
			if strVal == "VK_STRUCTURE_TYPE_DEBUG_REPORT_CALLBACK_CREATE_INFO_EXT":
				strVal = "VkStructureType."+strVal
			elif strVal == "VK_COLOR_SPACE_SRGB_NONLINEAR_KHR":
				return
			strVal = re.sub(re_long_int, "\g<1>UL", strVal)
			self.typesFile.write("\tenum %s = %s;\n" % (name, strVal))
		
		for ext in self.extensions:
			self.typesFile.write("version("+ext.version+") {\n")
			for name, info in ext.types.items():
				typ, info = info
				if typ == "type":
					emitType(ext, name, info)
				elif typ == "struct":
					emitStruct(ext, name, info)
				elif typ == "group":
					emitGroup(ext, name, info)
				elif typ == "enum":
					emitEnum(ext, name, info)
				else:
					raise RuntimeError()
			self.typesFile.write("}\n")
		
		self.typesFile.write("version(DVulkanGlobalEnums) {\n")
		for ext in self.extensions:
			self.typesFile.write("\tversion("+ext.version+") {\n")
			for enumName, enumField in ext.enumConstants:
				self.typesFile.write("\t\tenum {0} = {1}.{0};\n".format(enumField, enumName, enumField))
			self.typesFile.write("\t}\n")
		self.typesFile.write("}\n")
		
		self.typesFile.close()
	
	######################################################################################################
	
	def beginFile(self, genOpts):
		self.genOpts = genOpts
		try:
			os.mkdir(genOpts.filename)
		except FileExistsError:
			pass
		
		self.typesFile = open(path.join(genOpts.filename, "types.d"), "w", encoding="utf-8")
		self.dynamicFile = open(path.join(genOpts.filename, "functions.d"), "w", encoding="utf-8")
		
		with open(path.join(genOpts.filename, "package.d"), "w", encoding="utf-8") as pkgfile:
			print(PKG_HEADER, file=pkgfile)
		
		self.currentExtension = None
		self.extensions = []
	
	def endFile(self):
		self.emitFunctionsFile()
		self.emitTypesFile()
		
		self.typesFile.close()
		self.dynamicFile.close()
	
	def beginFeature(self, interface, emit):
		super().beginFeature(interface, emit)
		self.currentExtension = Extension(interface.attrib["name"])
		self.extensions.append(self.currentExtension)
	
	def endFeature(self):
		super().endFeature()
		self.currentExtension = None
	
	def genType(self, typeinfo, name):
		super().genType(typeinfo, name)
		self.currentExtension.types[name] = ("type", typeinfo)
	
	def genStruct(self, typeinfo, name):
		print("ASDF ", name)
		super().genStruct(typeinfo, name)
		self.currentExtension.types[name] = ("struct", typeinfo)
	
	def genGroup(self, groupinfo, name):
		super().genGroup(groupinfo, name)
		self.currentExtension.types[name] = ("group", groupinfo)
	
	def genEnum(self, enuminfo, name):
		super().genEnum(enuminfo, name)
		self.currentExtension.types[name] = ("enum", enuminfo)

	def genCmd(self, cmd, name):
		super().genCmd(cmd, name)
		self.currentExtension.functions[name] = cmd

class DGeneratorOptions(GeneratorOptions):
	def __init__(self, *args, **kwargs):
		super().__init__(*args, **kwargs)

if __name__ == "__main__":
	import argparse
	
	parser = argparse.ArgumentParser()
	parser.add_argument("outfolder")
	
	args = parser.parse_args()
	
	gen = DGenerator()
	reg = Registry()
	reg.loadElementTree(etree.parse("vk.xml"))
	reg.setGenerator(gen)
	reg.apiGen(DGeneratorOptions(
		filename=args.outfolder,
		apiname="vulkan",
		versions=".*",
		emitversions=".*",
		#defaultExtensions="defaultExtensions",
		addExtensions=r".*",
		removeExtensions = r"VK_KHR_.*_surface$",
	))
	
