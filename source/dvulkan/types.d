
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
version(DVulkanAllExtensions) {
	version = DVulkan_VK_VERSION_1_0;
	version = DVulkan_VK_KHR_surface;
	version = DVulkan_VK_KHR_swapchain;
	version = DVulkan_VK_KHR_display;
	version = DVulkan_VK_KHR_display_swapchain;
	version = DVulkan_VK_KHR_sampler_mirror_clamp_to_edge;
	version = DVulkan_VK_ANDROID_native_buffer;
	version = DVulkan_VK_EXT_debug_report;
	version = DVulkan_VK_NV_glsl_shader;
	version = DVulkan_VK_NV_extension_1;
	version = DVulkan_VK_IMG_filter_cubic;
	version = DVulkan_VK_AMD_extension_1;
	version = DVulkan_VK_AMD_extension_2;
	version = DVulkan_VK_AMD_rasterization_order;
	version = DVulkan_VK_AMD_extension_4;
	version = DVulkan_VK_AMD_extension_5;
	version = DVulkan_VK_AMD_extension_6;
	version = DVulkan_VK_EXT_debug_marker;
}
version(DVulkan_VK_VERSION_1_0) {
	enum VkPipelineCacheHeaderVersion {
		VK_PIPELINE_CACHE_HEADER_VERSION_ONE = 1,
	}
	enum VK_LOD_CLAMP_NONE = 1000.0f;
	enum VK_REMAINING_MIP_LEVELS = (~0U);
	enum VK_REMAINING_ARRAY_LAYERS = (~0U);
	enum VK_WHOLE_SIZE = (~0UL);
	enum VK_ATTACHMENT_UNUSED = (~0U);
	enum VK_TRUE = 1;
	enum VK_FALSE = 0;
	enum VK_QUEUE_FAMILY_IGNORED = (~0U);
	enum VK_SUBPASS_EXTERNAL = (~0U);
	enum VkResult {
		VK_SUCCESS = 0,
		VK_NOT_READY = 1,
		VK_TIMEOUT = 2,
		VK_EVENT_SET = 3,
		VK_EVENT_RESET = 4,
		VK_INCOMPLETE = 5,
		VK_ERROR_OUT_OF_HOST_MEMORY = -1,
		VK_ERROR_OUT_OF_DEVICE_MEMORY = -2,
		VK_ERROR_INITIALIZATION_FAILED = -3,
		VK_ERROR_DEVICE_LOST = -4,
		VK_ERROR_MEMORY_MAP_FAILED = -5,
		VK_ERROR_LAYER_NOT_PRESENT = -6,
		VK_ERROR_EXTENSION_NOT_PRESENT = -7,
		VK_ERROR_FEATURE_NOT_PRESENT = -8,
		VK_ERROR_INCOMPATIBLE_DRIVER = -9,
		VK_ERROR_TOO_MANY_OBJECTS = -10,
		VK_ERROR_FORMAT_NOT_SUPPORTED = -11,
		VK_ERROR_SURFACE_LOST_KHR = -1000000000,
		VK_ERROR_NATIVE_WINDOW_IN_USE_KHR = -1000000001,
		VK_SUBOPTIMAL_KHR = 1000001003,
		VK_ERROR_OUT_OF_DATE_KHR = -1000001004,
		VK_ERROR_INCOMPATIBLE_DISPLAY_KHR = -1000003001,
		VK_ERROR_VALIDATION_FAILED_EXT = -1000011001,
		VK_ERROR_INVALID_SHADER_NV = -1000012000,
		VK_NV_EXTENSION_1_ERROR = -1000013000,
	}
	enum VkStructureType {
		VK_STRUCTURE_TYPE_APPLICATION_INFO = 0,
		VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO = 1,
		VK_STRUCTURE_TYPE_DEVICE_QUEUE_CREATE_INFO = 2,
		VK_STRUCTURE_TYPE_DEVICE_CREATE_INFO = 3,
		VK_STRUCTURE_TYPE_SUBMIT_INFO = 4,
		VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_INFO = 5,
		VK_STRUCTURE_TYPE_MAPPED_MEMORY_RANGE = 6,
		VK_STRUCTURE_TYPE_BIND_SPARSE_INFO = 7,
		VK_STRUCTURE_TYPE_FENCE_CREATE_INFO = 8,
		VK_STRUCTURE_TYPE_SEMAPHORE_CREATE_INFO = 9,
		VK_STRUCTURE_TYPE_EVENT_CREATE_INFO = 10,
		VK_STRUCTURE_TYPE_QUERY_POOL_CREATE_INFO = 11,
		VK_STRUCTURE_TYPE_BUFFER_CREATE_INFO = 12,
		VK_STRUCTURE_TYPE_BUFFER_VIEW_CREATE_INFO = 13,
		VK_STRUCTURE_TYPE_IMAGE_CREATE_INFO = 14,
		VK_STRUCTURE_TYPE_IMAGE_VIEW_CREATE_INFO = 15,
		VK_STRUCTURE_TYPE_SHADER_MODULE_CREATE_INFO = 16,
		VK_STRUCTURE_TYPE_PIPELINE_CACHE_CREATE_INFO = 17,
		VK_STRUCTURE_TYPE_PIPELINE_SHADER_STAGE_CREATE_INFO = 18,
		VK_STRUCTURE_TYPE_PIPELINE_VERTEX_INPUT_STATE_CREATE_INFO = 19,
		VK_STRUCTURE_TYPE_PIPELINE_INPUT_ASSEMBLY_STATE_CREATE_INFO = 20,
		VK_STRUCTURE_TYPE_PIPELINE_TESSELLATION_STATE_CREATE_INFO = 21,
		VK_STRUCTURE_TYPE_PIPELINE_VIEWPORT_STATE_CREATE_INFO = 22,
		VK_STRUCTURE_TYPE_PIPELINE_RASTERIZATION_STATE_CREATE_INFO = 23,
		VK_STRUCTURE_TYPE_PIPELINE_MULTISAMPLE_STATE_CREATE_INFO = 24,
		VK_STRUCTURE_TYPE_PIPELINE_DEPTH_STENCIL_STATE_CREATE_INFO = 25,
		VK_STRUCTURE_TYPE_PIPELINE_COLOR_BLEND_STATE_CREATE_INFO = 26,
		VK_STRUCTURE_TYPE_PIPELINE_DYNAMIC_STATE_CREATE_INFO = 27,
		VK_STRUCTURE_TYPE_GRAPHICS_PIPELINE_CREATE_INFO = 28,
		VK_STRUCTURE_TYPE_COMPUTE_PIPELINE_CREATE_INFO = 29,
		VK_STRUCTURE_TYPE_PIPELINE_LAYOUT_CREATE_INFO = 30,
		VK_STRUCTURE_TYPE_SAMPLER_CREATE_INFO = 31,
		VK_STRUCTURE_TYPE_DESCRIPTOR_SET_LAYOUT_CREATE_INFO = 32,
		VK_STRUCTURE_TYPE_DESCRIPTOR_POOL_CREATE_INFO = 33,
		VK_STRUCTURE_TYPE_DESCRIPTOR_SET_ALLOCATE_INFO = 34,
		VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET = 35,
		VK_STRUCTURE_TYPE_COPY_DESCRIPTOR_SET = 36,
		VK_STRUCTURE_TYPE_FRAMEBUFFER_CREATE_INFO = 37,
		VK_STRUCTURE_TYPE_RENDER_PASS_CREATE_INFO = 38,
		VK_STRUCTURE_TYPE_COMMAND_POOL_CREATE_INFO = 39,
		VK_STRUCTURE_TYPE_COMMAND_BUFFER_ALLOCATE_INFO = 40,
		VK_STRUCTURE_TYPE_COMMAND_BUFFER_INHERITANCE_INFO = 41,
		VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO = 42,
		VK_STRUCTURE_TYPE_RENDER_PASS_BEGIN_INFO = 43,
		VK_STRUCTURE_TYPE_BUFFER_MEMORY_BARRIER = 44,
		VK_STRUCTURE_TYPE_IMAGE_MEMORY_BARRIER = 45,
		VK_STRUCTURE_TYPE_MEMORY_BARRIER = 46,
		VK_STRUCTURE_TYPE_LOADER_INSTANCE_CREATE_INFO = 47,
		VK_STRUCTURE_TYPE_LOADER_DEVICE_CREATE_INFO = 48,
		VK_STRUCTURE_TYPE_SWAPCHAIN_CREATE_INFO_KHR = 1000001000,
		VK_STRUCTURE_TYPE_PRESENT_INFO_KHR = 1000001001,
		VK_STRUCTURE_TYPE_DISPLAY_MODE_CREATE_INFO_KHR = 1000002000,
		VK_STRUCTURE_TYPE_DISPLAY_SURFACE_CREATE_INFO_KHR = 1000002001,
		VK_STRUCTURE_TYPE_DISPLAY_PRESENT_INFO_KHR = 1000003000,
		VK_STRUCTURE_TYPE_XLIB_SURFACE_CREATE_INFO_KHR = 1000004000,
		VK_STRUCTURE_TYPE_XCB_SURFACE_CREATE_INFO_KHR = 1000005000,
		VK_STRUCTURE_TYPE_WAYLAND_SURFACE_CREATE_INFO_KHR = 1000006000,
		VK_STRUCTURE_TYPE_MIR_SURFACE_CREATE_INFO_KHR = 1000007000,
		VK_STRUCTURE_TYPE_ANDROID_SURFACE_CREATE_INFO_KHR = 1000008000,
		VK_STRUCTURE_TYPE_WIN32_SURFACE_CREATE_INFO_KHR = 1000009000,
		VK_STRUCTURE_TYPE_DEBUG_REPORT_CALLBACK_CREATE_INFO_EXT = 1000011000,
		VK_STRUCTURE_TYPE_PIPELINE_RASTERIZATION_STATE_RASTERIZATION_ORDER_AMD = 1000018000,
		VK_STRUCTURE_TYPE_DEBUG_MARKER_OBJECT_NAME_INFO_EXT = 1000022000,
		VK_STRUCTURE_TYPE_DEBUG_MARKER_OBJECT_TAG_INFO_EXT = 1000022001,
		VK_STRUCTURE_TYPE_DEBUG_MARKER_MARKER_INFO_EXT = 1000022002,
	}
	alias VkFlags = uint32_t;
	alias VkInstanceCreateFlags = VkFlags;
	struct VkApplicationInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_APPLICATION_INFO;
		const(void)* pNext;
		const(char)* pApplicationName;
		uint32_t applicationVersion;
		const(char)* pEngineName;
		uint32_t engineVersion;
		uint32_t apiVersion;
	}
	struct VkInstanceCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO;
		const(void)* pNext;
		VkInstanceCreateFlags flags;
		const(VkApplicationInfo)* pApplicationInfo;
		uint32_t enabledLayerCount;
		const(char*)* ppEnabledLayerNames;
		uint32_t enabledExtensionCount;
		const(char*)* ppEnabledExtensionNames;
	}
	enum VkSystemAllocationScope {
		VK_SYSTEM_ALLOCATION_SCOPE_COMMAND = 0,
		VK_SYSTEM_ALLOCATION_SCOPE_OBJECT = 1,
		VK_SYSTEM_ALLOCATION_SCOPE_CACHE = 2,
		VK_SYSTEM_ALLOCATION_SCOPE_DEVICE = 3,
		VK_SYSTEM_ALLOCATION_SCOPE_INSTANCE = 4,
	}
	alias PFN_vkAllocationFunction = void* function(
    void*                                       pUserData,
    size_t                                      size,
    size_t                                      alignment,
    VkSystemAllocationScope                     allocationScope);
	alias PFN_vkReallocationFunction = void* function(
    void*                                       pUserData,
    void*                                       pOriginal,
    size_t                                      size,
    size_t                                      alignment,
    VkSystemAllocationScope                     allocationScope);
	alias PFN_vkFreeFunction = void function(
    void*                                       pUserData,
    void*                                       pMemory);
	enum VkInternalAllocationType {
		VK_INTERNAL_ALLOCATION_TYPE_EXECUTABLE = 0,
	}
	alias PFN_vkInternalAllocationNotification = void function(
    void*                                       pUserData,
    size_t                                      size,
    VkInternalAllocationType                    allocationType,
    VkSystemAllocationScope                     allocationScope);
	alias PFN_vkInternalFreeNotification = void function(
    void*                                       pUserData,
    size_t                                      size,
    VkInternalAllocationType                    allocationType,
    VkSystemAllocationScope                     allocationScope);
	struct VkAllocationCallbacks {
		void* pUserData;
		PFN_vkAllocationFunction pfnAllocation;
		PFN_vkReallocationFunction pfnReallocation;
		PFN_vkFreeFunction pfnFree;
		PFN_vkInternalAllocationNotification pfnInternalAllocation;
		PFN_vkInternalFreeNotification pfnInternalFree;
	}
	mixin(VK_DEFINE_HANDLE!q{VkInstance});
	mixin(VK_DEFINE_HANDLE!q{VkPhysicalDevice});
	alias VkBool32 = uint32_t;
	struct VkPhysicalDeviceFeatures {
		VkBool32 robustBufferAccess;
		VkBool32 fullDrawIndexUint32;
		VkBool32 imageCubeArray;
		VkBool32 independentBlend;
		VkBool32 geometryShader;
		VkBool32 tessellationShader;
		VkBool32 sampleRateShading;
		VkBool32 dualSrcBlend;
		VkBool32 logicOp;
		VkBool32 multiDrawIndirect;
		VkBool32 drawIndirectFirstInstance;
		VkBool32 depthClamp;
		VkBool32 depthBiasClamp;
		VkBool32 fillModeNonSolid;
		VkBool32 depthBounds;
		VkBool32 wideLines;
		VkBool32 largePoints;
		VkBool32 alphaToOne;
		VkBool32 multiViewport;
		VkBool32 samplerAnisotropy;
		VkBool32 textureCompressionETC2;
		VkBool32 textureCompressionASTC_LDR;
		VkBool32 textureCompressionBC;
		VkBool32 occlusionQueryPrecise;
		VkBool32 pipelineStatisticsQuery;
		VkBool32 vertexPipelineStoresAndAtomics;
		VkBool32 fragmentStoresAndAtomics;
		VkBool32 shaderTessellationAndGeometryPointSize;
		VkBool32 shaderImageGatherExtended;
		VkBool32 shaderStorageImageExtendedFormats;
		VkBool32 shaderStorageImageMultisample;
		VkBool32 shaderStorageImageReadWithoutFormat;
		VkBool32 shaderStorageImageWriteWithoutFormat;
		VkBool32 shaderUniformBufferArrayDynamicIndexing;
		VkBool32 shaderSampledImageArrayDynamicIndexing;
		VkBool32 shaderStorageBufferArrayDynamicIndexing;
		VkBool32 shaderStorageImageArrayDynamicIndexing;
		VkBool32 shaderClipDistance;
		VkBool32 shaderCullDistance;
		VkBool32 shaderFloat64;
		VkBool32 shaderInt64;
		VkBool32 shaderInt16;
		VkBool32 shaderResourceResidency;
		VkBool32 shaderResourceMinLod;
		VkBool32 sparseBinding;
		VkBool32 sparseResidencyBuffer;
		VkBool32 sparseResidencyImage2D;
		VkBool32 sparseResidencyImage3D;
		VkBool32 sparseResidency2Samples;
		VkBool32 sparseResidency4Samples;
		VkBool32 sparseResidency8Samples;
		VkBool32 sparseResidency16Samples;
		VkBool32 sparseResidencyAliased;
		VkBool32 variableMultisampleRate;
		VkBool32 inheritedQueries;
	}
	enum VkFormat {
		VK_FORMAT_UNDEFINED = 0,
		VK_FORMAT_R4G4_UNORM_PACK8 = 1,
		VK_FORMAT_R4G4B4A4_UNORM_PACK16 = 2,
		VK_FORMAT_B4G4R4A4_UNORM_PACK16 = 3,
		VK_FORMAT_R5G6B5_UNORM_PACK16 = 4,
		VK_FORMAT_B5G6R5_UNORM_PACK16 = 5,
		VK_FORMAT_R5G5B5A1_UNORM_PACK16 = 6,
		VK_FORMAT_B5G5R5A1_UNORM_PACK16 = 7,
		VK_FORMAT_A1R5G5B5_UNORM_PACK16 = 8,
		VK_FORMAT_R8_UNORM = 9,
		VK_FORMAT_R8_SNORM = 10,
		VK_FORMAT_R8_USCALED = 11,
		VK_FORMAT_R8_SSCALED = 12,
		VK_FORMAT_R8_UINT = 13,
		VK_FORMAT_R8_SINT = 14,
		VK_FORMAT_R8_SRGB = 15,
		VK_FORMAT_R8G8_UNORM = 16,
		VK_FORMAT_R8G8_SNORM = 17,
		VK_FORMAT_R8G8_USCALED = 18,
		VK_FORMAT_R8G8_SSCALED = 19,
		VK_FORMAT_R8G8_UINT = 20,
		VK_FORMAT_R8G8_SINT = 21,
		VK_FORMAT_R8G8_SRGB = 22,
		VK_FORMAT_R8G8B8_UNORM = 23,
		VK_FORMAT_R8G8B8_SNORM = 24,
		VK_FORMAT_R8G8B8_USCALED = 25,
		VK_FORMAT_R8G8B8_SSCALED = 26,
		VK_FORMAT_R8G8B8_UINT = 27,
		VK_FORMAT_R8G8B8_SINT = 28,
		VK_FORMAT_R8G8B8_SRGB = 29,
		VK_FORMAT_B8G8R8_UNORM = 30,
		VK_FORMAT_B8G8R8_SNORM = 31,
		VK_FORMAT_B8G8R8_USCALED = 32,
		VK_FORMAT_B8G8R8_SSCALED = 33,
		VK_FORMAT_B8G8R8_UINT = 34,
		VK_FORMAT_B8G8R8_SINT = 35,
		VK_FORMAT_B8G8R8_SRGB = 36,
		VK_FORMAT_R8G8B8A8_UNORM = 37,
		VK_FORMAT_R8G8B8A8_SNORM = 38,
		VK_FORMAT_R8G8B8A8_USCALED = 39,
		VK_FORMAT_R8G8B8A8_SSCALED = 40,
		VK_FORMAT_R8G8B8A8_UINT = 41,
		VK_FORMAT_R8G8B8A8_SINT = 42,
		VK_FORMAT_R8G8B8A8_SRGB = 43,
		VK_FORMAT_B8G8R8A8_UNORM = 44,
		VK_FORMAT_B8G8R8A8_SNORM = 45,
		VK_FORMAT_B8G8R8A8_USCALED = 46,
		VK_FORMAT_B8G8R8A8_SSCALED = 47,
		VK_FORMAT_B8G8R8A8_UINT = 48,
		VK_FORMAT_B8G8R8A8_SINT = 49,
		VK_FORMAT_B8G8R8A8_SRGB = 50,
		VK_FORMAT_A8B8G8R8_UNORM_PACK32 = 51,
		VK_FORMAT_A8B8G8R8_SNORM_PACK32 = 52,
		VK_FORMAT_A8B8G8R8_USCALED_PACK32 = 53,
		VK_FORMAT_A8B8G8R8_SSCALED_PACK32 = 54,
		VK_FORMAT_A8B8G8R8_UINT_PACK32 = 55,
		VK_FORMAT_A8B8G8R8_SINT_PACK32 = 56,
		VK_FORMAT_A8B8G8R8_SRGB_PACK32 = 57,
		VK_FORMAT_A2R10G10B10_UNORM_PACK32 = 58,
		VK_FORMAT_A2R10G10B10_SNORM_PACK32 = 59,
		VK_FORMAT_A2R10G10B10_USCALED_PACK32 = 60,
		VK_FORMAT_A2R10G10B10_SSCALED_PACK32 = 61,
		VK_FORMAT_A2R10G10B10_UINT_PACK32 = 62,
		VK_FORMAT_A2R10G10B10_SINT_PACK32 = 63,
		VK_FORMAT_A2B10G10R10_UNORM_PACK32 = 64,
		VK_FORMAT_A2B10G10R10_SNORM_PACK32 = 65,
		VK_FORMAT_A2B10G10R10_USCALED_PACK32 = 66,
		VK_FORMAT_A2B10G10R10_SSCALED_PACK32 = 67,
		VK_FORMAT_A2B10G10R10_UINT_PACK32 = 68,
		VK_FORMAT_A2B10G10R10_SINT_PACK32 = 69,
		VK_FORMAT_R16_UNORM = 70,
		VK_FORMAT_R16_SNORM = 71,
		VK_FORMAT_R16_USCALED = 72,
		VK_FORMAT_R16_SSCALED = 73,
		VK_FORMAT_R16_UINT = 74,
		VK_FORMAT_R16_SINT = 75,
		VK_FORMAT_R16_SFLOAT = 76,
		VK_FORMAT_R16G16_UNORM = 77,
		VK_FORMAT_R16G16_SNORM = 78,
		VK_FORMAT_R16G16_USCALED = 79,
		VK_FORMAT_R16G16_SSCALED = 80,
		VK_FORMAT_R16G16_UINT = 81,
		VK_FORMAT_R16G16_SINT = 82,
		VK_FORMAT_R16G16_SFLOAT = 83,
		VK_FORMAT_R16G16B16_UNORM = 84,
		VK_FORMAT_R16G16B16_SNORM = 85,
		VK_FORMAT_R16G16B16_USCALED = 86,
		VK_FORMAT_R16G16B16_SSCALED = 87,
		VK_FORMAT_R16G16B16_UINT = 88,
		VK_FORMAT_R16G16B16_SINT = 89,
		VK_FORMAT_R16G16B16_SFLOAT = 90,
		VK_FORMAT_R16G16B16A16_UNORM = 91,
		VK_FORMAT_R16G16B16A16_SNORM = 92,
		VK_FORMAT_R16G16B16A16_USCALED = 93,
		VK_FORMAT_R16G16B16A16_SSCALED = 94,
		VK_FORMAT_R16G16B16A16_UINT = 95,
		VK_FORMAT_R16G16B16A16_SINT = 96,
		VK_FORMAT_R16G16B16A16_SFLOAT = 97,
		VK_FORMAT_R32_UINT = 98,
		VK_FORMAT_R32_SINT = 99,
		VK_FORMAT_R32_SFLOAT = 100,
		VK_FORMAT_R32G32_UINT = 101,
		VK_FORMAT_R32G32_SINT = 102,
		VK_FORMAT_R32G32_SFLOAT = 103,
		VK_FORMAT_R32G32B32_UINT = 104,
		VK_FORMAT_R32G32B32_SINT = 105,
		VK_FORMAT_R32G32B32_SFLOAT = 106,
		VK_FORMAT_R32G32B32A32_UINT = 107,
		VK_FORMAT_R32G32B32A32_SINT = 108,
		VK_FORMAT_R32G32B32A32_SFLOAT = 109,
		VK_FORMAT_R64_UINT = 110,
		VK_FORMAT_R64_SINT = 111,
		VK_FORMAT_R64_SFLOAT = 112,
		VK_FORMAT_R64G64_UINT = 113,
		VK_FORMAT_R64G64_SINT = 114,
		VK_FORMAT_R64G64_SFLOAT = 115,
		VK_FORMAT_R64G64B64_UINT = 116,
		VK_FORMAT_R64G64B64_SINT = 117,
		VK_FORMAT_R64G64B64_SFLOAT = 118,
		VK_FORMAT_R64G64B64A64_UINT = 119,
		VK_FORMAT_R64G64B64A64_SINT = 120,
		VK_FORMAT_R64G64B64A64_SFLOAT = 121,
		VK_FORMAT_B10G11R11_UFLOAT_PACK32 = 122,
		VK_FORMAT_E5B9G9R9_UFLOAT_PACK32 = 123,
		VK_FORMAT_D16_UNORM = 124,
		VK_FORMAT_X8_D24_UNORM_PACK32 = 125,
		VK_FORMAT_D32_SFLOAT = 126,
		VK_FORMAT_S8_UINT = 127,
		VK_FORMAT_D16_UNORM_S8_UINT = 128,
		VK_FORMAT_D24_UNORM_S8_UINT = 129,
		VK_FORMAT_D32_SFLOAT_S8_UINT = 130,
		VK_FORMAT_BC1_RGB_UNORM_BLOCK = 131,
		VK_FORMAT_BC1_RGB_SRGB_BLOCK = 132,
		VK_FORMAT_BC1_RGBA_UNORM_BLOCK = 133,
		VK_FORMAT_BC1_RGBA_SRGB_BLOCK = 134,
		VK_FORMAT_BC2_UNORM_BLOCK = 135,
		VK_FORMAT_BC2_SRGB_BLOCK = 136,
		VK_FORMAT_BC3_UNORM_BLOCK = 137,
		VK_FORMAT_BC3_SRGB_BLOCK = 138,
		VK_FORMAT_BC4_UNORM_BLOCK = 139,
		VK_FORMAT_BC4_SNORM_BLOCK = 140,
		VK_FORMAT_BC5_UNORM_BLOCK = 141,
		VK_FORMAT_BC5_SNORM_BLOCK = 142,
		VK_FORMAT_BC6H_UFLOAT_BLOCK = 143,
		VK_FORMAT_BC6H_SFLOAT_BLOCK = 144,
		VK_FORMAT_BC7_UNORM_BLOCK = 145,
		VK_FORMAT_BC7_SRGB_BLOCK = 146,
		VK_FORMAT_ETC2_R8G8B8_UNORM_BLOCK = 147,
		VK_FORMAT_ETC2_R8G8B8_SRGB_BLOCK = 148,
		VK_FORMAT_ETC2_R8G8B8A1_UNORM_BLOCK = 149,
		VK_FORMAT_ETC2_R8G8B8A1_SRGB_BLOCK = 150,
		VK_FORMAT_ETC2_R8G8B8A8_UNORM_BLOCK = 151,
		VK_FORMAT_ETC2_R8G8B8A8_SRGB_BLOCK = 152,
		VK_FORMAT_EAC_R11_UNORM_BLOCK = 153,
		VK_FORMAT_EAC_R11_SNORM_BLOCK = 154,
		VK_FORMAT_EAC_R11G11_UNORM_BLOCK = 155,
		VK_FORMAT_EAC_R11G11_SNORM_BLOCK = 156,
		VK_FORMAT_ASTC_4x4_UNORM_BLOCK = 157,
		VK_FORMAT_ASTC_4x4_SRGB_BLOCK = 158,
		VK_FORMAT_ASTC_5x4_UNORM_BLOCK = 159,
		VK_FORMAT_ASTC_5x4_SRGB_BLOCK = 160,
		VK_FORMAT_ASTC_5x5_UNORM_BLOCK = 161,
		VK_FORMAT_ASTC_5x5_SRGB_BLOCK = 162,
		VK_FORMAT_ASTC_6x5_UNORM_BLOCK = 163,
		VK_FORMAT_ASTC_6x5_SRGB_BLOCK = 164,
		VK_FORMAT_ASTC_6x6_UNORM_BLOCK = 165,
		VK_FORMAT_ASTC_6x6_SRGB_BLOCK = 166,
		VK_FORMAT_ASTC_8x5_UNORM_BLOCK = 167,
		VK_FORMAT_ASTC_8x5_SRGB_BLOCK = 168,
		VK_FORMAT_ASTC_8x6_UNORM_BLOCK = 169,
		VK_FORMAT_ASTC_8x6_SRGB_BLOCK = 170,
		VK_FORMAT_ASTC_8x8_UNORM_BLOCK = 171,
		VK_FORMAT_ASTC_8x8_SRGB_BLOCK = 172,
		VK_FORMAT_ASTC_10x5_UNORM_BLOCK = 173,
		VK_FORMAT_ASTC_10x5_SRGB_BLOCK = 174,
		VK_FORMAT_ASTC_10x6_UNORM_BLOCK = 175,
		VK_FORMAT_ASTC_10x6_SRGB_BLOCK = 176,
		VK_FORMAT_ASTC_10x8_UNORM_BLOCK = 177,
		VK_FORMAT_ASTC_10x8_SRGB_BLOCK = 178,
		VK_FORMAT_ASTC_10x10_UNORM_BLOCK = 179,
		VK_FORMAT_ASTC_10x10_SRGB_BLOCK = 180,
		VK_FORMAT_ASTC_12x10_UNORM_BLOCK = 181,
		VK_FORMAT_ASTC_12x10_SRGB_BLOCK = 182,
		VK_FORMAT_ASTC_12x12_UNORM_BLOCK = 183,
		VK_FORMAT_ASTC_12x12_SRGB_BLOCK = 184,
	}
	enum VkFormatFeatureFlagBits {
		VK_FORMAT_FEATURE_SAMPLED_IMAGE_BIT = 0x00000001,
		VK_FORMAT_FEATURE_STORAGE_IMAGE_BIT = 0x00000002,
		VK_FORMAT_FEATURE_STORAGE_IMAGE_ATOMIC_BIT = 0x00000004,
		VK_FORMAT_FEATURE_UNIFORM_TEXEL_BUFFER_BIT = 0x00000008,
		VK_FORMAT_FEATURE_STORAGE_TEXEL_BUFFER_BIT = 0x00000010,
		VK_FORMAT_FEATURE_STORAGE_TEXEL_BUFFER_ATOMIC_BIT = 0x00000020,
		VK_FORMAT_FEATURE_VERTEX_BUFFER_BIT = 0x00000040,
		VK_FORMAT_FEATURE_COLOR_ATTACHMENT_BIT = 0x00000080,
		VK_FORMAT_FEATURE_COLOR_ATTACHMENT_BLEND_BIT = 0x00000100,
		VK_FORMAT_FEATURE_DEPTH_STENCIL_ATTACHMENT_BIT = 0x00000200,
		VK_FORMAT_FEATURE_BLIT_SRC_BIT = 0x00000400,
		VK_FORMAT_FEATURE_BLIT_DST_BIT = 0x00000800,
		VK_FORMAT_FEATURE_SAMPLED_IMAGE_FILTER_LINEAR_BIT = 0x00001000,
		VK_FORMAT_FEATURE_SAMPLED_IMAGE_FILTER_CUBIC_BIT_IMG = 0x00002000,
	}
	alias VkFormatFeatureFlags = VkFlags;
	struct VkFormatProperties {
		VkFormatFeatureFlags linearTilingFeatures;
		VkFormatFeatureFlags optimalTilingFeatures;
		VkFormatFeatureFlags bufferFeatures;
	}
	enum VkImageType {
		VK_IMAGE_TYPE_1D = 0,
		VK_IMAGE_TYPE_2D = 1,
		VK_IMAGE_TYPE_3D = 2,
	}
	enum VkImageTiling {
		VK_IMAGE_TILING_OPTIMAL = 0,
		VK_IMAGE_TILING_LINEAR = 1,
	}
	enum VkImageUsageFlagBits {
		VK_IMAGE_USAGE_TRANSFER_SRC_BIT = 0x00000001,
		VK_IMAGE_USAGE_TRANSFER_DST_BIT = 0x00000002,
		VK_IMAGE_USAGE_SAMPLED_BIT = 0x00000004,
		VK_IMAGE_USAGE_STORAGE_BIT = 0x00000008,
		VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT = 0x00000010,
		VK_IMAGE_USAGE_DEPTH_STENCIL_ATTACHMENT_BIT = 0x00000020,
		VK_IMAGE_USAGE_TRANSIENT_ATTACHMENT_BIT = 0x00000040,
		VK_IMAGE_USAGE_INPUT_ATTACHMENT_BIT = 0x00000080,
	}
	alias VkImageUsageFlags = VkFlags;
	enum VkImageCreateFlagBits {
		VK_IMAGE_CREATE_SPARSE_BINDING_BIT = 0x00000001,
		VK_IMAGE_CREATE_SPARSE_RESIDENCY_BIT = 0x00000002,
		VK_IMAGE_CREATE_SPARSE_ALIASED_BIT = 0x00000004,
		VK_IMAGE_CREATE_MUTABLE_FORMAT_BIT = 0x00000008,
		VK_IMAGE_CREATE_CUBE_COMPATIBLE_BIT = 0x00000010,
	}
	alias VkImageCreateFlags = VkFlags;
	struct VkExtent3D {
		uint32_t width;
		uint32_t height;
		uint32_t depth;
	}
	enum VkSampleCountFlagBits {
		VK_SAMPLE_COUNT_1_BIT = 0x00000001,
		VK_SAMPLE_COUNT_2_BIT = 0x00000002,
		VK_SAMPLE_COUNT_4_BIT = 0x00000004,
		VK_SAMPLE_COUNT_8_BIT = 0x00000008,
		VK_SAMPLE_COUNT_16_BIT = 0x00000010,
		VK_SAMPLE_COUNT_32_BIT = 0x00000020,
		VK_SAMPLE_COUNT_64_BIT = 0x00000040,
	}
	alias VkSampleCountFlags = VkFlags;
	alias VkDeviceSize = uint64_t;
	struct VkImageFormatProperties {
		VkExtent3D maxExtent;
		uint32_t maxMipLevels;
		uint32_t maxArrayLayers;
		VkSampleCountFlags sampleCounts;
		VkDeviceSize maxResourceSize;
	}
	enum VkPhysicalDeviceType {
		VK_PHYSICAL_DEVICE_TYPE_OTHER = 0,
		VK_PHYSICAL_DEVICE_TYPE_INTEGRATED_GPU = 1,
		VK_PHYSICAL_DEVICE_TYPE_DISCRETE_GPU = 2,
		VK_PHYSICAL_DEVICE_TYPE_VIRTUAL_GPU = 3,
		VK_PHYSICAL_DEVICE_TYPE_CPU = 4,
	}
	struct VkPhysicalDeviceLimits {
		uint32_t maxImageDimension1D;
		uint32_t maxImageDimension2D;
		uint32_t maxImageDimension3D;
		uint32_t maxImageDimensionCube;
		uint32_t maxImageArrayLayers;
		uint32_t maxTexelBufferElements;
		uint32_t maxUniformBufferRange;
		uint32_t maxStorageBufferRange;
		uint32_t maxPushConstantsSize;
		uint32_t maxMemoryAllocationCount;
		uint32_t maxSamplerAllocationCount;
		VkDeviceSize bufferImageGranularity;
		VkDeviceSize sparseAddressSpaceSize;
		uint32_t maxBoundDescriptorSets;
		uint32_t maxPerStageDescriptorSamplers;
		uint32_t maxPerStageDescriptorUniformBuffers;
		uint32_t maxPerStageDescriptorStorageBuffers;
		uint32_t maxPerStageDescriptorSampledImages;
		uint32_t maxPerStageDescriptorStorageImages;
		uint32_t maxPerStageDescriptorInputAttachments;
		uint32_t maxPerStageResources;
		uint32_t maxDescriptorSetSamplers;
		uint32_t maxDescriptorSetUniformBuffers;
		uint32_t maxDescriptorSetUniformBuffersDynamic;
		uint32_t maxDescriptorSetStorageBuffers;
		uint32_t maxDescriptorSetStorageBuffersDynamic;
		uint32_t maxDescriptorSetSampledImages;
		uint32_t maxDescriptorSetStorageImages;
		uint32_t maxDescriptorSetInputAttachments;
		uint32_t maxVertexInputAttributes;
		uint32_t maxVertexInputBindings;
		uint32_t maxVertexInputAttributeOffset;
		uint32_t maxVertexInputBindingStride;
		uint32_t maxVertexOutputComponents;
		uint32_t maxTessellationGenerationLevel;
		uint32_t maxTessellationPatchSize;
		uint32_t maxTessellationControlPerVertexInputComponents;
		uint32_t maxTessellationControlPerVertexOutputComponents;
		uint32_t maxTessellationControlPerPatchOutputComponents;
		uint32_t maxTessellationControlTotalOutputComponents;
		uint32_t maxTessellationEvaluationInputComponents;
		uint32_t maxTessellationEvaluationOutputComponents;
		uint32_t maxGeometryShaderInvocations;
		uint32_t maxGeometryInputComponents;
		uint32_t maxGeometryOutputComponents;
		uint32_t maxGeometryOutputVertices;
		uint32_t maxGeometryTotalOutputComponents;
		uint32_t maxFragmentInputComponents;
		uint32_t maxFragmentOutputAttachments;
		uint32_t maxFragmentDualSrcAttachments;
		uint32_t maxFragmentCombinedOutputResources;
		uint32_t maxComputeSharedMemorySize;
		uint32_t[3] maxComputeWorkGroupCount;
		uint32_t maxComputeWorkGroupInvocations;
		uint32_t[3] maxComputeWorkGroupSize;
		uint32_t subPixelPrecisionBits;
		uint32_t subTexelPrecisionBits;
		uint32_t mipmapPrecisionBits;
		uint32_t maxDrawIndexedIndexValue;
		uint32_t maxDrawIndirectCount;
		float maxSamplerLodBias;
		float maxSamplerAnisotropy;
		uint32_t maxViewports;
		uint32_t[2] maxViewportDimensions;
		float[2] viewportBoundsRange;
		uint32_t viewportSubPixelBits;
		size_t minMemoryMapAlignment;
		VkDeviceSize minTexelBufferOffsetAlignment;
		VkDeviceSize minUniformBufferOffsetAlignment;
		VkDeviceSize minStorageBufferOffsetAlignment;
		int32_t minTexelOffset;
		uint32_t maxTexelOffset;
		int32_t minTexelGatherOffset;
		uint32_t maxTexelGatherOffset;
		float minInterpolationOffset;
		float maxInterpolationOffset;
		uint32_t subPixelInterpolationOffsetBits;
		uint32_t maxFramebufferWidth;
		uint32_t maxFramebufferHeight;
		uint32_t maxFramebufferLayers;
		VkSampleCountFlags framebufferColorSampleCounts;
		VkSampleCountFlags framebufferDepthSampleCounts;
		VkSampleCountFlags framebufferStencilSampleCounts;
		VkSampleCountFlags framebufferNoAttachmentsSampleCounts;
		uint32_t maxColorAttachments;
		VkSampleCountFlags sampledImageColorSampleCounts;
		VkSampleCountFlags sampledImageIntegerSampleCounts;
		VkSampleCountFlags sampledImageDepthSampleCounts;
		VkSampleCountFlags sampledImageStencilSampleCounts;
		VkSampleCountFlags storageImageSampleCounts;
		uint32_t maxSampleMaskWords;
		VkBool32 timestampComputeAndGraphics;
		float timestampPeriod;
		uint32_t maxClipDistances;
		uint32_t maxCullDistances;
		uint32_t maxCombinedClipAndCullDistances;
		uint32_t discreteQueuePriorities;
		float[2] pointSizeRange;
		float[2] lineWidthRange;
		float pointSizeGranularity;
		float lineWidthGranularity;
		VkBool32 strictLines;
		VkBool32 standardSampleLocations;
		VkDeviceSize optimalBufferCopyOffsetAlignment;
		VkDeviceSize optimalBufferCopyRowPitchAlignment;
		VkDeviceSize nonCoherentAtomSize;
	}
	struct VkPhysicalDeviceSparseProperties {
		VkBool32 residencyStandard2DBlockShape;
		VkBool32 residencyStandard2DMultisampleBlockShape;
		VkBool32 residencyStandard3DBlockShape;
		VkBool32 residencyAlignedMipSize;
		VkBool32 residencyNonResidentStrict;
	}
	enum VK_MAX_PHYSICAL_DEVICE_NAME_SIZE = 256;
	enum VK_UUID_SIZE = 16;
	struct VkPhysicalDeviceProperties {
		uint32_t apiVersion;
		uint32_t driverVersion;
		uint32_t vendorID;
		uint32_t deviceID;
		VkPhysicalDeviceType deviceType;
		char[VK_MAX_PHYSICAL_DEVICE_NAME_SIZE] deviceName;
		uint8_t[VK_UUID_SIZE] pipelineCacheUUID;
		VkPhysicalDeviceLimits limits;
		VkPhysicalDeviceSparseProperties sparseProperties;
	}
	enum VkQueueFlagBits {
		VK_QUEUE_GRAPHICS_BIT = 0x00000001,
		VK_QUEUE_COMPUTE_BIT = 0x00000002,
		VK_QUEUE_TRANSFER_BIT = 0x00000004,
		VK_QUEUE_SPARSE_BINDING_BIT = 0x00000008,
	}
	alias VkQueueFlags = VkFlags;
	struct VkQueueFamilyProperties {
		VkQueueFlags queueFlags;
		uint32_t queueCount;
		uint32_t timestampValidBits;
		VkExtent3D minImageTransferGranularity;
	}
	enum VkMemoryPropertyFlagBits {
		VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT = 0x00000001,
		VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT = 0x00000002,
		VK_MEMORY_PROPERTY_HOST_COHERENT_BIT = 0x00000004,
		VK_MEMORY_PROPERTY_HOST_CACHED_BIT = 0x00000008,
		VK_MEMORY_PROPERTY_LAZILY_ALLOCATED_BIT = 0x00000010,
	}
	alias VkMemoryPropertyFlags = VkFlags;
	struct VkMemoryType {
		VkMemoryPropertyFlags propertyFlags;
		uint32_t heapIndex;
	}
	enum VkMemoryHeapFlagBits {
		VK_MEMORY_HEAP_DEVICE_LOCAL_BIT = 0x00000001,
	}
	alias VkMemoryHeapFlags = VkFlags;
	struct VkMemoryHeap {
		VkDeviceSize size;
		VkMemoryHeapFlags flags;
	}
	enum VK_MAX_MEMORY_TYPES = 32;
	enum VK_MAX_MEMORY_HEAPS = 16;
	struct VkPhysicalDeviceMemoryProperties {
		uint32_t memoryTypeCount;
		VkMemoryType[VK_MAX_MEMORY_TYPES] memoryTypes;
		uint32_t memoryHeapCount;
		VkMemoryHeap[VK_MAX_MEMORY_HEAPS] memoryHeaps;
	}
	alias PFN_vkVoidFunction = void function();
	mixin(VK_DEFINE_HANDLE!q{VkDevice});
	alias VkDeviceCreateFlags = VkFlags;
	alias VkDeviceQueueCreateFlags = VkFlags;
	struct VkDeviceQueueCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_DEVICE_QUEUE_CREATE_INFO;
		const(void)* pNext;
		VkDeviceQueueCreateFlags flags;
		uint32_t queueFamilyIndex;
		uint32_t queueCount;
		const(float)* pQueuePriorities;
	}
	struct VkDeviceCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_DEVICE_CREATE_INFO;
		const(void)* pNext;
		VkDeviceCreateFlags flags;
		uint32_t queueCreateInfoCount;
		const(VkDeviceQueueCreateInfo)* pQueueCreateInfos;
		uint32_t enabledLayerCount;
		const(char*)* ppEnabledLayerNames;
		uint32_t enabledExtensionCount;
		const(char*)* ppEnabledExtensionNames;
		const(VkPhysicalDeviceFeatures)* pEnabledFeatures;
	}
	enum VK_MAX_EXTENSION_NAME_SIZE = 256;
	struct VkExtensionProperties {
		char[VK_MAX_EXTENSION_NAME_SIZE] extensionName;
		uint32_t specVersion;
	}
	enum VK_MAX_DESCRIPTION_SIZE = 256;
	struct VkLayerProperties {
		char[VK_MAX_EXTENSION_NAME_SIZE] layerName;
		uint32_t specVersion;
		uint32_t implementationVersion;
		char[VK_MAX_DESCRIPTION_SIZE] description;
	}
	mixin(VK_DEFINE_HANDLE!q{VkQueue});
	mixin(VK_DEFINE_NON_DISPATCHABLE_HANDLE!q{VkSemaphore});
	enum VkPipelineStageFlagBits {
		VK_PIPELINE_STAGE_TOP_OF_PIPE_BIT = 0x00000001,
		VK_PIPELINE_STAGE_DRAW_INDIRECT_BIT = 0x00000002,
		VK_PIPELINE_STAGE_VERTEX_INPUT_BIT = 0x00000004,
		VK_PIPELINE_STAGE_VERTEX_SHADER_BIT = 0x00000008,
		VK_PIPELINE_STAGE_TESSELLATION_CONTROL_SHADER_BIT = 0x00000010,
		VK_PIPELINE_STAGE_TESSELLATION_EVALUATION_SHADER_BIT = 0x00000020,
		VK_PIPELINE_STAGE_GEOMETRY_SHADER_BIT = 0x00000040,
		VK_PIPELINE_STAGE_FRAGMENT_SHADER_BIT = 0x00000080,
		VK_PIPELINE_STAGE_EARLY_FRAGMENT_TESTS_BIT = 0x00000100,
		VK_PIPELINE_STAGE_LATE_FRAGMENT_TESTS_BIT = 0x00000200,
		VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT = 0x00000400,
		VK_PIPELINE_STAGE_COMPUTE_SHADER_BIT = 0x00000800,
		VK_PIPELINE_STAGE_TRANSFER_BIT = 0x00001000,
		VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT = 0x00002000,
		VK_PIPELINE_STAGE_HOST_BIT = 0x00004000,
		VK_PIPELINE_STAGE_ALL_GRAPHICS_BIT = 0x00008000,
		VK_PIPELINE_STAGE_ALL_COMMANDS_BIT = 0x00010000,
	}
	alias VkPipelineStageFlags = VkFlags;
	mixin(VK_DEFINE_HANDLE!q{VkCommandBuffer});
	struct VkSubmitInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_SUBMIT_INFO;
		const(void)* pNext;
		uint32_t waitSemaphoreCount;
		const(VkSemaphore)* pWaitSemaphores;
		const(VkPipelineStageFlags)* pWaitDstStageMask;
		uint32_t commandBufferCount;
		const(VkCommandBuffer)* pCommandBuffers;
		uint32_t signalSemaphoreCount;
		const(VkSemaphore)* pSignalSemaphores;
	}
	mixin(VK_DEFINE_NON_DISPATCHABLE_HANDLE!q{VkFence});
	struct VkMemoryAllocateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_INFO;
		const(void)* pNext;
		VkDeviceSize allocationSize;
		uint32_t memoryTypeIndex;
	}
	mixin(VK_DEFINE_NON_DISPATCHABLE_HANDLE!q{VkDeviceMemory});
	alias VkMemoryMapFlags = VkFlags;
	struct VkMappedMemoryRange {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_MAPPED_MEMORY_RANGE;
		const(void)* pNext;
		VkDeviceMemory memory;
		VkDeviceSize offset;
		VkDeviceSize size;
	}
	mixin(VK_DEFINE_NON_DISPATCHABLE_HANDLE!q{VkBuffer});
	mixin(VK_DEFINE_NON_DISPATCHABLE_HANDLE!q{VkImage});
	struct VkMemoryRequirements {
		VkDeviceSize size;
		VkDeviceSize alignment;
		uint32_t memoryTypeBits;
	}
	enum VkImageAspectFlagBits {
		VK_IMAGE_ASPECT_COLOR_BIT = 0x00000001,
		VK_IMAGE_ASPECT_DEPTH_BIT = 0x00000002,
		VK_IMAGE_ASPECT_STENCIL_BIT = 0x00000004,
		VK_IMAGE_ASPECT_METADATA_BIT = 0x00000008,
	}
	alias VkImageAspectFlags = VkFlags;
	enum VkSparseImageFormatFlagBits {
		VK_SPARSE_IMAGE_FORMAT_SINGLE_MIPTAIL_BIT = 0x00000001,
		VK_SPARSE_IMAGE_FORMAT_ALIGNED_MIP_SIZE_BIT = 0x00000002,
		VK_SPARSE_IMAGE_FORMAT_NONSTANDARD_BLOCK_SIZE_BIT = 0x00000004,
	}
	alias VkSparseImageFormatFlags = VkFlags;
	struct VkSparseImageFormatProperties {
		VkImageAspectFlags aspectMask;
		VkExtent3D imageGranularity;
		VkSparseImageFormatFlags flags;
	}
	struct VkSparseImageMemoryRequirements {
		VkSparseImageFormatProperties formatProperties;
		uint32_t imageMipTailFirstLod;
		VkDeviceSize imageMipTailSize;
		VkDeviceSize imageMipTailOffset;
		VkDeviceSize imageMipTailStride;
	}
	enum VkSparseMemoryBindFlagBits {
		VK_SPARSE_MEMORY_BIND_METADATA_BIT = 0x00000001,
	}
	alias VkSparseMemoryBindFlags = VkFlags;
	struct VkSparseMemoryBind {
		VkDeviceSize resourceOffset;
		VkDeviceSize size;
		VkDeviceMemory memory;
		VkDeviceSize memoryOffset;
		VkSparseMemoryBindFlags flags;
	}
	struct VkSparseBufferMemoryBindInfo {
		VkBuffer buffer;
		uint32_t bindCount;
		const(VkSparseMemoryBind)* pBinds;
	}
	struct VkSparseImageOpaqueMemoryBindInfo {
		VkImage image;
		uint32_t bindCount;
		const(VkSparseMemoryBind)* pBinds;
	}
	struct VkImageSubresource {
		VkImageAspectFlags aspectMask;
		uint32_t mipLevel;
		uint32_t arrayLayer;
	}
	struct VkOffset3D {
		int32_t x;
		int32_t y;
		int32_t z;
	}
	struct VkSparseImageMemoryBind {
		VkImageSubresource subresource;
		VkOffset3D offset;
		VkExtent3D extent;
		VkDeviceMemory memory;
		VkDeviceSize memoryOffset;
		VkSparseMemoryBindFlags flags;
	}
	struct VkSparseImageMemoryBindInfo {
		VkImage image;
		uint32_t bindCount;
		const(VkSparseImageMemoryBind)* pBinds;
	}
	struct VkBindSparseInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_BIND_SPARSE_INFO;
		const(void)* pNext;
		uint32_t waitSemaphoreCount;
		const(VkSemaphore)* pWaitSemaphores;
		uint32_t bufferBindCount;
		const(VkSparseBufferMemoryBindInfo)* pBufferBinds;
		uint32_t imageOpaqueBindCount;
		const(VkSparseImageOpaqueMemoryBindInfo)* pImageOpaqueBinds;
		uint32_t imageBindCount;
		const(VkSparseImageMemoryBindInfo)* pImageBinds;
		uint32_t signalSemaphoreCount;
		const(VkSemaphore)* pSignalSemaphores;
	}
	enum VkFenceCreateFlagBits {
		VK_FENCE_CREATE_SIGNALED_BIT = 0x00000001,
	}
	alias VkFenceCreateFlags = VkFlags;
	struct VkFenceCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_FENCE_CREATE_INFO;
		const(void)* pNext;
		VkFenceCreateFlags flags;
	}
	alias VkSemaphoreCreateFlags = VkFlags;
	struct VkSemaphoreCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_SEMAPHORE_CREATE_INFO;
		const(void)* pNext;
		VkSemaphoreCreateFlags flags;
	}
	alias VkEventCreateFlags = VkFlags;
	struct VkEventCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_EVENT_CREATE_INFO;
		const(void)* pNext;
		VkEventCreateFlags flags;
	}
	mixin(VK_DEFINE_NON_DISPATCHABLE_HANDLE!q{VkEvent});
	alias VkQueryPoolCreateFlags = VkFlags;
	enum VkQueryType {
		VK_QUERY_TYPE_OCCLUSION = 0,
		VK_QUERY_TYPE_PIPELINE_STATISTICS = 1,
		VK_QUERY_TYPE_TIMESTAMP = 2,
	}
	enum VkQueryPipelineStatisticFlagBits {
		VK_QUERY_PIPELINE_STATISTIC_INPUT_ASSEMBLY_VERTICES_BIT = 0x00000001,
		VK_QUERY_PIPELINE_STATISTIC_INPUT_ASSEMBLY_PRIMITIVES_BIT = 0x00000002,
		VK_QUERY_PIPELINE_STATISTIC_VERTEX_SHADER_INVOCATIONS_BIT = 0x00000004,
		VK_QUERY_PIPELINE_STATISTIC_GEOMETRY_SHADER_INVOCATIONS_BIT = 0x00000008,
		VK_QUERY_PIPELINE_STATISTIC_GEOMETRY_SHADER_PRIMITIVES_BIT = 0x00000010,
		VK_QUERY_PIPELINE_STATISTIC_CLIPPING_INVOCATIONS_BIT = 0x00000020,
		VK_QUERY_PIPELINE_STATISTIC_CLIPPING_PRIMITIVES_BIT = 0x00000040,
		VK_QUERY_PIPELINE_STATISTIC_FRAGMENT_SHADER_INVOCATIONS_BIT = 0x00000080,
		VK_QUERY_PIPELINE_STATISTIC_TESSELLATION_CONTROL_SHADER_PATCHES_BIT = 0x00000100,
		VK_QUERY_PIPELINE_STATISTIC_TESSELLATION_EVALUATION_SHADER_INVOCATIONS_BIT = 0x00000200,
		VK_QUERY_PIPELINE_STATISTIC_COMPUTE_SHADER_INVOCATIONS_BIT = 0x00000400,
	}
	alias VkQueryPipelineStatisticFlags = VkFlags;
	struct VkQueryPoolCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_QUERY_POOL_CREATE_INFO;
		const(void)* pNext;
		VkQueryPoolCreateFlags flags;
		VkQueryType queryType;
		uint32_t queryCount;
		VkQueryPipelineStatisticFlags pipelineStatistics;
	}
	mixin(VK_DEFINE_NON_DISPATCHABLE_HANDLE!q{VkQueryPool});
	enum VkQueryResultFlagBits {
		VK_QUERY_RESULT_64_BIT = 0x00000001,
		VK_QUERY_RESULT_WAIT_BIT = 0x00000002,
		VK_QUERY_RESULT_WITH_AVAILABILITY_BIT = 0x00000004,
		VK_QUERY_RESULT_PARTIAL_BIT = 0x00000008,
	}
	alias VkQueryResultFlags = VkFlags;
	enum VkBufferCreateFlagBits {
		VK_BUFFER_CREATE_SPARSE_BINDING_BIT = 0x00000001,
		VK_BUFFER_CREATE_SPARSE_RESIDENCY_BIT = 0x00000002,
		VK_BUFFER_CREATE_SPARSE_ALIASED_BIT = 0x00000004,
	}
	alias VkBufferCreateFlags = VkFlags;
	enum VkBufferUsageFlagBits {
		VK_BUFFER_USAGE_TRANSFER_SRC_BIT = 0x00000001,
		VK_BUFFER_USAGE_TRANSFER_DST_BIT = 0x00000002,
		VK_BUFFER_USAGE_UNIFORM_TEXEL_BUFFER_BIT = 0x00000004,
		VK_BUFFER_USAGE_STORAGE_TEXEL_BUFFER_BIT = 0x00000008,
		VK_BUFFER_USAGE_UNIFORM_BUFFER_BIT = 0x00000010,
		VK_BUFFER_USAGE_STORAGE_BUFFER_BIT = 0x00000020,
		VK_BUFFER_USAGE_INDEX_BUFFER_BIT = 0x00000040,
		VK_BUFFER_USAGE_VERTEX_BUFFER_BIT = 0x00000080,
		VK_BUFFER_USAGE_INDIRECT_BUFFER_BIT = 0x00000100,
	}
	alias VkBufferUsageFlags = VkFlags;
	enum VkSharingMode {
		VK_SHARING_MODE_EXCLUSIVE = 0,
		VK_SHARING_MODE_CONCURRENT = 1,
	}
	struct VkBufferCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_BUFFER_CREATE_INFO;
		const(void)* pNext;
		VkBufferCreateFlags flags;
		VkDeviceSize size;
		VkBufferUsageFlags usage;
		VkSharingMode sharingMode;
		uint32_t queueFamilyIndexCount;
		const(uint32_t)* pQueueFamilyIndices;
	}
	alias VkBufferViewCreateFlags = VkFlags;
	struct VkBufferViewCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_BUFFER_VIEW_CREATE_INFO;
		const(void)* pNext;
		VkBufferViewCreateFlags flags;
		VkBuffer buffer;
		VkFormat format;
		VkDeviceSize offset;
		VkDeviceSize range;
	}
	mixin(VK_DEFINE_NON_DISPATCHABLE_HANDLE!q{VkBufferView});
	enum VkImageLayout {
		VK_IMAGE_LAYOUT_UNDEFINED = 0,
		VK_IMAGE_LAYOUT_GENERAL = 1,
		VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL = 2,
		VK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL = 3,
		VK_IMAGE_LAYOUT_DEPTH_STENCIL_READ_ONLY_OPTIMAL = 4,
		VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL = 5,
		VK_IMAGE_LAYOUT_TRANSFER_SRC_OPTIMAL = 6,
		VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL = 7,
		VK_IMAGE_LAYOUT_PREINITIALIZED = 8,
		VK_IMAGE_LAYOUT_PRESENT_SRC_KHR = 1000001002,
	}
	struct VkImageCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_IMAGE_CREATE_INFO;
		const(void)* pNext;
		VkImageCreateFlags flags;
		VkImageType imageType;
		VkFormat format;
		VkExtent3D extent;
		uint32_t mipLevels;
		uint32_t arrayLayers;
		VkSampleCountFlagBits samples;
		VkImageTiling tiling;
		VkImageUsageFlags usage;
		VkSharingMode sharingMode;
		uint32_t queueFamilyIndexCount;
		const(uint32_t)* pQueueFamilyIndices;
		VkImageLayout initialLayout;
	}
	struct VkSubresourceLayout {
		VkDeviceSize offset;
		VkDeviceSize size;
		VkDeviceSize rowPitch;
		VkDeviceSize arrayPitch;
		VkDeviceSize depthPitch;
	}
	alias VkImageViewCreateFlags = VkFlags;
	enum VkImageViewType {
		VK_IMAGE_VIEW_TYPE_1D = 0,
		VK_IMAGE_VIEW_TYPE_2D = 1,
		VK_IMAGE_VIEW_TYPE_3D = 2,
		VK_IMAGE_VIEW_TYPE_CUBE = 3,
		VK_IMAGE_VIEW_TYPE_1D_ARRAY = 4,
		VK_IMAGE_VIEW_TYPE_2D_ARRAY = 5,
		VK_IMAGE_VIEW_TYPE_CUBE_ARRAY = 6,
	}
	enum VkComponentSwizzle {
		VK_COMPONENT_SWIZZLE_IDENTITY = 0,
		VK_COMPONENT_SWIZZLE_ZERO = 1,
		VK_COMPONENT_SWIZZLE_ONE = 2,
		VK_COMPONENT_SWIZZLE_R = 3,
		VK_COMPONENT_SWIZZLE_G = 4,
		VK_COMPONENT_SWIZZLE_B = 5,
		VK_COMPONENT_SWIZZLE_A = 6,
	}
	struct VkComponentMapping {
		VkComponentSwizzle r;
		VkComponentSwizzle g;
		VkComponentSwizzle b;
		VkComponentSwizzle a;
	}
	struct VkImageSubresourceRange {
		VkImageAspectFlags aspectMask;
		uint32_t baseMipLevel;
		uint32_t levelCount;
		uint32_t baseArrayLayer;
		uint32_t layerCount;
	}
	struct VkImageViewCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_IMAGE_VIEW_CREATE_INFO;
		const(void)* pNext;
		VkImageViewCreateFlags flags;
		VkImage image;
		VkImageViewType viewType;
		VkFormat format;
		VkComponentMapping components;
		VkImageSubresourceRange subresourceRange;
	}
	mixin(VK_DEFINE_NON_DISPATCHABLE_HANDLE!q{VkImageView});
	alias VkShaderModuleCreateFlags = VkFlags;
	struct VkShaderModuleCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_SHADER_MODULE_CREATE_INFO;
		const(void)* pNext;
		VkShaderModuleCreateFlags flags;
		size_t codeSize;
		const(uint32_t)* pCode;
	}
	mixin(VK_DEFINE_NON_DISPATCHABLE_HANDLE!q{VkShaderModule});
	alias VkPipelineCacheCreateFlags = VkFlags;
	struct VkPipelineCacheCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_CACHE_CREATE_INFO;
		const(void)* pNext;
		VkPipelineCacheCreateFlags flags;
		size_t initialDataSize;
		const(void)* pInitialData;
	}
	mixin(VK_DEFINE_NON_DISPATCHABLE_HANDLE!q{VkPipelineCache});
	enum VkPipelineCreateFlagBits {
		VK_PIPELINE_CREATE_DISABLE_OPTIMIZATION_BIT = 0x00000001,
		VK_PIPELINE_CREATE_ALLOW_DERIVATIVES_BIT = 0x00000002,
		VK_PIPELINE_CREATE_DERIVATIVE_BIT = 0x00000004,
	}
	alias VkPipelineCreateFlags = VkFlags;
	alias VkPipelineShaderStageCreateFlags = VkFlags;
	enum VkShaderStageFlagBits {
		VK_SHADER_STAGE_VERTEX_BIT = 0x00000001,
		VK_SHADER_STAGE_TESSELLATION_CONTROL_BIT = 0x00000002,
		VK_SHADER_STAGE_TESSELLATION_EVALUATION_BIT = 0x00000004,
		VK_SHADER_STAGE_GEOMETRY_BIT = 0x00000008,
		VK_SHADER_STAGE_FRAGMENT_BIT = 0x00000010,
		VK_SHADER_STAGE_COMPUTE_BIT = 0x00000020,
		VK_SHADER_STAGE_ALL_GRAPHICS = 0x0000001F,
		VK_SHADER_STAGE_ALL = 0x7FFFFFFF,
	}
	struct VkSpecializationMapEntry {
		uint32_t constantID;
		uint32_t offset;
		size_t size;
	}
	struct VkSpecializationInfo {
		uint32_t mapEntryCount;
		const(VkSpecializationMapEntry)* pMapEntries;
		size_t dataSize;
		const(void)* pData;
	}
	struct VkPipelineShaderStageCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_SHADER_STAGE_CREATE_INFO;
		const(void)* pNext;
		VkPipelineShaderStageCreateFlags flags;
		VkShaderStageFlagBits stage;
		VkShaderModule _module;
		const(char)* pName;
		const(VkSpecializationInfo)* pSpecializationInfo;
	}
	alias VkPipelineVertexInputStateCreateFlags = VkFlags;
	enum VkVertexInputRate {
		VK_VERTEX_INPUT_RATE_VERTEX = 0,
		VK_VERTEX_INPUT_RATE_INSTANCE = 1,
	}
	struct VkVertexInputBindingDescription {
		uint32_t binding;
		uint32_t stride;
		VkVertexInputRate inputRate;
	}
	struct VkVertexInputAttributeDescription {
		uint32_t location;
		uint32_t binding;
		VkFormat format;
		uint32_t offset;
	}
	struct VkPipelineVertexInputStateCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_VERTEX_INPUT_STATE_CREATE_INFO;
		const(void)* pNext;
		VkPipelineVertexInputStateCreateFlags flags;
		uint32_t vertexBindingDescriptionCount;
		const(VkVertexInputBindingDescription)* pVertexBindingDescriptions;
		uint32_t vertexAttributeDescriptionCount;
		const(VkVertexInputAttributeDescription)* pVertexAttributeDescriptions;
	}
	alias VkPipelineInputAssemblyStateCreateFlags = VkFlags;
	enum VkPrimitiveTopology {
		VK_PRIMITIVE_TOPOLOGY_POINT_LIST = 0,
		VK_PRIMITIVE_TOPOLOGY_LINE_LIST = 1,
		VK_PRIMITIVE_TOPOLOGY_LINE_STRIP = 2,
		VK_PRIMITIVE_TOPOLOGY_TRIANGLE_LIST = 3,
		VK_PRIMITIVE_TOPOLOGY_TRIANGLE_STRIP = 4,
		VK_PRIMITIVE_TOPOLOGY_TRIANGLE_FAN = 5,
		VK_PRIMITIVE_TOPOLOGY_LINE_LIST_WITH_ADJACENCY = 6,
		VK_PRIMITIVE_TOPOLOGY_LINE_STRIP_WITH_ADJACENCY = 7,
		VK_PRIMITIVE_TOPOLOGY_TRIANGLE_LIST_WITH_ADJACENCY = 8,
		VK_PRIMITIVE_TOPOLOGY_TRIANGLE_STRIP_WITH_ADJACENCY = 9,
		VK_PRIMITIVE_TOPOLOGY_PATCH_LIST = 10,
	}
	struct VkPipelineInputAssemblyStateCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_INPUT_ASSEMBLY_STATE_CREATE_INFO;
		const(void)* pNext;
		VkPipelineInputAssemblyStateCreateFlags flags;
		VkPrimitiveTopology topology;
		VkBool32 primitiveRestartEnable;
	}
	alias VkPipelineTessellationStateCreateFlags = VkFlags;
	struct VkPipelineTessellationStateCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_TESSELLATION_STATE_CREATE_INFO;
		const(void)* pNext;
		VkPipelineTessellationStateCreateFlags flags;
		uint32_t patchControlPoints;
	}
	alias VkPipelineViewportStateCreateFlags = VkFlags;
	struct VkViewport {
		float x;
		float y;
		float width;
		float height;
		float minDepth;
		float maxDepth;
	}
	struct VkOffset2D {
		int32_t x;
		int32_t y;
	}
	struct VkExtent2D {
		uint32_t width;
		uint32_t height;
	}
	struct VkRect2D {
		VkOffset2D offset;
		VkExtent2D extent;
	}
	struct VkPipelineViewportStateCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_VIEWPORT_STATE_CREATE_INFO;
		const(void)* pNext;
		VkPipelineViewportStateCreateFlags flags;
		uint32_t viewportCount;
		const(VkViewport)* pViewports;
		uint32_t scissorCount;
		const(VkRect2D)* pScissors;
	}
	alias VkPipelineRasterizationStateCreateFlags = VkFlags;
	enum VkPolygonMode {
		VK_POLYGON_MODE_FILL = 0,
		VK_POLYGON_MODE_LINE = 1,
		VK_POLYGON_MODE_POINT = 2,
	}
	enum VkCullModeFlagBits {
		VK_CULL_MODE_NONE = 0,
		VK_CULL_MODE_FRONT_BIT = 0x00000001,
		VK_CULL_MODE_BACK_BIT = 0x00000002,
		VK_CULL_MODE_FRONT_AND_BACK = 0x00000003,
	}
	alias VkCullModeFlags = VkFlags;
	enum VkFrontFace {
		VK_FRONT_FACE_COUNTER_CLOCKWISE = 0,
		VK_FRONT_FACE_CLOCKWISE = 1,
	}
	struct VkPipelineRasterizationStateCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_RASTERIZATION_STATE_CREATE_INFO;
		const(void)* pNext;
		VkPipelineRasterizationStateCreateFlags flags;
		VkBool32 depthClampEnable;
		VkBool32 rasterizerDiscardEnable;
		VkPolygonMode polygonMode;
		VkCullModeFlags cullMode;
		VkFrontFace frontFace;
		VkBool32 depthBiasEnable;
		float depthBiasConstantFactor;
		float depthBiasClamp;
		float depthBiasSlopeFactor;
		float lineWidth;
	}
	alias VkPipelineMultisampleStateCreateFlags = VkFlags;
	alias VkSampleMask = uint32_t;
	struct VkPipelineMultisampleStateCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_MULTISAMPLE_STATE_CREATE_INFO;
		const(void)* pNext;
		VkPipelineMultisampleStateCreateFlags flags;
		VkSampleCountFlagBits rasterizationSamples;
		VkBool32 sampleShadingEnable;
		float minSampleShading;
		const(VkSampleMask)* pSampleMask;
		VkBool32 alphaToCoverageEnable;
		VkBool32 alphaToOneEnable;
	}
	alias VkPipelineDepthStencilStateCreateFlags = VkFlags;
	enum VkCompareOp {
		VK_COMPARE_OP_NEVER = 0,
		VK_COMPARE_OP_LESS = 1,
		VK_COMPARE_OP_EQUAL = 2,
		VK_COMPARE_OP_LESS_OR_EQUAL = 3,
		VK_COMPARE_OP_GREATER = 4,
		VK_COMPARE_OP_NOT_EQUAL = 5,
		VK_COMPARE_OP_GREATER_OR_EQUAL = 6,
		VK_COMPARE_OP_ALWAYS = 7,
	}
	enum VkStencilOp {
		VK_STENCIL_OP_KEEP = 0,
		VK_STENCIL_OP_ZERO = 1,
		VK_STENCIL_OP_REPLACE = 2,
		VK_STENCIL_OP_INCREMENT_AND_CLAMP = 3,
		VK_STENCIL_OP_DECREMENT_AND_CLAMP = 4,
		VK_STENCIL_OP_INVERT = 5,
		VK_STENCIL_OP_INCREMENT_AND_WRAP = 6,
		VK_STENCIL_OP_DECREMENT_AND_WRAP = 7,
	}
	struct VkStencilOpState {
		VkStencilOp failOp;
		VkStencilOp passOp;
		VkStencilOp depthFailOp;
		VkCompareOp compareOp;
		uint32_t compareMask;
		uint32_t writeMask;
		uint32_t reference;
	}
	struct VkPipelineDepthStencilStateCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_DEPTH_STENCIL_STATE_CREATE_INFO;
		const(void)* pNext;
		VkPipelineDepthStencilStateCreateFlags flags;
		VkBool32 depthTestEnable;
		VkBool32 depthWriteEnable;
		VkCompareOp depthCompareOp;
		VkBool32 depthBoundsTestEnable;
		VkBool32 stencilTestEnable;
		VkStencilOpState front;
		VkStencilOpState back;
		float minDepthBounds;
		float maxDepthBounds;
	}
	alias VkPipelineColorBlendStateCreateFlags = VkFlags;
	enum VkLogicOp {
		VK_LOGIC_OP_CLEAR = 0,
		VK_LOGIC_OP_AND = 1,
		VK_LOGIC_OP_AND_REVERSE = 2,
		VK_LOGIC_OP_COPY = 3,
		VK_LOGIC_OP_AND_INVERTED = 4,
		VK_LOGIC_OP_NO_OP = 5,
		VK_LOGIC_OP_XOR = 6,
		VK_LOGIC_OP_OR = 7,
		VK_LOGIC_OP_NOR = 8,
		VK_LOGIC_OP_EQUIVALENT = 9,
		VK_LOGIC_OP_INVERT = 10,
		VK_LOGIC_OP_OR_REVERSE = 11,
		VK_LOGIC_OP_COPY_INVERTED = 12,
		VK_LOGIC_OP_OR_INVERTED = 13,
		VK_LOGIC_OP_NAND = 14,
		VK_LOGIC_OP_SET = 15,
	}
	enum VkBlendFactor {
		VK_BLEND_FACTOR_ZERO = 0,
		VK_BLEND_FACTOR_ONE = 1,
		VK_BLEND_FACTOR_SRC_COLOR = 2,
		VK_BLEND_FACTOR_ONE_MINUS_SRC_COLOR = 3,
		VK_BLEND_FACTOR_DST_COLOR = 4,
		VK_BLEND_FACTOR_ONE_MINUS_DST_COLOR = 5,
		VK_BLEND_FACTOR_SRC_ALPHA = 6,
		VK_BLEND_FACTOR_ONE_MINUS_SRC_ALPHA = 7,
		VK_BLEND_FACTOR_DST_ALPHA = 8,
		VK_BLEND_FACTOR_ONE_MINUS_DST_ALPHA = 9,
		VK_BLEND_FACTOR_CONSTANT_COLOR = 10,
		VK_BLEND_FACTOR_ONE_MINUS_CONSTANT_COLOR = 11,
		VK_BLEND_FACTOR_CONSTANT_ALPHA = 12,
		VK_BLEND_FACTOR_ONE_MINUS_CONSTANT_ALPHA = 13,
		VK_BLEND_FACTOR_SRC_ALPHA_SATURATE = 14,
		VK_BLEND_FACTOR_SRC1_COLOR = 15,
		VK_BLEND_FACTOR_ONE_MINUS_SRC1_COLOR = 16,
		VK_BLEND_FACTOR_SRC1_ALPHA = 17,
		VK_BLEND_FACTOR_ONE_MINUS_SRC1_ALPHA = 18,
	}
	enum VkBlendOp {
		VK_BLEND_OP_ADD = 0,
		VK_BLEND_OP_SUBTRACT = 1,
		VK_BLEND_OP_REVERSE_SUBTRACT = 2,
		VK_BLEND_OP_MIN = 3,
		VK_BLEND_OP_MAX = 4,
	}
	enum VkColorComponentFlagBits {
		VK_COLOR_COMPONENT_R_BIT = 0x00000001,
		VK_COLOR_COMPONENT_G_BIT = 0x00000002,
		VK_COLOR_COMPONENT_B_BIT = 0x00000004,
		VK_COLOR_COMPONENT_A_BIT = 0x00000008,
	}
	alias VkColorComponentFlags = VkFlags;
	struct VkPipelineColorBlendAttachmentState {
		VkBool32 blendEnable;
		VkBlendFactor srcColorBlendFactor;
		VkBlendFactor dstColorBlendFactor;
		VkBlendOp colorBlendOp;
		VkBlendFactor srcAlphaBlendFactor;
		VkBlendFactor dstAlphaBlendFactor;
		VkBlendOp alphaBlendOp;
		VkColorComponentFlags colorWriteMask;
	}
	struct VkPipelineColorBlendStateCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_COLOR_BLEND_STATE_CREATE_INFO;
		const(void)* pNext;
		VkPipelineColorBlendStateCreateFlags flags;
		VkBool32 logicOpEnable;
		VkLogicOp logicOp;
		uint32_t attachmentCount;
		const(VkPipelineColorBlendAttachmentState)* pAttachments;
		float[4] blendConstants;
	}
	alias VkPipelineDynamicStateCreateFlags = VkFlags;
	enum VkDynamicState {
		VK_DYNAMIC_STATE_VIEWPORT = 0,
		VK_DYNAMIC_STATE_SCISSOR = 1,
		VK_DYNAMIC_STATE_LINE_WIDTH = 2,
		VK_DYNAMIC_STATE_DEPTH_BIAS = 3,
		VK_DYNAMIC_STATE_BLEND_CONSTANTS = 4,
		VK_DYNAMIC_STATE_DEPTH_BOUNDS = 5,
		VK_DYNAMIC_STATE_STENCIL_COMPARE_MASK = 6,
		VK_DYNAMIC_STATE_STENCIL_WRITE_MASK = 7,
		VK_DYNAMIC_STATE_STENCIL_REFERENCE = 8,
	}
	struct VkPipelineDynamicStateCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_DYNAMIC_STATE_CREATE_INFO;
		const(void)* pNext;
		VkPipelineDynamicStateCreateFlags flags;
		uint32_t dynamicStateCount;
		const(VkDynamicState)* pDynamicStates;
	}
	mixin(VK_DEFINE_NON_DISPATCHABLE_HANDLE!q{VkPipelineLayout});
	mixin(VK_DEFINE_NON_DISPATCHABLE_HANDLE!q{VkRenderPass});
	mixin(VK_DEFINE_NON_DISPATCHABLE_HANDLE!q{VkPipeline});
	struct VkGraphicsPipelineCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_GRAPHICS_PIPELINE_CREATE_INFO;
		const(void)* pNext;
		VkPipelineCreateFlags flags;
		uint32_t stageCount;
		const(VkPipelineShaderStageCreateInfo)* pStages;
		const(VkPipelineVertexInputStateCreateInfo)* pVertexInputState;
		const(VkPipelineInputAssemblyStateCreateInfo)* pInputAssemblyState;
		const(VkPipelineTessellationStateCreateInfo)* pTessellationState;
		const(VkPipelineViewportStateCreateInfo)* pViewportState;
		const(VkPipelineRasterizationStateCreateInfo)* pRasterizationState;
		const(VkPipelineMultisampleStateCreateInfo)* pMultisampleState;
		const(VkPipelineDepthStencilStateCreateInfo)* pDepthStencilState;
		const(VkPipelineColorBlendStateCreateInfo)* pColorBlendState;
		const(VkPipelineDynamicStateCreateInfo)* pDynamicState;
		VkPipelineLayout layout;
		VkRenderPass renderPass;
		uint32_t subpass;
		VkPipeline basePipelineHandle;
		int32_t basePipelineIndex;
	}
	struct VkComputePipelineCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_COMPUTE_PIPELINE_CREATE_INFO;
		const(void)* pNext;
		VkPipelineCreateFlags flags;
		VkPipelineShaderStageCreateInfo stage;
		VkPipelineLayout layout;
		VkPipeline basePipelineHandle;
		int32_t basePipelineIndex;
	}
	alias VkPipelineLayoutCreateFlags = VkFlags;
	mixin(VK_DEFINE_NON_DISPATCHABLE_HANDLE!q{VkDescriptorSetLayout});
	alias VkShaderStageFlags = VkFlags;
	struct VkPushConstantRange {
		VkShaderStageFlags stageFlags;
		uint32_t offset;
		uint32_t size;
	}
	struct VkPipelineLayoutCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_LAYOUT_CREATE_INFO;
		const(void)* pNext;
		VkPipelineLayoutCreateFlags flags;
		uint32_t setLayoutCount;
		const(VkDescriptorSetLayout)* pSetLayouts;
		uint32_t pushConstantRangeCount;
		const(VkPushConstantRange)* pPushConstantRanges;
	}
	alias VkSamplerCreateFlags = VkFlags;
	enum VkFilter {
		VK_FILTER_NEAREST = 0,
		VK_FILTER_LINEAR = 1,
		VK_FILTER_CUBIC_IMG = 1000015000,
	}
	enum VkSamplerMipmapMode {
		VK_SAMPLER_MIPMAP_MODE_NEAREST = 0,
		VK_SAMPLER_MIPMAP_MODE_LINEAR = 1,
	}
	enum VkSamplerAddressMode {
		VK_SAMPLER_ADDRESS_MODE_REPEAT = 0,
		VK_SAMPLER_ADDRESS_MODE_MIRRORED_REPEAT = 1,
		VK_SAMPLER_ADDRESS_MODE_CLAMP_TO_EDGE = 2,
		VK_SAMPLER_ADDRESS_MODE_CLAMP_TO_BORDER = 3,
		VK_SAMPLER_ADDRESS_MODE_MIRROR_CLAMP_TO_EDGE = 4,
	}
	enum VkBorderColor {
		VK_BORDER_COLOR_FLOAT_TRANSPARENT_BLACK = 0,
		VK_BORDER_COLOR_INT_TRANSPARENT_BLACK = 1,
		VK_BORDER_COLOR_FLOAT_OPAQUE_BLACK = 2,
		VK_BORDER_COLOR_INT_OPAQUE_BLACK = 3,
		VK_BORDER_COLOR_FLOAT_OPAQUE_WHITE = 4,
		VK_BORDER_COLOR_INT_OPAQUE_WHITE = 5,
	}
	struct VkSamplerCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_SAMPLER_CREATE_INFO;
		const(void)* pNext;
		VkSamplerCreateFlags flags;
		VkFilter magFilter;
		VkFilter minFilter;
		VkSamplerMipmapMode mipmapMode;
		VkSamplerAddressMode addressModeU;
		VkSamplerAddressMode addressModeV;
		VkSamplerAddressMode addressModeW;
		float mipLodBias;
		VkBool32 anisotropyEnable;
		float maxAnisotropy;
		VkBool32 compareEnable;
		VkCompareOp compareOp;
		float minLod;
		float maxLod;
		VkBorderColor borderColor;
		VkBool32 unnormalizedCoordinates;
	}
	mixin(VK_DEFINE_NON_DISPATCHABLE_HANDLE!q{VkSampler});
	alias VkDescriptorSetLayoutCreateFlags = VkFlags;
	enum VkDescriptorType {
		VK_DESCRIPTOR_TYPE_SAMPLER = 0,
		VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER = 1,
		VK_DESCRIPTOR_TYPE_SAMPLED_IMAGE = 2,
		VK_DESCRIPTOR_TYPE_STORAGE_IMAGE = 3,
		VK_DESCRIPTOR_TYPE_UNIFORM_TEXEL_BUFFER = 4,
		VK_DESCRIPTOR_TYPE_STORAGE_TEXEL_BUFFER = 5,
		VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER = 6,
		VK_DESCRIPTOR_TYPE_STORAGE_BUFFER = 7,
		VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER_DYNAMIC = 8,
		VK_DESCRIPTOR_TYPE_STORAGE_BUFFER_DYNAMIC = 9,
		VK_DESCRIPTOR_TYPE_INPUT_ATTACHMENT = 10,
	}
	struct VkDescriptorSetLayoutBinding {
		uint32_t binding;
		VkDescriptorType descriptorType;
		uint32_t descriptorCount;
		VkShaderStageFlags stageFlags;
		const(VkSampler)* pImmutableSamplers;
	}
	struct VkDescriptorSetLayoutCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_DESCRIPTOR_SET_LAYOUT_CREATE_INFO;
		const(void)* pNext;
		VkDescriptorSetLayoutCreateFlags flags;
		uint32_t bindingCount;
		const(VkDescriptorSetLayoutBinding)* pBindings;
	}
	enum VkDescriptorPoolCreateFlagBits {
		VK_DESCRIPTOR_POOL_CREATE_FREE_DESCRIPTOR_SET_BIT = 0x00000001,
	}
	alias VkDescriptorPoolCreateFlags = VkFlags;
	struct VkDescriptorPoolSize {
		VkDescriptorType type;
		uint32_t descriptorCount;
	}
	struct VkDescriptorPoolCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_DESCRIPTOR_POOL_CREATE_INFO;
		const(void)* pNext;
		VkDescriptorPoolCreateFlags flags;
		uint32_t maxSets;
		uint32_t poolSizeCount;
		const(VkDescriptorPoolSize)* pPoolSizes;
	}
	mixin(VK_DEFINE_NON_DISPATCHABLE_HANDLE!q{VkDescriptorPool});
	alias VkDescriptorPoolResetFlags = VkFlags;
	struct VkDescriptorSetAllocateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_DESCRIPTOR_SET_ALLOCATE_INFO;
		const(void)* pNext;
		VkDescriptorPool descriptorPool;
		uint32_t descriptorSetCount;
		const(VkDescriptorSetLayout)* pSetLayouts;
	}
	mixin(VK_DEFINE_NON_DISPATCHABLE_HANDLE!q{VkDescriptorSet});
	struct VkDescriptorImageInfo {
		VkSampler sampler;
		VkImageView imageView;
		VkImageLayout imageLayout;
	}
	struct VkDescriptorBufferInfo {
		VkBuffer buffer;
		VkDeviceSize offset;
		VkDeviceSize range;
	}
	struct VkWriteDescriptorSet {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET;
		const(void)* pNext;
		VkDescriptorSet dstSet;
		uint32_t dstBinding;
		uint32_t dstArrayElement;
		uint32_t descriptorCount;
		VkDescriptorType descriptorType;
		const(VkDescriptorImageInfo)* pImageInfo;
		const(VkDescriptorBufferInfo)* pBufferInfo;
		const(VkBufferView)* pTexelBufferView;
	}
	struct VkCopyDescriptorSet {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_COPY_DESCRIPTOR_SET;
		const(void)* pNext;
		VkDescriptorSet srcSet;
		uint32_t srcBinding;
		uint32_t srcArrayElement;
		VkDescriptorSet dstSet;
		uint32_t dstBinding;
		uint32_t dstArrayElement;
		uint32_t descriptorCount;
	}
	alias VkFramebufferCreateFlags = VkFlags;
	struct VkFramebufferCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_FRAMEBUFFER_CREATE_INFO;
		const(void)* pNext;
		VkFramebufferCreateFlags flags;
		VkRenderPass renderPass;
		uint32_t attachmentCount;
		const(VkImageView)* pAttachments;
		uint32_t width;
		uint32_t height;
		uint32_t layers;
	}
	mixin(VK_DEFINE_NON_DISPATCHABLE_HANDLE!q{VkFramebuffer});
	alias VkRenderPassCreateFlags = VkFlags;
	enum VkAttachmentDescriptionFlagBits {
		VK_ATTACHMENT_DESCRIPTION_MAY_ALIAS_BIT = 0x00000001,
	}
	alias VkAttachmentDescriptionFlags = VkFlags;
	enum VkAttachmentLoadOp {
		VK_ATTACHMENT_LOAD_OP_LOAD = 0,
		VK_ATTACHMENT_LOAD_OP_CLEAR = 1,
		VK_ATTACHMENT_LOAD_OP_DONT_CARE = 2,
	}
	enum VkAttachmentStoreOp {
		VK_ATTACHMENT_STORE_OP_STORE = 0,
		VK_ATTACHMENT_STORE_OP_DONT_CARE = 1,
	}
	struct VkAttachmentDescription {
		VkAttachmentDescriptionFlags flags;
		VkFormat format;
		VkSampleCountFlagBits samples;
		VkAttachmentLoadOp loadOp;
		VkAttachmentStoreOp storeOp;
		VkAttachmentLoadOp stencilLoadOp;
		VkAttachmentStoreOp stencilStoreOp;
		VkImageLayout initialLayout;
		VkImageLayout finalLayout;
	}
	alias VkSubpassDescriptionFlags = VkFlags;
	enum VkPipelineBindPoint {
		VK_PIPELINE_BIND_POINT_GRAPHICS = 0,
		VK_PIPELINE_BIND_POINT_COMPUTE = 1,
	}
	struct VkAttachmentReference {
		uint32_t attachment;
		VkImageLayout layout;
	}
	struct VkSubpassDescription {
		VkSubpassDescriptionFlags flags;
		VkPipelineBindPoint pipelineBindPoint;
		uint32_t inputAttachmentCount;
		const(VkAttachmentReference)* pInputAttachments;
		uint32_t colorAttachmentCount;
		const(VkAttachmentReference)* pColorAttachments;
		const(VkAttachmentReference)* pResolveAttachments;
		const(VkAttachmentReference)* pDepthStencilAttachment;
		uint32_t preserveAttachmentCount;
		const(uint32_t)* pPreserveAttachments;
	}
	enum VkAccessFlagBits {
		VK_ACCESS_INDIRECT_COMMAND_READ_BIT = 0x00000001,
		VK_ACCESS_INDEX_READ_BIT = 0x00000002,
		VK_ACCESS_VERTEX_ATTRIBUTE_READ_BIT = 0x00000004,
		VK_ACCESS_UNIFORM_READ_BIT = 0x00000008,
		VK_ACCESS_INPUT_ATTACHMENT_READ_BIT = 0x00000010,
		VK_ACCESS_SHADER_READ_BIT = 0x00000020,
		VK_ACCESS_SHADER_WRITE_BIT = 0x00000040,
		VK_ACCESS_COLOR_ATTACHMENT_READ_BIT = 0x00000080,
		VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT = 0x00000100,
		VK_ACCESS_DEPTH_STENCIL_ATTACHMENT_READ_BIT = 0x00000200,
		VK_ACCESS_DEPTH_STENCIL_ATTACHMENT_WRITE_BIT = 0x00000400,
		VK_ACCESS_TRANSFER_READ_BIT = 0x00000800,
		VK_ACCESS_TRANSFER_WRITE_BIT = 0x00001000,
		VK_ACCESS_HOST_READ_BIT = 0x00002000,
		VK_ACCESS_HOST_WRITE_BIT = 0x00004000,
		VK_ACCESS_MEMORY_READ_BIT = 0x00008000,
		VK_ACCESS_MEMORY_WRITE_BIT = 0x00010000,
	}
	alias VkAccessFlags = VkFlags;
	enum VkDependencyFlagBits {
		VK_DEPENDENCY_BY_REGION_BIT = 0x00000001,
	}
	alias VkDependencyFlags = VkFlags;
	struct VkSubpassDependency {
		uint32_t srcSubpass;
		uint32_t dstSubpass;
		VkPipelineStageFlags srcStageMask;
		VkPipelineStageFlags dstStageMask;
		VkAccessFlags srcAccessMask;
		VkAccessFlags dstAccessMask;
		VkDependencyFlags dependencyFlags;
	}
	struct VkRenderPassCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_RENDER_PASS_CREATE_INFO;
		const(void)* pNext;
		VkRenderPassCreateFlags flags;
		uint32_t attachmentCount;
		const(VkAttachmentDescription)* pAttachments;
		uint32_t subpassCount;
		const(VkSubpassDescription)* pSubpasses;
		uint32_t dependencyCount;
		const(VkSubpassDependency)* pDependencies;
	}
	enum VkCommandPoolCreateFlagBits {
		VK_COMMAND_POOL_CREATE_TRANSIENT_BIT = 0x00000001,
		VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT = 0x00000002,
	}
	alias VkCommandPoolCreateFlags = VkFlags;
	struct VkCommandPoolCreateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_COMMAND_POOL_CREATE_INFO;
		const(void)* pNext;
		VkCommandPoolCreateFlags flags;
		uint32_t queueFamilyIndex;
	}
	mixin(VK_DEFINE_NON_DISPATCHABLE_HANDLE!q{VkCommandPool});
	enum VkCommandPoolResetFlagBits {
		VK_COMMAND_POOL_RESET_RELEASE_RESOURCES_BIT = 0x00000001,
	}
	alias VkCommandPoolResetFlags = VkFlags;
	enum VkCommandBufferLevel {
		VK_COMMAND_BUFFER_LEVEL_PRIMARY = 0,
		VK_COMMAND_BUFFER_LEVEL_SECONDARY = 1,
	}
	struct VkCommandBufferAllocateInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_COMMAND_BUFFER_ALLOCATE_INFO;
		const(void)* pNext;
		VkCommandPool commandPool;
		VkCommandBufferLevel level;
		uint32_t commandBufferCount;
	}
	enum VkCommandBufferUsageFlagBits {
		VK_COMMAND_BUFFER_USAGE_ONE_TIME_SUBMIT_BIT = 0x00000001,
		VK_COMMAND_BUFFER_USAGE_RENDER_PASS_CONTINUE_BIT = 0x00000002,
		VK_COMMAND_BUFFER_USAGE_SIMULTANEOUS_USE_BIT = 0x00000004,
	}
	alias VkCommandBufferUsageFlags = VkFlags;
	enum VkQueryControlFlagBits {
		VK_QUERY_CONTROL_PRECISE_BIT = 0x00000001,
	}
	alias VkQueryControlFlags = VkFlags;
	struct VkCommandBufferInheritanceInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_COMMAND_BUFFER_INHERITANCE_INFO;
		const(void)* pNext;
		VkRenderPass renderPass;
		uint32_t subpass;
		VkFramebuffer framebuffer;
		VkBool32 occlusionQueryEnable;
		VkQueryControlFlags queryFlags;
		VkQueryPipelineStatisticFlags pipelineStatistics;
	}
	struct VkCommandBufferBeginInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO;
		const(void)* pNext;
		VkCommandBufferUsageFlags flags;
		const(VkCommandBufferInheritanceInfo)* pInheritanceInfo;
	}
	enum VkCommandBufferResetFlagBits {
		VK_COMMAND_BUFFER_RESET_RELEASE_RESOURCES_BIT = 0x00000001,
	}
	alias VkCommandBufferResetFlags = VkFlags;
	enum VkStencilFaceFlagBits {
		VK_STENCIL_FACE_FRONT_BIT = 0x00000001,
		VK_STENCIL_FACE_BACK_BIT = 0x00000002,
		VK_STENCIL_FRONT_AND_BACK = 0x00000003,
	}
	alias VkStencilFaceFlags = VkFlags;
	enum VkIndexType {
		VK_INDEX_TYPE_UINT16 = 0,
		VK_INDEX_TYPE_UINT32 = 1,
	}
	struct VkBufferCopy {
		VkDeviceSize srcOffset;
		VkDeviceSize dstOffset;
		VkDeviceSize size;
	}
	struct VkImageSubresourceLayers {
		VkImageAspectFlags aspectMask;
		uint32_t mipLevel;
		uint32_t baseArrayLayer;
		uint32_t layerCount;
	}
	struct VkImageCopy {
		VkImageSubresourceLayers srcSubresource;
		VkOffset3D srcOffset;
		VkImageSubresourceLayers dstSubresource;
		VkOffset3D dstOffset;
		VkExtent3D extent;
	}
	struct VkImageBlit {
		VkImageSubresourceLayers srcSubresource;
		VkOffset3D[2] srcOffsets;
		VkImageSubresourceLayers dstSubresource;
		VkOffset3D[2] dstOffsets;
	}
	struct VkBufferImageCopy {
		VkDeviceSize bufferOffset;
		uint32_t bufferRowLength;
		uint32_t bufferImageHeight;
		VkImageSubresourceLayers imageSubresource;
		VkOffset3D imageOffset;
		VkExtent3D imageExtent;
	}
	union VkClearColorValue {
		float[4] float32;
		int32_t[4] int32;
		uint32_t[4] uint32;
	}
	struct VkClearDepthStencilValue {
		float depth;
		uint32_t stencil;
	}
	union VkClearValue {
		VkClearColorValue color;
		VkClearDepthStencilValue depthStencil;
	}
	struct VkClearAttachment {
		VkImageAspectFlags aspectMask;
		uint32_t colorAttachment;
		VkClearValue clearValue;
	}
	struct VkClearRect {
		VkRect2D rect;
		uint32_t baseArrayLayer;
		uint32_t layerCount;
	}
	struct VkImageResolve {
		VkImageSubresourceLayers srcSubresource;
		VkOffset3D srcOffset;
		VkImageSubresourceLayers dstSubresource;
		VkOffset3D dstOffset;
		VkExtent3D extent;
	}
	struct VkMemoryBarrier {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_MEMORY_BARRIER;
		const(void)* pNext;
		VkAccessFlags srcAccessMask;
		VkAccessFlags dstAccessMask;
	}
	struct VkBufferMemoryBarrier {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_BUFFER_MEMORY_BARRIER;
		const(void)* pNext;
		VkAccessFlags srcAccessMask;
		VkAccessFlags dstAccessMask;
		uint32_t srcQueueFamilyIndex;
		uint32_t dstQueueFamilyIndex;
		VkBuffer buffer;
		VkDeviceSize offset;
		VkDeviceSize size;
	}
	struct VkImageMemoryBarrier {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_IMAGE_MEMORY_BARRIER;
		const(void)* pNext;
		VkAccessFlags srcAccessMask;
		VkAccessFlags dstAccessMask;
		VkImageLayout oldLayout;
		VkImageLayout newLayout;
		uint32_t srcQueueFamilyIndex;
		uint32_t dstQueueFamilyIndex;
		VkImage image;
		VkImageSubresourceRange subresourceRange;
	}
	struct VkRenderPassBeginInfo {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_RENDER_PASS_BEGIN_INFO;
		const(void)* pNext;
		VkRenderPass renderPass;
		VkFramebuffer framebuffer;
		VkRect2D renderArea;
		uint32_t clearValueCount;
		const(VkClearValue)* pClearValues;
	}
	enum VkSubpassContents {
		VK_SUBPASS_CONTENTS_INLINE = 0,
		VK_SUBPASS_CONTENTS_SECONDARY_COMMAND_BUFFERS = 1,
	}
	struct VkDispatchIndirectCommand {
		uint32_t x;
		uint32_t y;
		uint32_t z;
	}
	struct VkDrawIndexedIndirectCommand {
		uint32_t indexCount;
		uint32_t instanceCount;
		uint32_t firstIndex;
		int32_t vertexOffset;
		uint32_t firstInstance;
	}
	struct VkDrawIndirectCommand {
		uint32_t vertexCount;
		uint32_t instanceCount;
		uint32_t firstVertex;
		uint32_t firstInstance;
	}
}
version(DVulkan_VK_KHR_surface) {
	enum VK_KHR_SURFACE_SPEC_VERSION = 25;
	enum VK_KHR_SURFACE_EXTENSION_NAME = "VK_KHR_surface";
	mixin(VK_DEFINE_NON_DISPATCHABLE_HANDLE!q{VkSurfaceKHR});
	enum VkSurfaceTransformFlagBitsKHR {
		VK_SURFACE_TRANSFORM_IDENTITY_BIT_KHR = 0x00000001,
		VK_SURFACE_TRANSFORM_ROTATE_90_BIT_KHR = 0x00000002,
		VK_SURFACE_TRANSFORM_ROTATE_180_BIT_KHR = 0x00000004,
		VK_SURFACE_TRANSFORM_ROTATE_270_BIT_KHR = 0x00000008,
		VK_SURFACE_TRANSFORM_HORIZONTAL_MIRROR_BIT_KHR = 0x00000010,
		VK_SURFACE_TRANSFORM_HORIZONTAL_MIRROR_ROTATE_90_BIT_KHR = 0x00000020,
		VK_SURFACE_TRANSFORM_HORIZONTAL_MIRROR_ROTATE_180_BIT_KHR = 0x00000040,
		VK_SURFACE_TRANSFORM_HORIZONTAL_MIRROR_ROTATE_270_BIT_KHR = 0x00000080,
		VK_SURFACE_TRANSFORM_INHERIT_BIT_KHR = 0x00000100,
	}
	alias VkSurfaceTransformFlagsKHR = VkFlags;
	enum VkCompositeAlphaFlagBitsKHR {
		VK_COMPOSITE_ALPHA_OPAQUE_BIT_KHR = 0x00000001,
		VK_COMPOSITE_ALPHA_PRE_MULTIPLIED_BIT_KHR = 0x00000002,
		VK_COMPOSITE_ALPHA_POST_MULTIPLIED_BIT_KHR = 0x00000004,
		VK_COMPOSITE_ALPHA_INHERIT_BIT_KHR = 0x00000008,
	}
	alias VkCompositeAlphaFlagsKHR = VkFlags;
	struct VkSurfaceCapabilitiesKHR {
		uint32_t minImageCount;
		uint32_t maxImageCount;
		VkExtent2D currentExtent;
		VkExtent2D minImageExtent;
		VkExtent2D maxImageExtent;
		uint32_t maxImageArrayLayers;
		VkSurfaceTransformFlagsKHR supportedTransforms;
		VkSurfaceTransformFlagBitsKHR currentTransform;
		VkCompositeAlphaFlagsKHR supportedCompositeAlpha;
		VkImageUsageFlags supportedUsageFlags;
	}
	enum VkColorSpaceKHR {
		VK_COLOR_SPACE_SRGB_NONLINEAR_KHR = 0,
		VK_COLORSPACE_SRGB_NONLINEAR_KHR = VK_COLOR_SPACE_SRGB_NONLINEAR_KHR,
	}
	struct VkSurfaceFormatKHR {
		VkFormat format;
		VkColorSpaceKHR colorSpace;
	}
	enum VkPresentModeKHR {
		VK_PRESENT_MODE_IMMEDIATE_KHR = 0,
		VK_PRESENT_MODE_MAILBOX_KHR = 1,
		VK_PRESENT_MODE_FIFO_KHR = 2,
		VK_PRESENT_MODE_FIFO_RELAXED_KHR = 3,
	}
}
version(DVulkan_VK_KHR_swapchain) {
	enum VK_KHR_SWAPCHAIN_SPEC_VERSION = 68;
	enum VK_KHR_SWAPCHAIN_EXTENSION_NAME = "VK_KHR_swapchain";
	alias VkSwapchainCreateFlagsKHR = VkFlags;
	mixin(VK_DEFINE_NON_DISPATCHABLE_HANDLE!q{VkSwapchainKHR});
	struct VkSwapchainCreateInfoKHR {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_SWAPCHAIN_CREATE_INFO_KHR;
		const(void)* pNext;
		VkSwapchainCreateFlagsKHR flags;
		VkSurfaceKHR surface;
		uint32_t minImageCount;
		VkFormat imageFormat;
		VkColorSpaceKHR imageColorSpace;
		VkExtent2D imageExtent;
		uint32_t imageArrayLayers;
		VkImageUsageFlags imageUsage;
		VkSharingMode imageSharingMode;
		uint32_t queueFamilyIndexCount;
		const(uint32_t)* pQueueFamilyIndices;
		VkSurfaceTransformFlagBitsKHR preTransform;
		VkCompositeAlphaFlagBitsKHR compositeAlpha;
		VkPresentModeKHR presentMode;
		VkBool32 clipped;
		VkSwapchainKHR oldSwapchain;
	}
	struct VkPresentInfoKHR {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_PRESENT_INFO_KHR;
		const(void)* pNext;
		uint32_t waitSemaphoreCount;
		const(VkSemaphore)* pWaitSemaphores;
		uint32_t swapchainCount;
		const(VkSwapchainKHR)* pSwapchains;
		const(uint32_t)* pImageIndices;
		VkResult* pResults;
	}
}
version(DVulkan_VK_KHR_display) {
	enum VkDisplayPlaneAlphaFlagBitsKHR {
		VK_DISPLAY_PLANE_ALPHA_OPAQUE_BIT_KHR = 0x00000001,
		VK_DISPLAY_PLANE_ALPHA_GLOBAL_BIT_KHR = 0x00000002,
		VK_DISPLAY_PLANE_ALPHA_PER_PIXEL_BIT_KHR = 0x00000004,
		VK_DISPLAY_PLANE_ALPHA_PER_PIXEL_PREMULTIPLIED_BIT_KHR = 0x00000008,
	}
	alias VkDisplayPlaneAlphaFlagsKHR = VkFlags;
	mixin(VK_DEFINE_NON_DISPATCHABLE_HANDLE!q{VkDisplayKHR});
	struct VkDisplayPropertiesKHR {
		VkDisplayKHR display;
		const(char)* displayName;
		VkExtent2D physicalDimensions;
		VkExtent2D physicalResolution;
		VkSurfaceTransformFlagsKHR supportedTransforms;
		VkBool32 planeReorderPossible;
		VkBool32 persistentContent;
	}
	struct VkDisplayModeParametersKHR {
		VkExtent2D visibleRegion;
		uint32_t refreshRate;
	}
	mixin(VK_DEFINE_NON_DISPATCHABLE_HANDLE!q{VkDisplayModeKHR});
	struct VkDisplayModePropertiesKHR {
		VkDisplayModeKHR displayMode;
		VkDisplayModeParametersKHR parameters;
	}
	alias VkDisplayModeCreateFlagsKHR = VkFlags;
	struct VkDisplayModeCreateInfoKHR {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_DISPLAY_MODE_CREATE_INFO_KHR;
		const(void)* pNext;
		VkDisplayModeCreateFlagsKHR flags;
		VkDisplayModeParametersKHR parameters;
	}
	struct VkDisplayPlaneCapabilitiesKHR {
		VkDisplayPlaneAlphaFlagsKHR supportedAlpha;
		VkOffset2D minSrcPosition;
		VkOffset2D maxSrcPosition;
		VkExtent2D minSrcExtent;
		VkExtent2D maxSrcExtent;
		VkOffset2D minDstPosition;
		VkOffset2D maxDstPosition;
		VkExtent2D minDstExtent;
		VkExtent2D maxDstExtent;
	}
	struct VkDisplayPlanePropertiesKHR {
		VkDisplayKHR currentDisplay;
		uint32_t currentStackIndex;
	}
	alias VkDisplaySurfaceCreateFlagsKHR = VkFlags;
	struct VkDisplaySurfaceCreateInfoKHR {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_DISPLAY_SURFACE_CREATE_INFO_KHR;
		const(void)* pNext;
		VkDisplaySurfaceCreateFlagsKHR flags;
		VkDisplayModeKHR displayMode;
		uint32_t planeIndex;
		uint32_t planeStackIndex;
		VkSurfaceTransformFlagBitsKHR transform;
		float globalAlpha;
		VkDisplayPlaneAlphaFlagBitsKHR alphaMode;
		VkExtent2D imageExtent;
	}
	enum VK_KHR_DISPLAY_SPEC_VERSION = 21;
	enum VK_KHR_DISPLAY_EXTENSION_NAME = "VK_KHR_display";
}
version(DVulkan_VK_KHR_display_swapchain) {
	struct VkDisplayPresentInfoKHR {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_DISPLAY_PRESENT_INFO_KHR;
		const(void)* pNext;
		VkRect2D srcRect;
		VkRect2D dstRect;
		VkBool32 persistent;
	}
	enum VK_KHR_DISPLAY_SWAPCHAIN_SPEC_VERSION = 9;
	enum VK_KHR_DISPLAY_SWAPCHAIN_EXTENSION_NAME = "VK_KHR_display_swapchain";
}
version(DVulkan_VK_KHR_sampler_mirror_clamp_to_edge) {
	enum VK_KHR_SAMPLER_MIRROR_CLAMP_TO_EDGE_SPEC_VERSION = 1;
	enum VK_KHR_SAMPLER_MIRROR_CLAMP_TO_EDGE_EXTENSION_NAME = "VK_KHR_sampler_mirror_clamp_to_edge";
}
version(DVulkan_VK_ANDROID_native_buffer) {
	enum VK_ANDROID_NATIVE_BUFFER_SPEC_VERSION = 4;
	enum VK_ANDROID_NATIVE_BUFFER_NUMBER = 11;
	enum VK_ANDROID_NATIVE_BUFFER_NAME = "VK_ANDROID_native_buffer";
}
version(DVulkan_VK_EXT_debug_report) {
	enum VkDebugReportObjectTypeEXT {
		VK_DEBUG_REPORT_OBJECT_TYPE_UNKNOWN_EXT = 0,
		VK_DEBUG_REPORT_OBJECT_TYPE_INSTANCE_EXT = 1,
		VK_DEBUG_REPORT_OBJECT_TYPE_PHYSICAL_DEVICE_EXT = 2,
		VK_DEBUG_REPORT_OBJECT_TYPE_DEVICE_EXT = 3,
		VK_DEBUG_REPORT_OBJECT_TYPE_QUEUE_EXT = 4,
		VK_DEBUG_REPORT_OBJECT_TYPE_SEMAPHORE_EXT = 5,
		VK_DEBUG_REPORT_OBJECT_TYPE_COMMAND_BUFFER_EXT = 6,
		VK_DEBUG_REPORT_OBJECT_TYPE_FENCE_EXT = 7,
		VK_DEBUG_REPORT_OBJECT_TYPE_DEVICE_MEMORY_EXT = 8,
		VK_DEBUG_REPORT_OBJECT_TYPE_BUFFER_EXT = 9,
		VK_DEBUG_REPORT_OBJECT_TYPE_IMAGE_EXT = 10,
		VK_DEBUG_REPORT_OBJECT_TYPE_EVENT_EXT = 11,
		VK_DEBUG_REPORT_OBJECT_TYPE_QUERY_POOL_EXT = 12,
		VK_DEBUG_REPORT_OBJECT_TYPE_BUFFER_VIEW_EXT = 13,
		VK_DEBUG_REPORT_OBJECT_TYPE_IMAGE_VIEW_EXT = 14,
		VK_DEBUG_REPORT_OBJECT_TYPE_SHADER_MODULE_EXT = 15,
		VK_DEBUG_REPORT_OBJECT_TYPE_PIPELINE_CACHE_EXT = 16,
		VK_DEBUG_REPORT_OBJECT_TYPE_PIPELINE_LAYOUT_EXT = 17,
		VK_DEBUG_REPORT_OBJECT_TYPE_RENDER_PASS_EXT = 18,
		VK_DEBUG_REPORT_OBJECT_TYPE_PIPELINE_EXT = 19,
		VK_DEBUG_REPORT_OBJECT_TYPE_DESCRIPTOR_SET_LAYOUT_EXT = 20,
		VK_DEBUG_REPORT_OBJECT_TYPE_SAMPLER_EXT = 21,
		VK_DEBUG_REPORT_OBJECT_TYPE_DESCRIPTOR_POOL_EXT = 22,
		VK_DEBUG_REPORT_OBJECT_TYPE_DESCRIPTOR_SET_EXT = 23,
		VK_DEBUG_REPORT_OBJECT_TYPE_FRAMEBUFFER_EXT = 24,
		VK_DEBUG_REPORT_OBJECT_TYPE_COMMAND_POOL_EXT = 25,
		VK_DEBUG_REPORT_OBJECT_TYPE_SURFACE_KHR_EXT = 26,
		VK_DEBUG_REPORT_OBJECT_TYPE_SWAPCHAIN_KHR_EXT = 27,
		VK_DEBUG_REPORT_OBJECT_TYPE_DEBUG_REPORT_EXT = 28,
	}
	enum VkDebugReportErrorEXT {
		VK_DEBUG_REPORT_ERROR_NONE_EXT = 0,
		VK_DEBUG_REPORT_ERROR_CALLBACK_REF_EXT = 1,
	}
	enum VK_EXT_DEBUG_REPORT_SPEC_VERSION = 2;
	enum VK_EXT_DEBUG_REPORT_EXTENSION_NAME = "VK_EXT_debug_report";
	enum VK_STRUCTURE_TYPE_DEBUG_REPORT_CREATE_INFO_EXT = VkStructureType.VK_STRUCTURE_TYPE_DEBUG_REPORT_CALLBACK_CREATE_INFO_EXT;
	enum VkDebugReportFlagBitsEXT {
		VK_DEBUG_REPORT_INFORMATION_BIT_EXT = 0x00000001,
		VK_DEBUG_REPORT_WARNING_BIT_EXT = 0x00000002,
		VK_DEBUG_REPORT_PERFORMANCE_WARNING_BIT_EXT = 0x00000004,
		VK_DEBUG_REPORT_ERROR_BIT_EXT = 0x00000008,
		VK_DEBUG_REPORT_DEBUG_BIT_EXT = 0x00000010,
	}
	alias VkDebugReportFlagsEXT = VkFlags;
	alias PFN_vkDebugReportCallbackEXT = VkBool32 function(
    VkDebugReportFlagsEXT                       flags,
    VkDebugReportObjectTypeEXT                  objectType,
    uint64_t                                    object,
    size_t                                      location,
    int32_t                                     messageCode,
    const char*                                 pLayerPrefix,
    const char*                                 pMessage,
    void*                                       pUserData);
	struct VkDebugReportCallbackCreateInfoEXT {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_DEBUG_REPORT_CALLBACK_CREATE_INFO_EXT;
		const(void)* pNext;
		VkDebugReportFlagsEXT flags;
		PFN_vkDebugReportCallbackEXT pfnCallback;
		void* pUserData;
	}
	mixin(VK_DEFINE_NON_DISPATCHABLE_HANDLE!q{VkDebugReportCallbackEXT});
}
version(DVulkan_VK_NV_glsl_shader) {
	enum VK_NV_GLSL_SHADER_SPEC_VERSION = 1;
	enum VK_NV_GLSL_SHADER_EXTENSION_NAME = "VK_NV_glsl_shader";
}
version(DVulkan_VK_NV_extension_1) {
	enum VK_NV_EXTENSION_1_SPEC_VERSION = 0;
	enum VK_NV_EXTENSION_1_EXTENSION_NAME = "VK_NV_extension_1";
}
version(DVulkan_VK_IMG_filter_cubic) {
	enum VK_IMG_FILTER_CUBIC_SPEC_VERSION = 1;
	enum VK_IMG_FILTER_CUBIC_EXTENSION_NAME = "VK_IMG_filter_cubic";
}
version(DVulkan_VK_AMD_extension_1) {
	enum VK_AMD_EXTENSION_1_SPEC_VERSION = 0;
	enum VK_AMD_EXTENSION_1_EXTENSION_NAME = "VK_AMD_extension_1";
}
version(DVulkan_VK_AMD_extension_2) {
	enum VK_AMD_EXTENSION_2_SPEC_VERSION = 0;
	enum VK_AMD_EXTENSION_2_EXTENSION_NAME = "VK_AMD_extension_2";
}
version(DVulkan_VK_AMD_rasterization_order) {
	enum VkRasterizationOrderAMD {
		VK_RASTERIZATION_ORDER_STRICT_AMD = 0,
		VK_RASTERIZATION_ORDER_RELAXED_AMD = 1,
	}
	struct VkPipelineRasterizationStateRasterizationOrderAMD {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_RASTERIZATION_STATE_RASTERIZATION_ORDER_AMD;
		const(void)* pNext;
		VkRasterizationOrderAMD rasterizationOrder;
	}
	enum VK_AMD_RASTERIZATION_ORDER_SPEC_VERSION = 1;
	enum VK_AMD_RASTERIZATION_ORDER_EXTENSION_NAME = "VK_AMD_rasterization_order";
}
version(DVulkan_VK_AMD_extension_4) {
	enum VK_AMD_EXTENSION_4_SPEC_VERSION = 0;
	enum VK_AMD_EXTENSION_4_EXTENSION_NAME = "VK_AMD_extension_4";
}
version(DVulkan_VK_AMD_extension_5) {
	enum VK_AMD_EXTENSION_5_SPEC_VERSION = 0;
	enum VK_AMD_EXTENSION_5_EXTENSION_NAME = "VK_AMD_extension_5";
}
version(DVulkan_VK_AMD_extension_6) {
	enum VK_AMD_EXTENSION_6_SPEC_VERSION = 0;
	enum VK_AMD_EXTENSION_6_EXTENSION_NAME = "VK_AMD_extension_6";
}
version(DVulkan_VK_EXT_debug_marker) {
	struct VkDebugMarkerObjectNameInfoEXT {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_DEBUG_MARKER_OBJECT_NAME_INFO_EXT;
		const(void)* pNext;
		VkDebugReportObjectTypeEXT objectType;
		uint64_t object;
		const(char)* pObjectName;
	}
	struct VkDebugMarkerObjectTagInfoEXT {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_DEBUG_MARKER_OBJECT_TAG_INFO_EXT;
		const(void)* pNext;
		VkDebugReportObjectTypeEXT objectType;
		uint64_t object;
		uint64_t tagName;
		size_t tagSize;
		const(void)* pTag;
	}
	struct VkDebugMarkerMarkerInfoEXT {
		VkStructureType sType = VkStructureType.VK_STRUCTURE_TYPE_DEBUG_MARKER_MARKER_INFO_EXT;
		const(void)* pNext;
		const(char)* pMarkerName;
		float[4] color;
	}
	enum VK_EXT_DEBUG_MARKER_SPEC_VERSION = 3;
	enum VK_EXT_DEBUG_MARKER_EXTENSION_NAME = "VK_EXT_debug_marker";
}
version(DVulkanGlobalEnums) {
	version(DVulkan_VK_VERSION_1_0) {
		enum VK_PIPELINE_CACHE_HEADER_VERSION_ONE = VkPipelineCacheHeaderVersion.VK_PIPELINE_CACHE_HEADER_VERSION_ONE;
		enum VK_SUCCESS = VkResult.VK_SUCCESS;
		enum VK_NOT_READY = VkResult.VK_NOT_READY;
		enum VK_TIMEOUT = VkResult.VK_TIMEOUT;
		enum VK_EVENT_SET = VkResult.VK_EVENT_SET;
		enum VK_EVENT_RESET = VkResult.VK_EVENT_RESET;
		enum VK_INCOMPLETE = VkResult.VK_INCOMPLETE;
		enum VK_ERROR_OUT_OF_HOST_MEMORY = VkResult.VK_ERROR_OUT_OF_HOST_MEMORY;
		enum VK_ERROR_OUT_OF_DEVICE_MEMORY = VkResult.VK_ERROR_OUT_OF_DEVICE_MEMORY;
		enum VK_ERROR_INITIALIZATION_FAILED = VkResult.VK_ERROR_INITIALIZATION_FAILED;
		enum VK_ERROR_DEVICE_LOST = VkResult.VK_ERROR_DEVICE_LOST;
		enum VK_ERROR_MEMORY_MAP_FAILED = VkResult.VK_ERROR_MEMORY_MAP_FAILED;
		enum VK_ERROR_LAYER_NOT_PRESENT = VkResult.VK_ERROR_LAYER_NOT_PRESENT;
		enum VK_ERROR_EXTENSION_NOT_PRESENT = VkResult.VK_ERROR_EXTENSION_NOT_PRESENT;
		enum VK_ERROR_FEATURE_NOT_PRESENT = VkResult.VK_ERROR_FEATURE_NOT_PRESENT;
		enum VK_ERROR_INCOMPATIBLE_DRIVER = VkResult.VK_ERROR_INCOMPATIBLE_DRIVER;
		enum VK_ERROR_TOO_MANY_OBJECTS = VkResult.VK_ERROR_TOO_MANY_OBJECTS;
		enum VK_ERROR_FORMAT_NOT_SUPPORTED = VkResult.VK_ERROR_FORMAT_NOT_SUPPORTED;
		enum VK_ERROR_SURFACE_LOST_KHR = VkResult.VK_ERROR_SURFACE_LOST_KHR;
		enum VK_ERROR_NATIVE_WINDOW_IN_USE_KHR = VkResult.VK_ERROR_NATIVE_WINDOW_IN_USE_KHR;
		enum VK_SUBOPTIMAL_KHR = VkResult.VK_SUBOPTIMAL_KHR;
		enum VK_ERROR_OUT_OF_DATE_KHR = VkResult.VK_ERROR_OUT_OF_DATE_KHR;
		enum VK_ERROR_INCOMPATIBLE_DISPLAY_KHR = VkResult.VK_ERROR_INCOMPATIBLE_DISPLAY_KHR;
		enum VK_ERROR_VALIDATION_FAILED_EXT = VkResult.VK_ERROR_VALIDATION_FAILED_EXT;
		enum VK_ERROR_INVALID_SHADER_NV = VkResult.VK_ERROR_INVALID_SHADER_NV;
		enum VK_NV_EXTENSION_1_ERROR = VkResult.VK_NV_EXTENSION_1_ERROR;
		enum VK_STRUCTURE_TYPE_APPLICATION_INFO = VkStructureType.VK_STRUCTURE_TYPE_APPLICATION_INFO;
		enum VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_DEVICE_QUEUE_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_DEVICE_QUEUE_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_DEVICE_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_DEVICE_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_SUBMIT_INFO = VkStructureType.VK_STRUCTURE_TYPE_SUBMIT_INFO;
		enum VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_INFO;
		enum VK_STRUCTURE_TYPE_MAPPED_MEMORY_RANGE = VkStructureType.VK_STRUCTURE_TYPE_MAPPED_MEMORY_RANGE;
		enum VK_STRUCTURE_TYPE_BIND_SPARSE_INFO = VkStructureType.VK_STRUCTURE_TYPE_BIND_SPARSE_INFO;
		enum VK_STRUCTURE_TYPE_FENCE_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_FENCE_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_SEMAPHORE_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_SEMAPHORE_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_EVENT_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_EVENT_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_QUERY_POOL_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_QUERY_POOL_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_BUFFER_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_BUFFER_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_BUFFER_VIEW_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_BUFFER_VIEW_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_IMAGE_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_IMAGE_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_IMAGE_VIEW_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_IMAGE_VIEW_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_SHADER_MODULE_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_SHADER_MODULE_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_PIPELINE_CACHE_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_CACHE_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_PIPELINE_SHADER_STAGE_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_SHADER_STAGE_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_PIPELINE_VERTEX_INPUT_STATE_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_VERTEX_INPUT_STATE_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_PIPELINE_INPUT_ASSEMBLY_STATE_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_INPUT_ASSEMBLY_STATE_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_PIPELINE_TESSELLATION_STATE_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_TESSELLATION_STATE_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_PIPELINE_VIEWPORT_STATE_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_VIEWPORT_STATE_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_PIPELINE_RASTERIZATION_STATE_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_RASTERIZATION_STATE_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_PIPELINE_MULTISAMPLE_STATE_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_MULTISAMPLE_STATE_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_PIPELINE_DEPTH_STENCIL_STATE_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_DEPTH_STENCIL_STATE_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_PIPELINE_COLOR_BLEND_STATE_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_COLOR_BLEND_STATE_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_PIPELINE_DYNAMIC_STATE_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_DYNAMIC_STATE_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_GRAPHICS_PIPELINE_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_GRAPHICS_PIPELINE_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_COMPUTE_PIPELINE_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_COMPUTE_PIPELINE_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_PIPELINE_LAYOUT_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_LAYOUT_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_SAMPLER_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_SAMPLER_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_DESCRIPTOR_SET_LAYOUT_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_DESCRIPTOR_SET_LAYOUT_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_DESCRIPTOR_POOL_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_DESCRIPTOR_POOL_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_DESCRIPTOR_SET_ALLOCATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_DESCRIPTOR_SET_ALLOCATE_INFO;
		enum VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET = VkStructureType.VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET;
		enum VK_STRUCTURE_TYPE_COPY_DESCRIPTOR_SET = VkStructureType.VK_STRUCTURE_TYPE_COPY_DESCRIPTOR_SET;
		enum VK_STRUCTURE_TYPE_FRAMEBUFFER_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_FRAMEBUFFER_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_RENDER_PASS_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_RENDER_PASS_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_COMMAND_POOL_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_COMMAND_POOL_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_COMMAND_BUFFER_ALLOCATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_COMMAND_BUFFER_ALLOCATE_INFO;
		enum VK_STRUCTURE_TYPE_COMMAND_BUFFER_INHERITANCE_INFO = VkStructureType.VK_STRUCTURE_TYPE_COMMAND_BUFFER_INHERITANCE_INFO;
		enum VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO = VkStructureType.VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO;
		enum VK_STRUCTURE_TYPE_RENDER_PASS_BEGIN_INFO = VkStructureType.VK_STRUCTURE_TYPE_RENDER_PASS_BEGIN_INFO;
		enum VK_STRUCTURE_TYPE_BUFFER_MEMORY_BARRIER = VkStructureType.VK_STRUCTURE_TYPE_BUFFER_MEMORY_BARRIER;
		enum VK_STRUCTURE_TYPE_IMAGE_MEMORY_BARRIER = VkStructureType.VK_STRUCTURE_TYPE_IMAGE_MEMORY_BARRIER;
		enum VK_STRUCTURE_TYPE_MEMORY_BARRIER = VkStructureType.VK_STRUCTURE_TYPE_MEMORY_BARRIER;
		enum VK_STRUCTURE_TYPE_LOADER_INSTANCE_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_LOADER_INSTANCE_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_LOADER_DEVICE_CREATE_INFO = VkStructureType.VK_STRUCTURE_TYPE_LOADER_DEVICE_CREATE_INFO;
		enum VK_STRUCTURE_TYPE_SWAPCHAIN_CREATE_INFO_KHR = VkStructureType.VK_STRUCTURE_TYPE_SWAPCHAIN_CREATE_INFO_KHR;
		enum VK_STRUCTURE_TYPE_PRESENT_INFO_KHR = VkStructureType.VK_STRUCTURE_TYPE_PRESENT_INFO_KHR;
		enum VK_STRUCTURE_TYPE_DISPLAY_MODE_CREATE_INFO_KHR = VkStructureType.VK_STRUCTURE_TYPE_DISPLAY_MODE_CREATE_INFO_KHR;
		enum VK_STRUCTURE_TYPE_DISPLAY_SURFACE_CREATE_INFO_KHR = VkStructureType.VK_STRUCTURE_TYPE_DISPLAY_SURFACE_CREATE_INFO_KHR;
		enum VK_STRUCTURE_TYPE_DISPLAY_PRESENT_INFO_KHR = VkStructureType.VK_STRUCTURE_TYPE_DISPLAY_PRESENT_INFO_KHR;
		enum VK_STRUCTURE_TYPE_XLIB_SURFACE_CREATE_INFO_KHR = VkStructureType.VK_STRUCTURE_TYPE_XLIB_SURFACE_CREATE_INFO_KHR;
		enum VK_STRUCTURE_TYPE_XCB_SURFACE_CREATE_INFO_KHR = VkStructureType.VK_STRUCTURE_TYPE_XCB_SURFACE_CREATE_INFO_KHR;
		enum VK_STRUCTURE_TYPE_WAYLAND_SURFACE_CREATE_INFO_KHR = VkStructureType.VK_STRUCTURE_TYPE_WAYLAND_SURFACE_CREATE_INFO_KHR;
		enum VK_STRUCTURE_TYPE_MIR_SURFACE_CREATE_INFO_KHR = VkStructureType.VK_STRUCTURE_TYPE_MIR_SURFACE_CREATE_INFO_KHR;
		enum VK_STRUCTURE_TYPE_ANDROID_SURFACE_CREATE_INFO_KHR = VkStructureType.VK_STRUCTURE_TYPE_ANDROID_SURFACE_CREATE_INFO_KHR;
		enum VK_STRUCTURE_TYPE_WIN32_SURFACE_CREATE_INFO_KHR = VkStructureType.VK_STRUCTURE_TYPE_WIN32_SURFACE_CREATE_INFO_KHR;
		enum VK_STRUCTURE_TYPE_DEBUG_REPORT_CALLBACK_CREATE_INFO_EXT = VkStructureType.VK_STRUCTURE_TYPE_DEBUG_REPORT_CALLBACK_CREATE_INFO_EXT;
		enum VK_STRUCTURE_TYPE_PIPELINE_RASTERIZATION_STATE_RASTERIZATION_ORDER_AMD = VkStructureType.VK_STRUCTURE_TYPE_PIPELINE_RASTERIZATION_STATE_RASTERIZATION_ORDER_AMD;
		enum VK_STRUCTURE_TYPE_DEBUG_MARKER_OBJECT_NAME_INFO_EXT = VkStructureType.VK_STRUCTURE_TYPE_DEBUG_MARKER_OBJECT_NAME_INFO_EXT;
		enum VK_STRUCTURE_TYPE_DEBUG_MARKER_OBJECT_TAG_INFO_EXT = VkStructureType.VK_STRUCTURE_TYPE_DEBUG_MARKER_OBJECT_TAG_INFO_EXT;
		enum VK_STRUCTURE_TYPE_DEBUG_MARKER_MARKER_INFO_EXT = VkStructureType.VK_STRUCTURE_TYPE_DEBUG_MARKER_MARKER_INFO_EXT;
		enum VK_SYSTEM_ALLOCATION_SCOPE_COMMAND = VkSystemAllocationScope.VK_SYSTEM_ALLOCATION_SCOPE_COMMAND;
		enum VK_SYSTEM_ALLOCATION_SCOPE_OBJECT = VkSystemAllocationScope.VK_SYSTEM_ALLOCATION_SCOPE_OBJECT;
		enum VK_SYSTEM_ALLOCATION_SCOPE_CACHE = VkSystemAllocationScope.VK_SYSTEM_ALLOCATION_SCOPE_CACHE;
		enum VK_SYSTEM_ALLOCATION_SCOPE_DEVICE = VkSystemAllocationScope.VK_SYSTEM_ALLOCATION_SCOPE_DEVICE;
		enum VK_SYSTEM_ALLOCATION_SCOPE_INSTANCE = VkSystemAllocationScope.VK_SYSTEM_ALLOCATION_SCOPE_INSTANCE;
		enum VK_INTERNAL_ALLOCATION_TYPE_EXECUTABLE = VkInternalAllocationType.VK_INTERNAL_ALLOCATION_TYPE_EXECUTABLE;
		enum VK_FORMAT_UNDEFINED = VkFormat.VK_FORMAT_UNDEFINED;
		enum VK_FORMAT_R4G4_UNORM_PACK8 = VkFormat.VK_FORMAT_R4G4_UNORM_PACK8;
		enum VK_FORMAT_R4G4B4A4_UNORM_PACK16 = VkFormat.VK_FORMAT_R4G4B4A4_UNORM_PACK16;
		enum VK_FORMAT_B4G4R4A4_UNORM_PACK16 = VkFormat.VK_FORMAT_B4G4R4A4_UNORM_PACK16;
		enum VK_FORMAT_R5G6B5_UNORM_PACK16 = VkFormat.VK_FORMAT_R5G6B5_UNORM_PACK16;
		enum VK_FORMAT_B5G6R5_UNORM_PACK16 = VkFormat.VK_FORMAT_B5G6R5_UNORM_PACK16;
		enum VK_FORMAT_R5G5B5A1_UNORM_PACK16 = VkFormat.VK_FORMAT_R5G5B5A1_UNORM_PACK16;
		enum VK_FORMAT_B5G5R5A1_UNORM_PACK16 = VkFormat.VK_FORMAT_B5G5R5A1_UNORM_PACK16;
		enum VK_FORMAT_A1R5G5B5_UNORM_PACK16 = VkFormat.VK_FORMAT_A1R5G5B5_UNORM_PACK16;
		enum VK_FORMAT_R8_UNORM = VkFormat.VK_FORMAT_R8_UNORM;
		enum VK_FORMAT_R8_SNORM = VkFormat.VK_FORMAT_R8_SNORM;
		enum VK_FORMAT_R8_USCALED = VkFormat.VK_FORMAT_R8_USCALED;
		enum VK_FORMAT_R8_SSCALED = VkFormat.VK_FORMAT_R8_SSCALED;
		enum VK_FORMAT_R8_UINT = VkFormat.VK_FORMAT_R8_UINT;
		enum VK_FORMAT_R8_SINT = VkFormat.VK_FORMAT_R8_SINT;
		enum VK_FORMAT_R8_SRGB = VkFormat.VK_FORMAT_R8_SRGB;
		enum VK_FORMAT_R8G8_UNORM = VkFormat.VK_FORMAT_R8G8_UNORM;
		enum VK_FORMAT_R8G8_SNORM = VkFormat.VK_FORMAT_R8G8_SNORM;
		enum VK_FORMAT_R8G8_USCALED = VkFormat.VK_FORMAT_R8G8_USCALED;
		enum VK_FORMAT_R8G8_SSCALED = VkFormat.VK_FORMAT_R8G8_SSCALED;
		enum VK_FORMAT_R8G8_UINT = VkFormat.VK_FORMAT_R8G8_UINT;
		enum VK_FORMAT_R8G8_SINT = VkFormat.VK_FORMAT_R8G8_SINT;
		enum VK_FORMAT_R8G8_SRGB = VkFormat.VK_FORMAT_R8G8_SRGB;
		enum VK_FORMAT_R8G8B8_UNORM = VkFormat.VK_FORMAT_R8G8B8_UNORM;
		enum VK_FORMAT_R8G8B8_SNORM = VkFormat.VK_FORMAT_R8G8B8_SNORM;
		enum VK_FORMAT_R8G8B8_USCALED = VkFormat.VK_FORMAT_R8G8B8_USCALED;
		enum VK_FORMAT_R8G8B8_SSCALED = VkFormat.VK_FORMAT_R8G8B8_SSCALED;
		enum VK_FORMAT_R8G8B8_UINT = VkFormat.VK_FORMAT_R8G8B8_UINT;
		enum VK_FORMAT_R8G8B8_SINT = VkFormat.VK_FORMAT_R8G8B8_SINT;
		enum VK_FORMAT_R8G8B8_SRGB = VkFormat.VK_FORMAT_R8G8B8_SRGB;
		enum VK_FORMAT_B8G8R8_UNORM = VkFormat.VK_FORMAT_B8G8R8_UNORM;
		enum VK_FORMAT_B8G8R8_SNORM = VkFormat.VK_FORMAT_B8G8R8_SNORM;
		enum VK_FORMAT_B8G8R8_USCALED = VkFormat.VK_FORMAT_B8G8R8_USCALED;
		enum VK_FORMAT_B8G8R8_SSCALED = VkFormat.VK_FORMAT_B8G8R8_SSCALED;
		enum VK_FORMAT_B8G8R8_UINT = VkFormat.VK_FORMAT_B8G8R8_UINT;
		enum VK_FORMAT_B8G8R8_SINT = VkFormat.VK_FORMAT_B8G8R8_SINT;
		enum VK_FORMAT_B8G8R8_SRGB = VkFormat.VK_FORMAT_B8G8R8_SRGB;
		enum VK_FORMAT_R8G8B8A8_UNORM = VkFormat.VK_FORMAT_R8G8B8A8_UNORM;
		enum VK_FORMAT_R8G8B8A8_SNORM = VkFormat.VK_FORMAT_R8G8B8A8_SNORM;
		enum VK_FORMAT_R8G8B8A8_USCALED = VkFormat.VK_FORMAT_R8G8B8A8_USCALED;
		enum VK_FORMAT_R8G8B8A8_SSCALED = VkFormat.VK_FORMAT_R8G8B8A8_SSCALED;
		enum VK_FORMAT_R8G8B8A8_UINT = VkFormat.VK_FORMAT_R8G8B8A8_UINT;
		enum VK_FORMAT_R8G8B8A8_SINT = VkFormat.VK_FORMAT_R8G8B8A8_SINT;
		enum VK_FORMAT_R8G8B8A8_SRGB = VkFormat.VK_FORMAT_R8G8B8A8_SRGB;
		enum VK_FORMAT_B8G8R8A8_UNORM = VkFormat.VK_FORMAT_B8G8R8A8_UNORM;
		enum VK_FORMAT_B8G8R8A8_SNORM = VkFormat.VK_FORMAT_B8G8R8A8_SNORM;
		enum VK_FORMAT_B8G8R8A8_USCALED = VkFormat.VK_FORMAT_B8G8R8A8_USCALED;
		enum VK_FORMAT_B8G8R8A8_SSCALED = VkFormat.VK_FORMAT_B8G8R8A8_SSCALED;
		enum VK_FORMAT_B8G8R8A8_UINT = VkFormat.VK_FORMAT_B8G8R8A8_UINT;
		enum VK_FORMAT_B8G8R8A8_SINT = VkFormat.VK_FORMAT_B8G8R8A8_SINT;
		enum VK_FORMAT_B8G8R8A8_SRGB = VkFormat.VK_FORMAT_B8G8R8A8_SRGB;
		enum VK_FORMAT_A8B8G8R8_UNORM_PACK32 = VkFormat.VK_FORMAT_A8B8G8R8_UNORM_PACK32;
		enum VK_FORMAT_A8B8G8R8_SNORM_PACK32 = VkFormat.VK_FORMAT_A8B8G8R8_SNORM_PACK32;
		enum VK_FORMAT_A8B8G8R8_USCALED_PACK32 = VkFormat.VK_FORMAT_A8B8G8R8_USCALED_PACK32;
		enum VK_FORMAT_A8B8G8R8_SSCALED_PACK32 = VkFormat.VK_FORMAT_A8B8G8R8_SSCALED_PACK32;
		enum VK_FORMAT_A8B8G8R8_UINT_PACK32 = VkFormat.VK_FORMAT_A8B8G8R8_UINT_PACK32;
		enum VK_FORMAT_A8B8G8R8_SINT_PACK32 = VkFormat.VK_FORMAT_A8B8G8R8_SINT_PACK32;
		enum VK_FORMAT_A8B8G8R8_SRGB_PACK32 = VkFormat.VK_FORMAT_A8B8G8R8_SRGB_PACK32;
		enum VK_FORMAT_A2R10G10B10_UNORM_PACK32 = VkFormat.VK_FORMAT_A2R10G10B10_UNORM_PACK32;
		enum VK_FORMAT_A2R10G10B10_SNORM_PACK32 = VkFormat.VK_FORMAT_A2R10G10B10_SNORM_PACK32;
		enum VK_FORMAT_A2R10G10B10_USCALED_PACK32 = VkFormat.VK_FORMAT_A2R10G10B10_USCALED_PACK32;
		enum VK_FORMAT_A2R10G10B10_SSCALED_PACK32 = VkFormat.VK_FORMAT_A2R10G10B10_SSCALED_PACK32;
		enum VK_FORMAT_A2R10G10B10_UINT_PACK32 = VkFormat.VK_FORMAT_A2R10G10B10_UINT_PACK32;
		enum VK_FORMAT_A2R10G10B10_SINT_PACK32 = VkFormat.VK_FORMAT_A2R10G10B10_SINT_PACK32;
		enum VK_FORMAT_A2B10G10R10_UNORM_PACK32 = VkFormat.VK_FORMAT_A2B10G10R10_UNORM_PACK32;
		enum VK_FORMAT_A2B10G10R10_SNORM_PACK32 = VkFormat.VK_FORMAT_A2B10G10R10_SNORM_PACK32;
		enum VK_FORMAT_A2B10G10R10_USCALED_PACK32 = VkFormat.VK_FORMAT_A2B10G10R10_USCALED_PACK32;
		enum VK_FORMAT_A2B10G10R10_SSCALED_PACK32 = VkFormat.VK_FORMAT_A2B10G10R10_SSCALED_PACK32;
		enum VK_FORMAT_A2B10G10R10_UINT_PACK32 = VkFormat.VK_FORMAT_A2B10G10R10_UINT_PACK32;
		enum VK_FORMAT_A2B10G10R10_SINT_PACK32 = VkFormat.VK_FORMAT_A2B10G10R10_SINT_PACK32;
		enum VK_FORMAT_R16_UNORM = VkFormat.VK_FORMAT_R16_UNORM;
		enum VK_FORMAT_R16_SNORM = VkFormat.VK_FORMAT_R16_SNORM;
		enum VK_FORMAT_R16_USCALED = VkFormat.VK_FORMAT_R16_USCALED;
		enum VK_FORMAT_R16_SSCALED = VkFormat.VK_FORMAT_R16_SSCALED;
		enum VK_FORMAT_R16_UINT = VkFormat.VK_FORMAT_R16_UINT;
		enum VK_FORMAT_R16_SINT = VkFormat.VK_FORMAT_R16_SINT;
		enum VK_FORMAT_R16_SFLOAT = VkFormat.VK_FORMAT_R16_SFLOAT;
		enum VK_FORMAT_R16G16_UNORM = VkFormat.VK_FORMAT_R16G16_UNORM;
		enum VK_FORMAT_R16G16_SNORM = VkFormat.VK_FORMAT_R16G16_SNORM;
		enum VK_FORMAT_R16G16_USCALED = VkFormat.VK_FORMAT_R16G16_USCALED;
		enum VK_FORMAT_R16G16_SSCALED = VkFormat.VK_FORMAT_R16G16_SSCALED;
		enum VK_FORMAT_R16G16_UINT = VkFormat.VK_FORMAT_R16G16_UINT;
		enum VK_FORMAT_R16G16_SINT = VkFormat.VK_FORMAT_R16G16_SINT;
		enum VK_FORMAT_R16G16_SFLOAT = VkFormat.VK_FORMAT_R16G16_SFLOAT;
		enum VK_FORMAT_R16G16B16_UNORM = VkFormat.VK_FORMAT_R16G16B16_UNORM;
		enum VK_FORMAT_R16G16B16_SNORM = VkFormat.VK_FORMAT_R16G16B16_SNORM;
		enum VK_FORMAT_R16G16B16_USCALED = VkFormat.VK_FORMAT_R16G16B16_USCALED;
		enum VK_FORMAT_R16G16B16_SSCALED = VkFormat.VK_FORMAT_R16G16B16_SSCALED;
		enum VK_FORMAT_R16G16B16_UINT = VkFormat.VK_FORMAT_R16G16B16_UINT;
		enum VK_FORMAT_R16G16B16_SINT = VkFormat.VK_FORMAT_R16G16B16_SINT;
		enum VK_FORMAT_R16G16B16_SFLOAT = VkFormat.VK_FORMAT_R16G16B16_SFLOAT;
		enum VK_FORMAT_R16G16B16A16_UNORM = VkFormat.VK_FORMAT_R16G16B16A16_UNORM;
		enum VK_FORMAT_R16G16B16A16_SNORM = VkFormat.VK_FORMAT_R16G16B16A16_SNORM;
		enum VK_FORMAT_R16G16B16A16_USCALED = VkFormat.VK_FORMAT_R16G16B16A16_USCALED;
		enum VK_FORMAT_R16G16B16A16_SSCALED = VkFormat.VK_FORMAT_R16G16B16A16_SSCALED;
		enum VK_FORMAT_R16G16B16A16_UINT = VkFormat.VK_FORMAT_R16G16B16A16_UINT;
		enum VK_FORMAT_R16G16B16A16_SINT = VkFormat.VK_FORMAT_R16G16B16A16_SINT;
		enum VK_FORMAT_R16G16B16A16_SFLOAT = VkFormat.VK_FORMAT_R16G16B16A16_SFLOAT;
		enum VK_FORMAT_R32_UINT = VkFormat.VK_FORMAT_R32_UINT;
		enum VK_FORMAT_R32_SINT = VkFormat.VK_FORMAT_R32_SINT;
		enum VK_FORMAT_R32_SFLOAT = VkFormat.VK_FORMAT_R32_SFLOAT;
		enum VK_FORMAT_R32G32_UINT = VkFormat.VK_FORMAT_R32G32_UINT;
		enum VK_FORMAT_R32G32_SINT = VkFormat.VK_FORMAT_R32G32_SINT;
		enum VK_FORMAT_R32G32_SFLOAT = VkFormat.VK_FORMAT_R32G32_SFLOAT;
		enum VK_FORMAT_R32G32B32_UINT = VkFormat.VK_FORMAT_R32G32B32_UINT;
		enum VK_FORMAT_R32G32B32_SINT = VkFormat.VK_FORMAT_R32G32B32_SINT;
		enum VK_FORMAT_R32G32B32_SFLOAT = VkFormat.VK_FORMAT_R32G32B32_SFLOAT;
		enum VK_FORMAT_R32G32B32A32_UINT = VkFormat.VK_FORMAT_R32G32B32A32_UINT;
		enum VK_FORMAT_R32G32B32A32_SINT = VkFormat.VK_FORMAT_R32G32B32A32_SINT;
		enum VK_FORMAT_R32G32B32A32_SFLOAT = VkFormat.VK_FORMAT_R32G32B32A32_SFLOAT;
		enum VK_FORMAT_R64_UINT = VkFormat.VK_FORMAT_R64_UINT;
		enum VK_FORMAT_R64_SINT = VkFormat.VK_FORMAT_R64_SINT;
		enum VK_FORMAT_R64_SFLOAT = VkFormat.VK_FORMAT_R64_SFLOAT;
		enum VK_FORMAT_R64G64_UINT = VkFormat.VK_FORMAT_R64G64_UINT;
		enum VK_FORMAT_R64G64_SINT = VkFormat.VK_FORMAT_R64G64_SINT;
		enum VK_FORMAT_R64G64_SFLOAT = VkFormat.VK_FORMAT_R64G64_SFLOAT;
		enum VK_FORMAT_R64G64B64_UINT = VkFormat.VK_FORMAT_R64G64B64_UINT;
		enum VK_FORMAT_R64G64B64_SINT = VkFormat.VK_FORMAT_R64G64B64_SINT;
		enum VK_FORMAT_R64G64B64_SFLOAT = VkFormat.VK_FORMAT_R64G64B64_SFLOAT;
		enum VK_FORMAT_R64G64B64A64_UINT = VkFormat.VK_FORMAT_R64G64B64A64_UINT;
		enum VK_FORMAT_R64G64B64A64_SINT = VkFormat.VK_FORMAT_R64G64B64A64_SINT;
		enum VK_FORMAT_R64G64B64A64_SFLOAT = VkFormat.VK_FORMAT_R64G64B64A64_SFLOAT;
		enum VK_FORMAT_B10G11R11_UFLOAT_PACK32 = VkFormat.VK_FORMAT_B10G11R11_UFLOAT_PACK32;
		enum VK_FORMAT_E5B9G9R9_UFLOAT_PACK32 = VkFormat.VK_FORMAT_E5B9G9R9_UFLOAT_PACK32;
		enum VK_FORMAT_D16_UNORM = VkFormat.VK_FORMAT_D16_UNORM;
		enum VK_FORMAT_X8_D24_UNORM_PACK32 = VkFormat.VK_FORMAT_X8_D24_UNORM_PACK32;
		enum VK_FORMAT_D32_SFLOAT = VkFormat.VK_FORMAT_D32_SFLOAT;
		enum VK_FORMAT_S8_UINT = VkFormat.VK_FORMAT_S8_UINT;
		enum VK_FORMAT_D16_UNORM_S8_UINT = VkFormat.VK_FORMAT_D16_UNORM_S8_UINT;
		enum VK_FORMAT_D24_UNORM_S8_UINT = VkFormat.VK_FORMAT_D24_UNORM_S8_UINT;
		enum VK_FORMAT_D32_SFLOAT_S8_UINT = VkFormat.VK_FORMAT_D32_SFLOAT_S8_UINT;
		enum VK_FORMAT_BC1_RGB_UNORM_BLOCK = VkFormat.VK_FORMAT_BC1_RGB_UNORM_BLOCK;
		enum VK_FORMAT_BC1_RGB_SRGB_BLOCK = VkFormat.VK_FORMAT_BC1_RGB_SRGB_BLOCK;
		enum VK_FORMAT_BC1_RGBA_UNORM_BLOCK = VkFormat.VK_FORMAT_BC1_RGBA_UNORM_BLOCK;
		enum VK_FORMAT_BC1_RGBA_SRGB_BLOCK = VkFormat.VK_FORMAT_BC1_RGBA_SRGB_BLOCK;
		enum VK_FORMAT_BC2_UNORM_BLOCK = VkFormat.VK_FORMAT_BC2_UNORM_BLOCK;
		enum VK_FORMAT_BC2_SRGB_BLOCK = VkFormat.VK_FORMAT_BC2_SRGB_BLOCK;
		enum VK_FORMAT_BC3_UNORM_BLOCK = VkFormat.VK_FORMAT_BC3_UNORM_BLOCK;
		enum VK_FORMAT_BC3_SRGB_BLOCK = VkFormat.VK_FORMAT_BC3_SRGB_BLOCK;
		enum VK_FORMAT_BC4_UNORM_BLOCK = VkFormat.VK_FORMAT_BC4_UNORM_BLOCK;
		enum VK_FORMAT_BC4_SNORM_BLOCK = VkFormat.VK_FORMAT_BC4_SNORM_BLOCK;
		enum VK_FORMAT_BC5_UNORM_BLOCK = VkFormat.VK_FORMAT_BC5_UNORM_BLOCK;
		enum VK_FORMAT_BC5_SNORM_BLOCK = VkFormat.VK_FORMAT_BC5_SNORM_BLOCK;
		enum VK_FORMAT_BC6H_UFLOAT_BLOCK = VkFormat.VK_FORMAT_BC6H_UFLOAT_BLOCK;
		enum VK_FORMAT_BC6H_SFLOAT_BLOCK = VkFormat.VK_FORMAT_BC6H_SFLOAT_BLOCK;
		enum VK_FORMAT_BC7_UNORM_BLOCK = VkFormat.VK_FORMAT_BC7_UNORM_BLOCK;
		enum VK_FORMAT_BC7_SRGB_BLOCK = VkFormat.VK_FORMAT_BC7_SRGB_BLOCK;
		enum VK_FORMAT_ETC2_R8G8B8_UNORM_BLOCK = VkFormat.VK_FORMAT_ETC2_R8G8B8_UNORM_BLOCK;
		enum VK_FORMAT_ETC2_R8G8B8_SRGB_BLOCK = VkFormat.VK_FORMAT_ETC2_R8G8B8_SRGB_BLOCK;
		enum VK_FORMAT_ETC2_R8G8B8A1_UNORM_BLOCK = VkFormat.VK_FORMAT_ETC2_R8G8B8A1_UNORM_BLOCK;
		enum VK_FORMAT_ETC2_R8G8B8A1_SRGB_BLOCK = VkFormat.VK_FORMAT_ETC2_R8G8B8A1_SRGB_BLOCK;
		enum VK_FORMAT_ETC2_R8G8B8A8_UNORM_BLOCK = VkFormat.VK_FORMAT_ETC2_R8G8B8A8_UNORM_BLOCK;
		enum VK_FORMAT_ETC2_R8G8B8A8_SRGB_BLOCK = VkFormat.VK_FORMAT_ETC2_R8G8B8A8_SRGB_BLOCK;
		enum VK_FORMAT_EAC_R11_UNORM_BLOCK = VkFormat.VK_FORMAT_EAC_R11_UNORM_BLOCK;
		enum VK_FORMAT_EAC_R11_SNORM_BLOCK = VkFormat.VK_FORMAT_EAC_R11_SNORM_BLOCK;
		enum VK_FORMAT_EAC_R11G11_UNORM_BLOCK = VkFormat.VK_FORMAT_EAC_R11G11_UNORM_BLOCK;
		enum VK_FORMAT_EAC_R11G11_SNORM_BLOCK = VkFormat.VK_FORMAT_EAC_R11G11_SNORM_BLOCK;
		enum VK_FORMAT_ASTC_4x4_UNORM_BLOCK = VkFormat.VK_FORMAT_ASTC_4x4_UNORM_BLOCK;
		enum VK_FORMAT_ASTC_4x4_SRGB_BLOCK = VkFormat.VK_FORMAT_ASTC_4x4_SRGB_BLOCK;
		enum VK_FORMAT_ASTC_5x4_UNORM_BLOCK = VkFormat.VK_FORMAT_ASTC_5x4_UNORM_BLOCK;
		enum VK_FORMAT_ASTC_5x4_SRGB_BLOCK = VkFormat.VK_FORMAT_ASTC_5x4_SRGB_BLOCK;
		enum VK_FORMAT_ASTC_5x5_UNORM_BLOCK = VkFormat.VK_FORMAT_ASTC_5x5_UNORM_BLOCK;
		enum VK_FORMAT_ASTC_5x5_SRGB_BLOCK = VkFormat.VK_FORMAT_ASTC_5x5_SRGB_BLOCK;
		enum VK_FORMAT_ASTC_6x5_UNORM_BLOCK = VkFormat.VK_FORMAT_ASTC_6x5_UNORM_BLOCK;
		enum VK_FORMAT_ASTC_6x5_SRGB_BLOCK = VkFormat.VK_FORMAT_ASTC_6x5_SRGB_BLOCK;
		enum VK_FORMAT_ASTC_6x6_UNORM_BLOCK = VkFormat.VK_FORMAT_ASTC_6x6_UNORM_BLOCK;
		enum VK_FORMAT_ASTC_6x6_SRGB_BLOCK = VkFormat.VK_FORMAT_ASTC_6x6_SRGB_BLOCK;
		enum VK_FORMAT_ASTC_8x5_UNORM_BLOCK = VkFormat.VK_FORMAT_ASTC_8x5_UNORM_BLOCK;
		enum VK_FORMAT_ASTC_8x5_SRGB_BLOCK = VkFormat.VK_FORMAT_ASTC_8x5_SRGB_BLOCK;
		enum VK_FORMAT_ASTC_8x6_UNORM_BLOCK = VkFormat.VK_FORMAT_ASTC_8x6_UNORM_BLOCK;
		enum VK_FORMAT_ASTC_8x6_SRGB_BLOCK = VkFormat.VK_FORMAT_ASTC_8x6_SRGB_BLOCK;
		enum VK_FORMAT_ASTC_8x8_UNORM_BLOCK = VkFormat.VK_FORMAT_ASTC_8x8_UNORM_BLOCK;
		enum VK_FORMAT_ASTC_8x8_SRGB_BLOCK = VkFormat.VK_FORMAT_ASTC_8x8_SRGB_BLOCK;
		enum VK_FORMAT_ASTC_10x5_UNORM_BLOCK = VkFormat.VK_FORMAT_ASTC_10x5_UNORM_BLOCK;
		enum VK_FORMAT_ASTC_10x5_SRGB_BLOCK = VkFormat.VK_FORMAT_ASTC_10x5_SRGB_BLOCK;
		enum VK_FORMAT_ASTC_10x6_UNORM_BLOCK = VkFormat.VK_FORMAT_ASTC_10x6_UNORM_BLOCK;
		enum VK_FORMAT_ASTC_10x6_SRGB_BLOCK = VkFormat.VK_FORMAT_ASTC_10x6_SRGB_BLOCK;
		enum VK_FORMAT_ASTC_10x8_UNORM_BLOCK = VkFormat.VK_FORMAT_ASTC_10x8_UNORM_BLOCK;
		enum VK_FORMAT_ASTC_10x8_SRGB_BLOCK = VkFormat.VK_FORMAT_ASTC_10x8_SRGB_BLOCK;
		enum VK_FORMAT_ASTC_10x10_UNORM_BLOCK = VkFormat.VK_FORMAT_ASTC_10x10_UNORM_BLOCK;
		enum VK_FORMAT_ASTC_10x10_SRGB_BLOCK = VkFormat.VK_FORMAT_ASTC_10x10_SRGB_BLOCK;
		enum VK_FORMAT_ASTC_12x10_UNORM_BLOCK = VkFormat.VK_FORMAT_ASTC_12x10_UNORM_BLOCK;
		enum VK_FORMAT_ASTC_12x10_SRGB_BLOCK = VkFormat.VK_FORMAT_ASTC_12x10_SRGB_BLOCK;
		enum VK_FORMAT_ASTC_12x12_UNORM_BLOCK = VkFormat.VK_FORMAT_ASTC_12x12_UNORM_BLOCK;
		enum VK_FORMAT_ASTC_12x12_SRGB_BLOCK = VkFormat.VK_FORMAT_ASTC_12x12_SRGB_BLOCK;
		enum VK_FORMAT_FEATURE_SAMPLED_IMAGE_BIT = VkFormatFeatureFlagBits.VK_FORMAT_FEATURE_SAMPLED_IMAGE_BIT;
		enum VK_FORMAT_FEATURE_STORAGE_IMAGE_BIT = VkFormatFeatureFlagBits.VK_FORMAT_FEATURE_STORAGE_IMAGE_BIT;
		enum VK_FORMAT_FEATURE_STORAGE_IMAGE_ATOMIC_BIT = VkFormatFeatureFlagBits.VK_FORMAT_FEATURE_STORAGE_IMAGE_ATOMIC_BIT;
		enum VK_FORMAT_FEATURE_UNIFORM_TEXEL_BUFFER_BIT = VkFormatFeatureFlagBits.VK_FORMAT_FEATURE_UNIFORM_TEXEL_BUFFER_BIT;
		enum VK_FORMAT_FEATURE_STORAGE_TEXEL_BUFFER_BIT = VkFormatFeatureFlagBits.VK_FORMAT_FEATURE_STORAGE_TEXEL_BUFFER_BIT;
		enum VK_FORMAT_FEATURE_STORAGE_TEXEL_BUFFER_ATOMIC_BIT = VkFormatFeatureFlagBits.VK_FORMAT_FEATURE_STORAGE_TEXEL_BUFFER_ATOMIC_BIT;
		enum VK_FORMAT_FEATURE_VERTEX_BUFFER_BIT = VkFormatFeatureFlagBits.VK_FORMAT_FEATURE_VERTEX_BUFFER_BIT;
		enum VK_FORMAT_FEATURE_COLOR_ATTACHMENT_BIT = VkFormatFeatureFlagBits.VK_FORMAT_FEATURE_COLOR_ATTACHMENT_BIT;
		enum VK_FORMAT_FEATURE_COLOR_ATTACHMENT_BLEND_BIT = VkFormatFeatureFlagBits.VK_FORMAT_FEATURE_COLOR_ATTACHMENT_BLEND_BIT;
		enum VK_FORMAT_FEATURE_DEPTH_STENCIL_ATTACHMENT_BIT = VkFormatFeatureFlagBits.VK_FORMAT_FEATURE_DEPTH_STENCIL_ATTACHMENT_BIT;
		enum VK_FORMAT_FEATURE_BLIT_SRC_BIT = VkFormatFeatureFlagBits.VK_FORMAT_FEATURE_BLIT_SRC_BIT;
		enum VK_FORMAT_FEATURE_BLIT_DST_BIT = VkFormatFeatureFlagBits.VK_FORMAT_FEATURE_BLIT_DST_BIT;
		enum VK_FORMAT_FEATURE_SAMPLED_IMAGE_FILTER_LINEAR_BIT = VkFormatFeatureFlagBits.VK_FORMAT_FEATURE_SAMPLED_IMAGE_FILTER_LINEAR_BIT;
		enum VK_FORMAT_FEATURE_SAMPLED_IMAGE_FILTER_CUBIC_BIT_IMG = VkFormatFeatureFlagBits.VK_FORMAT_FEATURE_SAMPLED_IMAGE_FILTER_CUBIC_BIT_IMG;
		enum VK_IMAGE_TYPE_1D = VkImageType.VK_IMAGE_TYPE_1D;
		enum VK_IMAGE_TYPE_2D = VkImageType.VK_IMAGE_TYPE_2D;
		enum VK_IMAGE_TYPE_3D = VkImageType.VK_IMAGE_TYPE_3D;
		enum VK_IMAGE_TILING_OPTIMAL = VkImageTiling.VK_IMAGE_TILING_OPTIMAL;
		enum VK_IMAGE_TILING_LINEAR = VkImageTiling.VK_IMAGE_TILING_LINEAR;
		enum VK_IMAGE_USAGE_TRANSFER_SRC_BIT = VkImageUsageFlagBits.VK_IMAGE_USAGE_TRANSFER_SRC_BIT;
		enum VK_IMAGE_USAGE_TRANSFER_DST_BIT = VkImageUsageFlagBits.VK_IMAGE_USAGE_TRANSFER_DST_BIT;
		enum VK_IMAGE_USAGE_SAMPLED_BIT = VkImageUsageFlagBits.VK_IMAGE_USAGE_SAMPLED_BIT;
		enum VK_IMAGE_USAGE_STORAGE_BIT = VkImageUsageFlagBits.VK_IMAGE_USAGE_STORAGE_BIT;
		enum VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT = VkImageUsageFlagBits.VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT;
		enum VK_IMAGE_USAGE_DEPTH_STENCIL_ATTACHMENT_BIT = VkImageUsageFlagBits.VK_IMAGE_USAGE_DEPTH_STENCIL_ATTACHMENT_BIT;
		enum VK_IMAGE_USAGE_TRANSIENT_ATTACHMENT_BIT = VkImageUsageFlagBits.VK_IMAGE_USAGE_TRANSIENT_ATTACHMENT_BIT;
		enum VK_IMAGE_USAGE_INPUT_ATTACHMENT_BIT = VkImageUsageFlagBits.VK_IMAGE_USAGE_INPUT_ATTACHMENT_BIT;
		enum VK_IMAGE_CREATE_SPARSE_BINDING_BIT = VkImageCreateFlagBits.VK_IMAGE_CREATE_SPARSE_BINDING_BIT;
		enum VK_IMAGE_CREATE_SPARSE_RESIDENCY_BIT = VkImageCreateFlagBits.VK_IMAGE_CREATE_SPARSE_RESIDENCY_BIT;
		enum VK_IMAGE_CREATE_SPARSE_ALIASED_BIT = VkImageCreateFlagBits.VK_IMAGE_CREATE_SPARSE_ALIASED_BIT;
		enum VK_IMAGE_CREATE_MUTABLE_FORMAT_BIT = VkImageCreateFlagBits.VK_IMAGE_CREATE_MUTABLE_FORMAT_BIT;
		enum VK_IMAGE_CREATE_CUBE_COMPATIBLE_BIT = VkImageCreateFlagBits.VK_IMAGE_CREATE_CUBE_COMPATIBLE_BIT;
		enum VK_SAMPLE_COUNT_1_BIT = VkSampleCountFlagBits.VK_SAMPLE_COUNT_1_BIT;
		enum VK_SAMPLE_COUNT_2_BIT = VkSampleCountFlagBits.VK_SAMPLE_COUNT_2_BIT;
		enum VK_SAMPLE_COUNT_4_BIT = VkSampleCountFlagBits.VK_SAMPLE_COUNT_4_BIT;
		enum VK_SAMPLE_COUNT_8_BIT = VkSampleCountFlagBits.VK_SAMPLE_COUNT_8_BIT;
		enum VK_SAMPLE_COUNT_16_BIT = VkSampleCountFlagBits.VK_SAMPLE_COUNT_16_BIT;
		enum VK_SAMPLE_COUNT_32_BIT = VkSampleCountFlagBits.VK_SAMPLE_COUNT_32_BIT;
		enum VK_SAMPLE_COUNT_64_BIT = VkSampleCountFlagBits.VK_SAMPLE_COUNT_64_BIT;
		enum VK_PHYSICAL_DEVICE_TYPE_OTHER = VkPhysicalDeviceType.VK_PHYSICAL_DEVICE_TYPE_OTHER;
		enum VK_PHYSICAL_DEVICE_TYPE_INTEGRATED_GPU = VkPhysicalDeviceType.VK_PHYSICAL_DEVICE_TYPE_INTEGRATED_GPU;
		enum VK_PHYSICAL_DEVICE_TYPE_DISCRETE_GPU = VkPhysicalDeviceType.VK_PHYSICAL_DEVICE_TYPE_DISCRETE_GPU;
		enum VK_PHYSICAL_DEVICE_TYPE_VIRTUAL_GPU = VkPhysicalDeviceType.VK_PHYSICAL_DEVICE_TYPE_VIRTUAL_GPU;
		enum VK_PHYSICAL_DEVICE_TYPE_CPU = VkPhysicalDeviceType.VK_PHYSICAL_DEVICE_TYPE_CPU;
		enum VK_QUEUE_GRAPHICS_BIT = VkQueueFlagBits.VK_QUEUE_GRAPHICS_BIT;
		enum VK_QUEUE_COMPUTE_BIT = VkQueueFlagBits.VK_QUEUE_COMPUTE_BIT;
		enum VK_QUEUE_TRANSFER_BIT = VkQueueFlagBits.VK_QUEUE_TRANSFER_BIT;
		enum VK_QUEUE_SPARSE_BINDING_BIT = VkQueueFlagBits.VK_QUEUE_SPARSE_BINDING_BIT;
		enum VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT = VkMemoryPropertyFlagBits.VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT;
		enum VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT = VkMemoryPropertyFlagBits.VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT;
		enum VK_MEMORY_PROPERTY_HOST_COHERENT_BIT = VkMemoryPropertyFlagBits.VK_MEMORY_PROPERTY_HOST_COHERENT_BIT;
		enum VK_MEMORY_PROPERTY_HOST_CACHED_BIT = VkMemoryPropertyFlagBits.VK_MEMORY_PROPERTY_HOST_CACHED_BIT;
		enum VK_MEMORY_PROPERTY_LAZILY_ALLOCATED_BIT = VkMemoryPropertyFlagBits.VK_MEMORY_PROPERTY_LAZILY_ALLOCATED_BIT;
		enum VK_MEMORY_HEAP_DEVICE_LOCAL_BIT = VkMemoryHeapFlagBits.VK_MEMORY_HEAP_DEVICE_LOCAL_BIT;
		enum VK_PIPELINE_STAGE_TOP_OF_PIPE_BIT = VkPipelineStageFlagBits.VK_PIPELINE_STAGE_TOP_OF_PIPE_BIT;
		enum VK_PIPELINE_STAGE_DRAW_INDIRECT_BIT = VkPipelineStageFlagBits.VK_PIPELINE_STAGE_DRAW_INDIRECT_BIT;
		enum VK_PIPELINE_STAGE_VERTEX_INPUT_BIT = VkPipelineStageFlagBits.VK_PIPELINE_STAGE_VERTEX_INPUT_BIT;
		enum VK_PIPELINE_STAGE_VERTEX_SHADER_BIT = VkPipelineStageFlagBits.VK_PIPELINE_STAGE_VERTEX_SHADER_BIT;
		enum VK_PIPELINE_STAGE_TESSELLATION_CONTROL_SHADER_BIT = VkPipelineStageFlagBits.VK_PIPELINE_STAGE_TESSELLATION_CONTROL_SHADER_BIT;
		enum VK_PIPELINE_STAGE_TESSELLATION_EVALUATION_SHADER_BIT = VkPipelineStageFlagBits.VK_PIPELINE_STAGE_TESSELLATION_EVALUATION_SHADER_BIT;
		enum VK_PIPELINE_STAGE_GEOMETRY_SHADER_BIT = VkPipelineStageFlagBits.VK_PIPELINE_STAGE_GEOMETRY_SHADER_BIT;
		enum VK_PIPELINE_STAGE_FRAGMENT_SHADER_BIT = VkPipelineStageFlagBits.VK_PIPELINE_STAGE_FRAGMENT_SHADER_BIT;
		enum VK_PIPELINE_STAGE_EARLY_FRAGMENT_TESTS_BIT = VkPipelineStageFlagBits.VK_PIPELINE_STAGE_EARLY_FRAGMENT_TESTS_BIT;
		enum VK_PIPELINE_STAGE_LATE_FRAGMENT_TESTS_BIT = VkPipelineStageFlagBits.VK_PIPELINE_STAGE_LATE_FRAGMENT_TESTS_BIT;
		enum VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT = VkPipelineStageFlagBits.VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT;
		enum VK_PIPELINE_STAGE_COMPUTE_SHADER_BIT = VkPipelineStageFlagBits.VK_PIPELINE_STAGE_COMPUTE_SHADER_BIT;
		enum VK_PIPELINE_STAGE_TRANSFER_BIT = VkPipelineStageFlagBits.VK_PIPELINE_STAGE_TRANSFER_BIT;
		enum VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT = VkPipelineStageFlagBits.VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT;
		enum VK_PIPELINE_STAGE_HOST_BIT = VkPipelineStageFlagBits.VK_PIPELINE_STAGE_HOST_BIT;
		enum VK_PIPELINE_STAGE_ALL_GRAPHICS_BIT = VkPipelineStageFlagBits.VK_PIPELINE_STAGE_ALL_GRAPHICS_BIT;
		enum VK_PIPELINE_STAGE_ALL_COMMANDS_BIT = VkPipelineStageFlagBits.VK_PIPELINE_STAGE_ALL_COMMANDS_BIT;
		enum VK_IMAGE_ASPECT_COLOR_BIT = VkImageAspectFlagBits.VK_IMAGE_ASPECT_COLOR_BIT;
		enum VK_IMAGE_ASPECT_DEPTH_BIT = VkImageAspectFlagBits.VK_IMAGE_ASPECT_DEPTH_BIT;
		enum VK_IMAGE_ASPECT_STENCIL_BIT = VkImageAspectFlagBits.VK_IMAGE_ASPECT_STENCIL_BIT;
		enum VK_IMAGE_ASPECT_METADATA_BIT = VkImageAspectFlagBits.VK_IMAGE_ASPECT_METADATA_BIT;
		enum VK_SPARSE_IMAGE_FORMAT_SINGLE_MIPTAIL_BIT = VkSparseImageFormatFlagBits.VK_SPARSE_IMAGE_FORMAT_SINGLE_MIPTAIL_BIT;
		enum VK_SPARSE_IMAGE_FORMAT_ALIGNED_MIP_SIZE_BIT = VkSparseImageFormatFlagBits.VK_SPARSE_IMAGE_FORMAT_ALIGNED_MIP_SIZE_BIT;
		enum VK_SPARSE_IMAGE_FORMAT_NONSTANDARD_BLOCK_SIZE_BIT = VkSparseImageFormatFlagBits.VK_SPARSE_IMAGE_FORMAT_NONSTANDARD_BLOCK_SIZE_BIT;
		enum VK_SPARSE_MEMORY_BIND_METADATA_BIT = VkSparseMemoryBindFlagBits.VK_SPARSE_MEMORY_BIND_METADATA_BIT;
		enum VK_FENCE_CREATE_SIGNALED_BIT = VkFenceCreateFlagBits.VK_FENCE_CREATE_SIGNALED_BIT;
		enum VK_QUERY_TYPE_OCCLUSION = VkQueryType.VK_QUERY_TYPE_OCCLUSION;
		enum VK_QUERY_TYPE_PIPELINE_STATISTICS = VkQueryType.VK_QUERY_TYPE_PIPELINE_STATISTICS;
		enum VK_QUERY_TYPE_TIMESTAMP = VkQueryType.VK_QUERY_TYPE_TIMESTAMP;
		enum VK_QUERY_PIPELINE_STATISTIC_INPUT_ASSEMBLY_VERTICES_BIT = VkQueryPipelineStatisticFlagBits.VK_QUERY_PIPELINE_STATISTIC_INPUT_ASSEMBLY_VERTICES_BIT;
		enum VK_QUERY_PIPELINE_STATISTIC_INPUT_ASSEMBLY_PRIMITIVES_BIT = VkQueryPipelineStatisticFlagBits.VK_QUERY_PIPELINE_STATISTIC_INPUT_ASSEMBLY_PRIMITIVES_BIT;
		enum VK_QUERY_PIPELINE_STATISTIC_VERTEX_SHADER_INVOCATIONS_BIT = VkQueryPipelineStatisticFlagBits.VK_QUERY_PIPELINE_STATISTIC_VERTEX_SHADER_INVOCATIONS_BIT;
		enum VK_QUERY_PIPELINE_STATISTIC_GEOMETRY_SHADER_INVOCATIONS_BIT = VkQueryPipelineStatisticFlagBits.VK_QUERY_PIPELINE_STATISTIC_GEOMETRY_SHADER_INVOCATIONS_BIT;
		enum VK_QUERY_PIPELINE_STATISTIC_GEOMETRY_SHADER_PRIMITIVES_BIT = VkQueryPipelineStatisticFlagBits.VK_QUERY_PIPELINE_STATISTIC_GEOMETRY_SHADER_PRIMITIVES_BIT;
		enum VK_QUERY_PIPELINE_STATISTIC_CLIPPING_INVOCATIONS_BIT = VkQueryPipelineStatisticFlagBits.VK_QUERY_PIPELINE_STATISTIC_CLIPPING_INVOCATIONS_BIT;
		enum VK_QUERY_PIPELINE_STATISTIC_CLIPPING_PRIMITIVES_BIT = VkQueryPipelineStatisticFlagBits.VK_QUERY_PIPELINE_STATISTIC_CLIPPING_PRIMITIVES_BIT;
		enum VK_QUERY_PIPELINE_STATISTIC_FRAGMENT_SHADER_INVOCATIONS_BIT = VkQueryPipelineStatisticFlagBits.VK_QUERY_PIPELINE_STATISTIC_FRAGMENT_SHADER_INVOCATIONS_BIT;
		enum VK_QUERY_PIPELINE_STATISTIC_TESSELLATION_CONTROL_SHADER_PATCHES_BIT = VkQueryPipelineStatisticFlagBits.VK_QUERY_PIPELINE_STATISTIC_TESSELLATION_CONTROL_SHADER_PATCHES_BIT;
		enum VK_QUERY_PIPELINE_STATISTIC_TESSELLATION_EVALUATION_SHADER_INVOCATIONS_BIT = VkQueryPipelineStatisticFlagBits.VK_QUERY_PIPELINE_STATISTIC_TESSELLATION_EVALUATION_SHADER_INVOCATIONS_BIT;
		enum VK_QUERY_PIPELINE_STATISTIC_COMPUTE_SHADER_INVOCATIONS_BIT = VkQueryPipelineStatisticFlagBits.VK_QUERY_PIPELINE_STATISTIC_COMPUTE_SHADER_INVOCATIONS_BIT;
		enum VK_QUERY_RESULT_64_BIT = VkQueryResultFlagBits.VK_QUERY_RESULT_64_BIT;
		enum VK_QUERY_RESULT_WAIT_BIT = VkQueryResultFlagBits.VK_QUERY_RESULT_WAIT_BIT;
		enum VK_QUERY_RESULT_WITH_AVAILABILITY_BIT = VkQueryResultFlagBits.VK_QUERY_RESULT_WITH_AVAILABILITY_BIT;
		enum VK_QUERY_RESULT_PARTIAL_BIT = VkQueryResultFlagBits.VK_QUERY_RESULT_PARTIAL_BIT;
		enum VK_BUFFER_CREATE_SPARSE_BINDING_BIT = VkBufferCreateFlagBits.VK_BUFFER_CREATE_SPARSE_BINDING_BIT;
		enum VK_BUFFER_CREATE_SPARSE_RESIDENCY_BIT = VkBufferCreateFlagBits.VK_BUFFER_CREATE_SPARSE_RESIDENCY_BIT;
		enum VK_BUFFER_CREATE_SPARSE_ALIASED_BIT = VkBufferCreateFlagBits.VK_BUFFER_CREATE_SPARSE_ALIASED_BIT;
		enum VK_BUFFER_USAGE_TRANSFER_SRC_BIT = VkBufferUsageFlagBits.VK_BUFFER_USAGE_TRANSFER_SRC_BIT;
		enum VK_BUFFER_USAGE_TRANSFER_DST_BIT = VkBufferUsageFlagBits.VK_BUFFER_USAGE_TRANSFER_DST_BIT;
		enum VK_BUFFER_USAGE_UNIFORM_TEXEL_BUFFER_BIT = VkBufferUsageFlagBits.VK_BUFFER_USAGE_UNIFORM_TEXEL_BUFFER_BIT;
		enum VK_BUFFER_USAGE_STORAGE_TEXEL_BUFFER_BIT = VkBufferUsageFlagBits.VK_BUFFER_USAGE_STORAGE_TEXEL_BUFFER_BIT;
		enum VK_BUFFER_USAGE_UNIFORM_BUFFER_BIT = VkBufferUsageFlagBits.VK_BUFFER_USAGE_UNIFORM_BUFFER_BIT;
		enum VK_BUFFER_USAGE_STORAGE_BUFFER_BIT = VkBufferUsageFlagBits.VK_BUFFER_USAGE_STORAGE_BUFFER_BIT;
		enum VK_BUFFER_USAGE_INDEX_BUFFER_BIT = VkBufferUsageFlagBits.VK_BUFFER_USAGE_INDEX_BUFFER_BIT;
		enum VK_BUFFER_USAGE_VERTEX_BUFFER_BIT = VkBufferUsageFlagBits.VK_BUFFER_USAGE_VERTEX_BUFFER_BIT;
		enum VK_BUFFER_USAGE_INDIRECT_BUFFER_BIT = VkBufferUsageFlagBits.VK_BUFFER_USAGE_INDIRECT_BUFFER_BIT;
		enum VK_SHARING_MODE_EXCLUSIVE = VkSharingMode.VK_SHARING_MODE_EXCLUSIVE;
		enum VK_SHARING_MODE_CONCURRENT = VkSharingMode.VK_SHARING_MODE_CONCURRENT;
		enum VK_IMAGE_LAYOUT_UNDEFINED = VkImageLayout.VK_IMAGE_LAYOUT_UNDEFINED;
		enum VK_IMAGE_LAYOUT_GENERAL = VkImageLayout.VK_IMAGE_LAYOUT_GENERAL;
		enum VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL = VkImageLayout.VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL;
		enum VK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL = VkImageLayout.VK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL;
		enum VK_IMAGE_LAYOUT_DEPTH_STENCIL_READ_ONLY_OPTIMAL = VkImageLayout.VK_IMAGE_LAYOUT_DEPTH_STENCIL_READ_ONLY_OPTIMAL;
		enum VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL = VkImageLayout.VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL;
		enum VK_IMAGE_LAYOUT_TRANSFER_SRC_OPTIMAL = VkImageLayout.VK_IMAGE_LAYOUT_TRANSFER_SRC_OPTIMAL;
		enum VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL = VkImageLayout.VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL;
		enum VK_IMAGE_LAYOUT_PREINITIALIZED = VkImageLayout.VK_IMAGE_LAYOUT_PREINITIALIZED;
		enum VK_IMAGE_LAYOUT_PRESENT_SRC_KHR = VkImageLayout.VK_IMAGE_LAYOUT_PRESENT_SRC_KHR;
		enum VK_IMAGE_VIEW_TYPE_1D = VkImageViewType.VK_IMAGE_VIEW_TYPE_1D;
		enum VK_IMAGE_VIEW_TYPE_2D = VkImageViewType.VK_IMAGE_VIEW_TYPE_2D;
		enum VK_IMAGE_VIEW_TYPE_3D = VkImageViewType.VK_IMAGE_VIEW_TYPE_3D;
		enum VK_IMAGE_VIEW_TYPE_CUBE = VkImageViewType.VK_IMAGE_VIEW_TYPE_CUBE;
		enum VK_IMAGE_VIEW_TYPE_1D_ARRAY = VkImageViewType.VK_IMAGE_VIEW_TYPE_1D_ARRAY;
		enum VK_IMAGE_VIEW_TYPE_2D_ARRAY = VkImageViewType.VK_IMAGE_VIEW_TYPE_2D_ARRAY;
		enum VK_IMAGE_VIEW_TYPE_CUBE_ARRAY = VkImageViewType.VK_IMAGE_VIEW_TYPE_CUBE_ARRAY;
		enum VK_COMPONENT_SWIZZLE_IDENTITY = VkComponentSwizzle.VK_COMPONENT_SWIZZLE_IDENTITY;
		enum VK_COMPONENT_SWIZZLE_ZERO = VkComponentSwizzle.VK_COMPONENT_SWIZZLE_ZERO;
		enum VK_COMPONENT_SWIZZLE_ONE = VkComponentSwizzle.VK_COMPONENT_SWIZZLE_ONE;
		enum VK_COMPONENT_SWIZZLE_R = VkComponentSwizzle.VK_COMPONENT_SWIZZLE_R;
		enum VK_COMPONENT_SWIZZLE_G = VkComponentSwizzle.VK_COMPONENT_SWIZZLE_G;
		enum VK_COMPONENT_SWIZZLE_B = VkComponentSwizzle.VK_COMPONENT_SWIZZLE_B;
		enum VK_COMPONENT_SWIZZLE_A = VkComponentSwizzle.VK_COMPONENT_SWIZZLE_A;
		enum VK_PIPELINE_CREATE_DISABLE_OPTIMIZATION_BIT = VkPipelineCreateFlagBits.VK_PIPELINE_CREATE_DISABLE_OPTIMIZATION_BIT;
		enum VK_PIPELINE_CREATE_ALLOW_DERIVATIVES_BIT = VkPipelineCreateFlagBits.VK_PIPELINE_CREATE_ALLOW_DERIVATIVES_BIT;
		enum VK_PIPELINE_CREATE_DERIVATIVE_BIT = VkPipelineCreateFlagBits.VK_PIPELINE_CREATE_DERIVATIVE_BIT;
		enum VK_SHADER_STAGE_VERTEX_BIT = VkShaderStageFlagBits.VK_SHADER_STAGE_VERTEX_BIT;
		enum VK_SHADER_STAGE_TESSELLATION_CONTROL_BIT = VkShaderStageFlagBits.VK_SHADER_STAGE_TESSELLATION_CONTROL_BIT;
		enum VK_SHADER_STAGE_TESSELLATION_EVALUATION_BIT = VkShaderStageFlagBits.VK_SHADER_STAGE_TESSELLATION_EVALUATION_BIT;
		enum VK_SHADER_STAGE_GEOMETRY_BIT = VkShaderStageFlagBits.VK_SHADER_STAGE_GEOMETRY_BIT;
		enum VK_SHADER_STAGE_FRAGMENT_BIT = VkShaderStageFlagBits.VK_SHADER_STAGE_FRAGMENT_BIT;
		enum VK_SHADER_STAGE_COMPUTE_BIT = VkShaderStageFlagBits.VK_SHADER_STAGE_COMPUTE_BIT;
		enum VK_SHADER_STAGE_ALL_GRAPHICS = VkShaderStageFlagBits.VK_SHADER_STAGE_ALL_GRAPHICS;
		enum VK_SHADER_STAGE_ALL = VkShaderStageFlagBits.VK_SHADER_STAGE_ALL;
		enum VK_VERTEX_INPUT_RATE_VERTEX = VkVertexInputRate.VK_VERTEX_INPUT_RATE_VERTEX;
		enum VK_VERTEX_INPUT_RATE_INSTANCE = VkVertexInputRate.VK_VERTEX_INPUT_RATE_INSTANCE;
		enum VK_PRIMITIVE_TOPOLOGY_POINT_LIST = VkPrimitiveTopology.VK_PRIMITIVE_TOPOLOGY_POINT_LIST;
		enum VK_PRIMITIVE_TOPOLOGY_LINE_LIST = VkPrimitiveTopology.VK_PRIMITIVE_TOPOLOGY_LINE_LIST;
		enum VK_PRIMITIVE_TOPOLOGY_LINE_STRIP = VkPrimitiveTopology.VK_PRIMITIVE_TOPOLOGY_LINE_STRIP;
		enum VK_PRIMITIVE_TOPOLOGY_TRIANGLE_LIST = VkPrimitiveTopology.VK_PRIMITIVE_TOPOLOGY_TRIANGLE_LIST;
		enum VK_PRIMITIVE_TOPOLOGY_TRIANGLE_STRIP = VkPrimitiveTopology.VK_PRIMITIVE_TOPOLOGY_TRIANGLE_STRIP;
		enum VK_PRIMITIVE_TOPOLOGY_TRIANGLE_FAN = VkPrimitiveTopology.VK_PRIMITIVE_TOPOLOGY_TRIANGLE_FAN;
		enum VK_PRIMITIVE_TOPOLOGY_LINE_LIST_WITH_ADJACENCY = VkPrimitiveTopology.VK_PRIMITIVE_TOPOLOGY_LINE_LIST_WITH_ADJACENCY;
		enum VK_PRIMITIVE_TOPOLOGY_LINE_STRIP_WITH_ADJACENCY = VkPrimitiveTopology.VK_PRIMITIVE_TOPOLOGY_LINE_STRIP_WITH_ADJACENCY;
		enum VK_PRIMITIVE_TOPOLOGY_TRIANGLE_LIST_WITH_ADJACENCY = VkPrimitiveTopology.VK_PRIMITIVE_TOPOLOGY_TRIANGLE_LIST_WITH_ADJACENCY;
		enum VK_PRIMITIVE_TOPOLOGY_TRIANGLE_STRIP_WITH_ADJACENCY = VkPrimitiveTopology.VK_PRIMITIVE_TOPOLOGY_TRIANGLE_STRIP_WITH_ADJACENCY;
		enum VK_PRIMITIVE_TOPOLOGY_PATCH_LIST = VkPrimitiveTopology.VK_PRIMITIVE_TOPOLOGY_PATCH_LIST;
		enum VK_POLYGON_MODE_FILL = VkPolygonMode.VK_POLYGON_MODE_FILL;
		enum VK_POLYGON_MODE_LINE = VkPolygonMode.VK_POLYGON_MODE_LINE;
		enum VK_POLYGON_MODE_POINT = VkPolygonMode.VK_POLYGON_MODE_POINT;
		enum VK_CULL_MODE_NONE = VkCullModeFlagBits.VK_CULL_MODE_NONE;
		enum VK_CULL_MODE_FRONT_BIT = VkCullModeFlagBits.VK_CULL_MODE_FRONT_BIT;
		enum VK_CULL_MODE_BACK_BIT = VkCullModeFlagBits.VK_CULL_MODE_BACK_BIT;
		enum VK_CULL_MODE_FRONT_AND_BACK = VkCullModeFlagBits.VK_CULL_MODE_FRONT_AND_BACK;
		enum VK_FRONT_FACE_COUNTER_CLOCKWISE = VkFrontFace.VK_FRONT_FACE_COUNTER_CLOCKWISE;
		enum VK_FRONT_FACE_CLOCKWISE = VkFrontFace.VK_FRONT_FACE_CLOCKWISE;
		enum VK_COMPARE_OP_NEVER = VkCompareOp.VK_COMPARE_OP_NEVER;
		enum VK_COMPARE_OP_LESS = VkCompareOp.VK_COMPARE_OP_LESS;
		enum VK_COMPARE_OP_EQUAL = VkCompareOp.VK_COMPARE_OP_EQUAL;
		enum VK_COMPARE_OP_LESS_OR_EQUAL = VkCompareOp.VK_COMPARE_OP_LESS_OR_EQUAL;
		enum VK_COMPARE_OP_GREATER = VkCompareOp.VK_COMPARE_OP_GREATER;
		enum VK_COMPARE_OP_NOT_EQUAL = VkCompareOp.VK_COMPARE_OP_NOT_EQUAL;
		enum VK_COMPARE_OP_GREATER_OR_EQUAL = VkCompareOp.VK_COMPARE_OP_GREATER_OR_EQUAL;
		enum VK_COMPARE_OP_ALWAYS = VkCompareOp.VK_COMPARE_OP_ALWAYS;
		enum VK_STENCIL_OP_KEEP = VkStencilOp.VK_STENCIL_OP_KEEP;
		enum VK_STENCIL_OP_ZERO = VkStencilOp.VK_STENCIL_OP_ZERO;
		enum VK_STENCIL_OP_REPLACE = VkStencilOp.VK_STENCIL_OP_REPLACE;
		enum VK_STENCIL_OP_INCREMENT_AND_CLAMP = VkStencilOp.VK_STENCIL_OP_INCREMENT_AND_CLAMP;
		enum VK_STENCIL_OP_DECREMENT_AND_CLAMP = VkStencilOp.VK_STENCIL_OP_DECREMENT_AND_CLAMP;
		enum VK_STENCIL_OP_INVERT = VkStencilOp.VK_STENCIL_OP_INVERT;
		enum VK_STENCIL_OP_INCREMENT_AND_WRAP = VkStencilOp.VK_STENCIL_OP_INCREMENT_AND_WRAP;
		enum VK_STENCIL_OP_DECREMENT_AND_WRAP = VkStencilOp.VK_STENCIL_OP_DECREMENT_AND_WRAP;
		enum VK_LOGIC_OP_CLEAR = VkLogicOp.VK_LOGIC_OP_CLEAR;
		enum VK_LOGIC_OP_AND = VkLogicOp.VK_LOGIC_OP_AND;
		enum VK_LOGIC_OP_AND_REVERSE = VkLogicOp.VK_LOGIC_OP_AND_REVERSE;
		enum VK_LOGIC_OP_COPY = VkLogicOp.VK_LOGIC_OP_COPY;
		enum VK_LOGIC_OP_AND_INVERTED = VkLogicOp.VK_LOGIC_OP_AND_INVERTED;
		enum VK_LOGIC_OP_NO_OP = VkLogicOp.VK_LOGIC_OP_NO_OP;
		enum VK_LOGIC_OP_XOR = VkLogicOp.VK_LOGIC_OP_XOR;
		enum VK_LOGIC_OP_OR = VkLogicOp.VK_LOGIC_OP_OR;
		enum VK_LOGIC_OP_NOR = VkLogicOp.VK_LOGIC_OP_NOR;
		enum VK_LOGIC_OP_EQUIVALENT = VkLogicOp.VK_LOGIC_OP_EQUIVALENT;
		enum VK_LOGIC_OP_INVERT = VkLogicOp.VK_LOGIC_OP_INVERT;
		enum VK_LOGIC_OP_OR_REVERSE = VkLogicOp.VK_LOGIC_OP_OR_REVERSE;
		enum VK_LOGIC_OP_COPY_INVERTED = VkLogicOp.VK_LOGIC_OP_COPY_INVERTED;
		enum VK_LOGIC_OP_OR_INVERTED = VkLogicOp.VK_LOGIC_OP_OR_INVERTED;
		enum VK_LOGIC_OP_NAND = VkLogicOp.VK_LOGIC_OP_NAND;
		enum VK_LOGIC_OP_SET = VkLogicOp.VK_LOGIC_OP_SET;
		enum VK_BLEND_FACTOR_ZERO = VkBlendFactor.VK_BLEND_FACTOR_ZERO;
		enum VK_BLEND_FACTOR_ONE = VkBlendFactor.VK_BLEND_FACTOR_ONE;
		enum VK_BLEND_FACTOR_SRC_COLOR = VkBlendFactor.VK_BLEND_FACTOR_SRC_COLOR;
		enum VK_BLEND_FACTOR_ONE_MINUS_SRC_COLOR = VkBlendFactor.VK_BLEND_FACTOR_ONE_MINUS_SRC_COLOR;
		enum VK_BLEND_FACTOR_DST_COLOR = VkBlendFactor.VK_BLEND_FACTOR_DST_COLOR;
		enum VK_BLEND_FACTOR_ONE_MINUS_DST_COLOR = VkBlendFactor.VK_BLEND_FACTOR_ONE_MINUS_DST_COLOR;
		enum VK_BLEND_FACTOR_SRC_ALPHA = VkBlendFactor.VK_BLEND_FACTOR_SRC_ALPHA;
		enum VK_BLEND_FACTOR_ONE_MINUS_SRC_ALPHA = VkBlendFactor.VK_BLEND_FACTOR_ONE_MINUS_SRC_ALPHA;
		enum VK_BLEND_FACTOR_DST_ALPHA = VkBlendFactor.VK_BLEND_FACTOR_DST_ALPHA;
		enum VK_BLEND_FACTOR_ONE_MINUS_DST_ALPHA = VkBlendFactor.VK_BLEND_FACTOR_ONE_MINUS_DST_ALPHA;
		enum VK_BLEND_FACTOR_CONSTANT_COLOR = VkBlendFactor.VK_BLEND_FACTOR_CONSTANT_COLOR;
		enum VK_BLEND_FACTOR_ONE_MINUS_CONSTANT_COLOR = VkBlendFactor.VK_BLEND_FACTOR_ONE_MINUS_CONSTANT_COLOR;
		enum VK_BLEND_FACTOR_CONSTANT_ALPHA = VkBlendFactor.VK_BLEND_FACTOR_CONSTANT_ALPHA;
		enum VK_BLEND_FACTOR_ONE_MINUS_CONSTANT_ALPHA = VkBlendFactor.VK_BLEND_FACTOR_ONE_MINUS_CONSTANT_ALPHA;
		enum VK_BLEND_FACTOR_SRC_ALPHA_SATURATE = VkBlendFactor.VK_BLEND_FACTOR_SRC_ALPHA_SATURATE;
		enum VK_BLEND_FACTOR_SRC1_COLOR = VkBlendFactor.VK_BLEND_FACTOR_SRC1_COLOR;
		enum VK_BLEND_FACTOR_ONE_MINUS_SRC1_COLOR = VkBlendFactor.VK_BLEND_FACTOR_ONE_MINUS_SRC1_COLOR;
		enum VK_BLEND_FACTOR_SRC1_ALPHA = VkBlendFactor.VK_BLEND_FACTOR_SRC1_ALPHA;
		enum VK_BLEND_FACTOR_ONE_MINUS_SRC1_ALPHA = VkBlendFactor.VK_BLEND_FACTOR_ONE_MINUS_SRC1_ALPHA;
		enum VK_BLEND_OP_ADD = VkBlendOp.VK_BLEND_OP_ADD;
		enum VK_BLEND_OP_SUBTRACT = VkBlendOp.VK_BLEND_OP_SUBTRACT;
		enum VK_BLEND_OP_REVERSE_SUBTRACT = VkBlendOp.VK_BLEND_OP_REVERSE_SUBTRACT;
		enum VK_BLEND_OP_MIN = VkBlendOp.VK_BLEND_OP_MIN;
		enum VK_BLEND_OP_MAX = VkBlendOp.VK_BLEND_OP_MAX;
		enum VK_COLOR_COMPONENT_R_BIT = VkColorComponentFlagBits.VK_COLOR_COMPONENT_R_BIT;
		enum VK_COLOR_COMPONENT_G_BIT = VkColorComponentFlagBits.VK_COLOR_COMPONENT_G_BIT;
		enum VK_COLOR_COMPONENT_B_BIT = VkColorComponentFlagBits.VK_COLOR_COMPONENT_B_BIT;
		enum VK_COLOR_COMPONENT_A_BIT = VkColorComponentFlagBits.VK_COLOR_COMPONENT_A_BIT;
		enum VK_DYNAMIC_STATE_VIEWPORT = VkDynamicState.VK_DYNAMIC_STATE_VIEWPORT;
		enum VK_DYNAMIC_STATE_SCISSOR = VkDynamicState.VK_DYNAMIC_STATE_SCISSOR;
		enum VK_DYNAMIC_STATE_LINE_WIDTH = VkDynamicState.VK_DYNAMIC_STATE_LINE_WIDTH;
		enum VK_DYNAMIC_STATE_DEPTH_BIAS = VkDynamicState.VK_DYNAMIC_STATE_DEPTH_BIAS;
		enum VK_DYNAMIC_STATE_BLEND_CONSTANTS = VkDynamicState.VK_DYNAMIC_STATE_BLEND_CONSTANTS;
		enum VK_DYNAMIC_STATE_DEPTH_BOUNDS = VkDynamicState.VK_DYNAMIC_STATE_DEPTH_BOUNDS;
		enum VK_DYNAMIC_STATE_STENCIL_COMPARE_MASK = VkDynamicState.VK_DYNAMIC_STATE_STENCIL_COMPARE_MASK;
		enum VK_DYNAMIC_STATE_STENCIL_WRITE_MASK = VkDynamicState.VK_DYNAMIC_STATE_STENCIL_WRITE_MASK;
		enum VK_DYNAMIC_STATE_STENCIL_REFERENCE = VkDynamicState.VK_DYNAMIC_STATE_STENCIL_REFERENCE;
		enum VK_FILTER_NEAREST = VkFilter.VK_FILTER_NEAREST;
		enum VK_FILTER_LINEAR = VkFilter.VK_FILTER_LINEAR;
		enum VK_FILTER_CUBIC_IMG = VkFilter.VK_FILTER_CUBIC_IMG;
		enum VK_SAMPLER_MIPMAP_MODE_NEAREST = VkSamplerMipmapMode.VK_SAMPLER_MIPMAP_MODE_NEAREST;
		enum VK_SAMPLER_MIPMAP_MODE_LINEAR = VkSamplerMipmapMode.VK_SAMPLER_MIPMAP_MODE_LINEAR;
		enum VK_SAMPLER_ADDRESS_MODE_REPEAT = VkSamplerAddressMode.VK_SAMPLER_ADDRESS_MODE_REPEAT;
		enum VK_SAMPLER_ADDRESS_MODE_MIRRORED_REPEAT = VkSamplerAddressMode.VK_SAMPLER_ADDRESS_MODE_MIRRORED_REPEAT;
		enum VK_SAMPLER_ADDRESS_MODE_CLAMP_TO_EDGE = VkSamplerAddressMode.VK_SAMPLER_ADDRESS_MODE_CLAMP_TO_EDGE;
		enum VK_SAMPLER_ADDRESS_MODE_CLAMP_TO_BORDER = VkSamplerAddressMode.VK_SAMPLER_ADDRESS_MODE_CLAMP_TO_BORDER;
		enum VK_SAMPLER_ADDRESS_MODE_MIRROR_CLAMP_TO_EDGE = VkSamplerAddressMode.VK_SAMPLER_ADDRESS_MODE_MIRROR_CLAMP_TO_EDGE;
		enum VK_BORDER_COLOR_FLOAT_TRANSPARENT_BLACK = VkBorderColor.VK_BORDER_COLOR_FLOAT_TRANSPARENT_BLACK;
		enum VK_BORDER_COLOR_INT_TRANSPARENT_BLACK = VkBorderColor.VK_BORDER_COLOR_INT_TRANSPARENT_BLACK;
		enum VK_BORDER_COLOR_FLOAT_OPAQUE_BLACK = VkBorderColor.VK_BORDER_COLOR_FLOAT_OPAQUE_BLACK;
		enum VK_BORDER_COLOR_INT_OPAQUE_BLACK = VkBorderColor.VK_BORDER_COLOR_INT_OPAQUE_BLACK;
		enum VK_BORDER_COLOR_FLOAT_OPAQUE_WHITE = VkBorderColor.VK_BORDER_COLOR_FLOAT_OPAQUE_WHITE;
		enum VK_BORDER_COLOR_INT_OPAQUE_WHITE = VkBorderColor.VK_BORDER_COLOR_INT_OPAQUE_WHITE;
		enum VK_DESCRIPTOR_TYPE_SAMPLER = VkDescriptorType.VK_DESCRIPTOR_TYPE_SAMPLER;
		enum VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER = VkDescriptorType.VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER;
		enum VK_DESCRIPTOR_TYPE_SAMPLED_IMAGE = VkDescriptorType.VK_DESCRIPTOR_TYPE_SAMPLED_IMAGE;
		enum VK_DESCRIPTOR_TYPE_STORAGE_IMAGE = VkDescriptorType.VK_DESCRIPTOR_TYPE_STORAGE_IMAGE;
		enum VK_DESCRIPTOR_TYPE_UNIFORM_TEXEL_BUFFER = VkDescriptorType.VK_DESCRIPTOR_TYPE_UNIFORM_TEXEL_BUFFER;
		enum VK_DESCRIPTOR_TYPE_STORAGE_TEXEL_BUFFER = VkDescriptorType.VK_DESCRIPTOR_TYPE_STORAGE_TEXEL_BUFFER;
		enum VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER = VkDescriptorType.VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER;
		enum VK_DESCRIPTOR_TYPE_STORAGE_BUFFER = VkDescriptorType.VK_DESCRIPTOR_TYPE_STORAGE_BUFFER;
		enum VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER_DYNAMIC = VkDescriptorType.VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER_DYNAMIC;
		enum VK_DESCRIPTOR_TYPE_STORAGE_BUFFER_DYNAMIC = VkDescriptorType.VK_DESCRIPTOR_TYPE_STORAGE_BUFFER_DYNAMIC;
		enum VK_DESCRIPTOR_TYPE_INPUT_ATTACHMENT = VkDescriptorType.VK_DESCRIPTOR_TYPE_INPUT_ATTACHMENT;
		enum VK_DESCRIPTOR_POOL_CREATE_FREE_DESCRIPTOR_SET_BIT = VkDescriptorPoolCreateFlagBits.VK_DESCRIPTOR_POOL_CREATE_FREE_DESCRIPTOR_SET_BIT;
		enum VK_ATTACHMENT_DESCRIPTION_MAY_ALIAS_BIT = VkAttachmentDescriptionFlagBits.VK_ATTACHMENT_DESCRIPTION_MAY_ALIAS_BIT;
		enum VK_ATTACHMENT_LOAD_OP_LOAD = VkAttachmentLoadOp.VK_ATTACHMENT_LOAD_OP_LOAD;
		enum VK_ATTACHMENT_LOAD_OP_CLEAR = VkAttachmentLoadOp.VK_ATTACHMENT_LOAD_OP_CLEAR;
		enum VK_ATTACHMENT_LOAD_OP_DONT_CARE = VkAttachmentLoadOp.VK_ATTACHMENT_LOAD_OP_DONT_CARE;
		enum VK_ATTACHMENT_STORE_OP_STORE = VkAttachmentStoreOp.VK_ATTACHMENT_STORE_OP_STORE;
		enum VK_ATTACHMENT_STORE_OP_DONT_CARE = VkAttachmentStoreOp.VK_ATTACHMENT_STORE_OP_DONT_CARE;
		enum VK_PIPELINE_BIND_POINT_GRAPHICS = VkPipelineBindPoint.VK_PIPELINE_BIND_POINT_GRAPHICS;
		enum VK_PIPELINE_BIND_POINT_COMPUTE = VkPipelineBindPoint.VK_PIPELINE_BIND_POINT_COMPUTE;
		enum VK_ACCESS_INDIRECT_COMMAND_READ_BIT = VkAccessFlagBits.VK_ACCESS_INDIRECT_COMMAND_READ_BIT;
		enum VK_ACCESS_INDEX_READ_BIT = VkAccessFlagBits.VK_ACCESS_INDEX_READ_BIT;
		enum VK_ACCESS_VERTEX_ATTRIBUTE_READ_BIT = VkAccessFlagBits.VK_ACCESS_VERTEX_ATTRIBUTE_READ_BIT;
		enum VK_ACCESS_UNIFORM_READ_BIT = VkAccessFlagBits.VK_ACCESS_UNIFORM_READ_BIT;
		enum VK_ACCESS_INPUT_ATTACHMENT_READ_BIT = VkAccessFlagBits.VK_ACCESS_INPUT_ATTACHMENT_READ_BIT;
		enum VK_ACCESS_SHADER_READ_BIT = VkAccessFlagBits.VK_ACCESS_SHADER_READ_BIT;
		enum VK_ACCESS_SHADER_WRITE_BIT = VkAccessFlagBits.VK_ACCESS_SHADER_WRITE_BIT;
		enum VK_ACCESS_COLOR_ATTACHMENT_READ_BIT = VkAccessFlagBits.VK_ACCESS_COLOR_ATTACHMENT_READ_BIT;
		enum VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT = VkAccessFlagBits.VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT;
		enum VK_ACCESS_DEPTH_STENCIL_ATTACHMENT_READ_BIT = VkAccessFlagBits.VK_ACCESS_DEPTH_STENCIL_ATTACHMENT_READ_BIT;
		enum VK_ACCESS_DEPTH_STENCIL_ATTACHMENT_WRITE_BIT = VkAccessFlagBits.VK_ACCESS_DEPTH_STENCIL_ATTACHMENT_WRITE_BIT;
		enum VK_ACCESS_TRANSFER_READ_BIT = VkAccessFlagBits.VK_ACCESS_TRANSFER_READ_BIT;
		enum VK_ACCESS_TRANSFER_WRITE_BIT = VkAccessFlagBits.VK_ACCESS_TRANSFER_WRITE_BIT;
		enum VK_ACCESS_HOST_READ_BIT = VkAccessFlagBits.VK_ACCESS_HOST_READ_BIT;
		enum VK_ACCESS_HOST_WRITE_BIT = VkAccessFlagBits.VK_ACCESS_HOST_WRITE_BIT;
		enum VK_ACCESS_MEMORY_READ_BIT = VkAccessFlagBits.VK_ACCESS_MEMORY_READ_BIT;
		enum VK_ACCESS_MEMORY_WRITE_BIT = VkAccessFlagBits.VK_ACCESS_MEMORY_WRITE_BIT;
		enum VK_DEPENDENCY_BY_REGION_BIT = VkDependencyFlagBits.VK_DEPENDENCY_BY_REGION_BIT;
		enum VK_COMMAND_POOL_CREATE_TRANSIENT_BIT = VkCommandPoolCreateFlagBits.VK_COMMAND_POOL_CREATE_TRANSIENT_BIT;
		enum VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT = VkCommandPoolCreateFlagBits.VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT;
		enum VK_COMMAND_POOL_RESET_RELEASE_RESOURCES_BIT = VkCommandPoolResetFlagBits.VK_COMMAND_POOL_RESET_RELEASE_RESOURCES_BIT;
		enum VK_COMMAND_BUFFER_LEVEL_PRIMARY = VkCommandBufferLevel.VK_COMMAND_BUFFER_LEVEL_PRIMARY;
		enum VK_COMMAND_BUFFER_LEVEL_SECONDARY = VkCommandBufferLevel.VK_COMMAND_BUFFER_LEVEL_SECONDARY;
		enum VK_COMMAND_BUFFER_USAGE_ONE_TIME_SUBMIT_BIT = VkCommandBufferUsageFlagBits.VK_COMMAND_BUFFER_USAGE_ONE_TIME_SUBMIT_BIT;
		enum VK_COMMAND_BUFFER_USAGE_RENDER_PASS_CONTINUE_BIT = VkCommandBufferUsageFlagBits.VK_COMMAND_BUFFER_USAGE_RENDER_PASS_CONTINUE_BIT;
		enum VK_COMMAND_BUFFER_USAGE_SIMULTANEOUS_USE_BIT = VkCommandBufferUsageFlagBits.VK_COMMAND_BUFFER_USAGE_SIMULTANEOUS_USE_BIT;
		enum VK_QUERY_CONTROL_PRECISE_BIT = VkQueryControlFlagBits.VK_QUERY_CONTROL_PRECISE_BIT;
		enum VK_COMMAND_BUFFER_RESET_RELEASE_RESOURCES_BIT = VkCommandBufferResetFlagBits.VK_COMMAND_BUFFER_RESET_RELEASE_RESOURCES_BIT;
		enum VK_STENCIL_FACE_FRONT_BIT = VkStencilFaceFlagBits.VK_STENCIL_FACE_FRONT_BIT;
		enum VK_STENCIL_FACE_BACK_BIT = VkStencilFaceFlagBits.VK_STENCIL_FACE_BACK_BIT;
		enum VK_STENCIL_FRONT_AND_BACK = VkStencilFaceFlagBits.VK_STENCIL_FRONT_AND_BACK;
		enum VK_INDEX_TYPE_UINT16 = VkIndexType.VK_INDEX_TYPE_UINT16;
		enum VK_INDEX_TYPE_UINT32 = VkIndexType.VK_INDEX_TYPE_UINT32;
		enum VK_SUBPASS_CONTENTS_INLINE = VkSubpassContents.VK_SUBPASS_CONTENTS_INLINE;
		enum VK_SUBPASS_CONTENTS_SECONDARY_COMMAND_BUFFERS = VkSubpassContents.VK_SUBPASS_CONTENTS_SECONDARY_COMMAND_BUFFERS;
	}
	version(DVulkan_VK_KHR_surface) {
		enum VK_SURFACE_TRANSFORM_IDENTITY_BIT_KHR = VkSurfaceTransformFlagBitsKHR.VK_SURFACE_TRANSFORM_IDENTITY_BIT_KHR;
		enum VK_SURFACE_TRANSFORM_ROTATE_90_BIT_KHR = VkSurfaceTransformFlagBitsKHR.VK_SURFACE_TRANSFORM_ROTATE_90_BIT_KHR;
		enum VK_SURFACE_TRANSFORM_ROTATE_180_BIT_KHR = VkSurfaceTransformFlagBitsKHR.VK_SURFACE_TRANSFORM_ROTATE_180_BIT_KHR;
		enum VK_SURFACE_TRANSFORM_ROTATE_270_BIT_KHR = VkSurfaceTransformFlagBitsKHR.VK_SURFACE_TRANSFORM_ROTATE_270_BIT_KHR;
		enum VK_SURFACE_TRANSFORM_HORIZONTAL_MIRROR_BIT_KHR = VkSurfaceTransformFlagBitsKHR.VK_SURFACE_TRANSFORM_HORIZONTAL_MIRROR_BIT_KHR;
		enum VK_SURFACE_TRANSFORM_HORIZONTAL_MIRROR_ROTATE_90_BIT_KHR = VkSurfaceTransformFlagBitsKHR.VK_SURFACE_TRANSFORM_HORIZONTAL_MIRROR_ROTATE_90_BIT_KHR;
		enum VK_SURFACE_TRANSFORM_HORIZONTAL_MIRROR_ROTATE_180_BIT_KHR = VkSurfaceTransformFlagBitsKHR.VK_SURFACE_TRANSFORM_HORIZONTAL_MIRROR_ROTATE_180_BIT_KHR;
		enum VK_SURFACE_TRANSFORM_HORIZONTAL_MIRROR_ROTATE_270_BIT_KHR = VkSurfaceTransformFlagBitsKHR.VK_SURFACE_TRANSFORM_HORIZONTAL_MIRROR_ROTATE_270_BIT_KHR;
		enum VK_SURFACE_TRANSFORM_INHERIT_BIT_KHR = VkSurfaceTransformFlagBitsKHR.VK_SURFACE_TRANSFORM_INHERIT_BIT_KHR;
		enum VK_COMPOSITE_ALPHA_OPAQUE_BIT_KHR = VkCompositeAlphaFlagBitsKHR.VK_COMPOSITE_ALPHA_OPAQUE_BIT_KHR;
		enum VK_COMPOSITE_ALPHA_PRE_MULTIPLIED_BIT_KHR = VkCompositeAlphaFlagBitsKHR.VK_COMPOSITE_ALPHA_PRE_MULTIPLIED_BIT_KHR;
		enum VK_COMPOSITE_ALPHA_POST_MULTIPLIED_BIT_KHR = VkCompositeAlphaFlagBitsKHR.VK_COMPOSITE_ALPHA_POST_MULTIPLIED_BIT_KHR;
		enum VK_COMPOSITE_ALPHA_INHERIT_BIT_KHR = VkCompositeAlphaFlagBitsKHR.VK_COMPOSITE_ALPHA_INHERIT_BIT_KHR;
		enum VK_COLOR_SPACE_SRGB_NONLINEAR_KHR = VkColorSpaceKHR.VK_COLOR_SPACE_SRGB_NONLINEAR_KHR;
		enum VK_COLORSPACE_SRGB_NONLINEAR_KHR = VkColorSpaceKHR.VK_COLORSPACE_SRGB_NONLINEAR_KHR;
		enum VK_PRESENT_MODE_IMMEDIATE_KHR = VkPresentModeKHR.VK_PRESENT_MODE_IMMEDIATE_KHR;
		enum VK_PRESENT_MODE_MAILBOX_KHR = VkPresentModeKHR.VK_PRESENT_MODE_MAILBOX_KHR;
		enum VK_PRESENT_MODE_FIFO_KHR = VkPresentModeKHR.VK_PRESENT_MODE_FIFO_KHR;
		enum VK_PRESENT_MODE_FIFO_RELAXED_KHR = VkPresentModeKHR.VK_PRESENT_MODE_FIFO_RELAXED_KHR;
	}
	version(DVulkan_VK_KHR_swapchain) {
	}
	version(DVulkan_VK_KHR_display) {
		enum VK_DISPLAY_PLANE_ALPHA_OPAQUE_BIT_KHR = VkDisplayPlaneAlphaFlagBitsKHR.VK_DISPLAY_PLANE_ALPHA_OPAQUE_BIT_KHR;
		enum VK_DISPLAY_PLANE_ALPHA_GLOBAL_BIT_KHR = VkDisplayPlaneAlphaFlagBitsKHR.VK_DISPLAY_PLANE_ALPHA_GLOBAL_BIT_KHR;
		enum VK_DISPLAY_PLANE_ALPHA_PER_PIXEL_BIT_KHR = VkDisplayPlaneAlphaFlagBitsKHR.VK_DISPLAY_PLANE_ALPHA_PER_PIXEL_BIT_KHR;
		enum VK_DISPLAY_PLANE_ALPHA_PER_PIXEL_PREMULTIPLIED_BIT_KHR = VkDisplayPlaneAlphaFlagBitsKHR.VK_DISPLAY_PLANE_ALPHA_PER_PIXEL_PREMULTIPLIED_BIT_KHR;
	}
	version(DVulkan_VK_KHR_display_swapchain) {
	}
	version(DVulkan_VK_KHR_sampler_mirror_clamp_to_edge) {
	}
	version(DVulkan_VK_ANDROID_native_buffer) {
	}
	version(DVulkan_VK_EXT_debug_report) {
		enum VK_DEBUG_REPORT_OBJECT_TYPE_UNKNOWN_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_UNKNOWN_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_INSTANCE_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_INSTANCE_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_PHYSICAL_DEVICE_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_PHYSICAL_DEVICE_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_DEVICE_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_DEVICE_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_QUEUE_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_QUEUE_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_SEMAPHORE_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_SEMAPHORE_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_COMMAND_BUFFER_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_COMMAND_BUFFER_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_FENCE_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_FENCE_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_DEVICE_MEMORY_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_DEVICE_MEMORY_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_BUFFER_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_BUFFER_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_IMAGE_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_IMAGE_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_EVENT_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_EVENT_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_QUERY_POOL_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_QUERY_POOL_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_BUFFER_VIEW_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_BUFFER_VIEW_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_IMAGE_VIEW_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_IMAGE_VIEW_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_SHADER_MODULE_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_SHADER_MODULE_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_PIPELINE_CACHE_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_PIPELINE_CACHE_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_PIPELINE_LAYOUT_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_PIPELINE_LAYOUT_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_RENDER_PASS_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_RENDER_PASS_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_PIPELINE_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_PIPELINE_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_DESCRIPTOR_SET_LAYOUT_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_DESCRIPTOR_SET_LAYOUT_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_SAMPLER_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_SAMPLER_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_DESCRIPTOR_POOL_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_DESCRIPTOR_POOL_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_DESCRIPTOR_SET_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_DESCRIPTOR_SET_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_FRAMEBUFFER_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_FRAMEBUFFER_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_COMMAND_POOL_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_COMMAND_POOL_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_SURFACE_KHR_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_SURFACE_KHR_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_SWAPCHAIN_KHR_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_SWAPCHAIN_KHR_EXT;
		enum VK_DEBUG_REPORT_OBJECT_TYPE_DEBUG_REPORT_EXT = VkDebugReportObjectTypeEXT.VK_DEBUG_REPORT_OBJECT_TYPE_DEBUG_REPORT_EXT;
		enum VK_DEBUG_REPORT_ERROR_NONE_EXT = VkDebugReportErrorEXT.VK_DEBUG_REPORT_ERROR_NONE_EXT;
		enum VK_DEBUG_REPORT_ERROR_CALLBACK_REF_EXT = VkDebugReportErrorEXT.VK_DEBUG_REPORT_ERROR_CALLBACK_REF_EXT;
		enum VK_DEBUG_REPORT_INFORMATION_BIT_EXT = VkDebugReportFlagBitsEXT.VK_DEBUG_REPORT_INFORMATION_BIT_EXT;
		enum VK_DEBUG_REPORT_WARNING_BIT_EXT = VkDebugReportFlagBitsEXT.VK_DEBUG_REPORT_WARNING_BIT_EXT;
		enum VK_DEBUG_REPORT_PERFORMANCE_WARNING_BIT_EXT = VkDebugReportFlagBitsEXT.VK_DEBUG_REPORT_PERFORMANCE_WARNING_BIT_EXT;
		enum VK_DEBUG_REPORT_ERROR_BIT_EXT = VkDebugReportFlagBitsEXT.VK_DEBUG_REPORT_ERROR_BIT_EXT;
		enum VK_DEBUG_REPORT_DEBUG_BIT_EXT = VkDebugReportFlagBitsEXT.VK_DEBUG_REPORT_DEBUG_BIT_EXT;
	}
	version(DVulkan_VK_NV_glsl_shader) {
	}
	version(DVulkan_VK_NV_extension_1) {
	}
	version(DVulkan_VK_IMG_filter_cubic) {
	}
	version(DVulkan_VK_AMD_extension_1) {
	}
	version(DVulkan_VK_AMD_extension_2) {
	}
	version(DVulkan_VK_AMD_rasterization_order) {
		enum VK_RASTERIZATION_ORDER_STRICT_AMD = VkRasterizationOrderAMD.VK_RASTERIZATION_ORDER_STRICT_AMD;
		enum VK_RASTERIZATION_ORDER_RELAXED_AMD = VkRasterizationOrderAMD.VK_RASTERIZATION_ORDER_RELAXED_AMD;
	}
	version(DVulkan_VK_AMD_extension_4) {
	}
	version(DVulkan_VK_AMD_extension_5) {
	}
	version(DVulkan_VK_AMD_extension_6) {
	}
	version(DVulkan_VK_EXT_debug_marker) {
	}
}
