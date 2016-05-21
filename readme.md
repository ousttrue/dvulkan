D-Vulkan
========

Automatically-generated D bindings for Vulkan.

Usage
-----

1. Import via `import dvulkan;`.
2. Get a pointer to the `vkGetInstanceProcAddr`, through platform-specific means (ex. loading the
   Vulkan shared library, or `glfwGetInstanceProcAddress` if using GLFW).
3. Call `DVulkanLoader.loadInstanceFunctions(getProcAddr)`, where `getProcAddr` is the address of
   the loaded `vkGetInstanceProcAddr` function, to load the following functions:
	* `vkGetInstanceProcAddr` (sets the global variable from the passed value)
	* `vkCreateInstance`
	* `vkEnumerateInstanceExtensionProperties`
	* `vkEnumerateInstanceLayerProperties`
4. Create a `VkInstance` using the above functions.
5. Call `DVulkanLoader.loadAllFunctions(instance)` to load the rest of the functions.
6. (Optional) Call `DVulkanLoader.loadAllFunctions(device)` once you have a `VkDevice` to load
   specific functions for a device.

Differences from C Vulkan
-------------------------

* `VK_NULL_HANDLE` **will not work.** The C Vulkan headers rely on the fact that 0 in C is implicitly
  convertible to the null pointer, but that is not the case in D. Instead, use the
  `VK_NULL_[NON_]DISPATCHABLE_HANDLE` constants (as approprate for the type) or `VkType.init`
  (where `Type` is the type to get a null handle for).
* Since enums in D are not global, you need to specify the enum type. Ex: `VkResult.VK_SUCCESS`
  instead of just `VK_SUCCESS`.
  
  The `DVulkanGlobalEnums` version defines global aliases to enums, making them work like C enums.
  Define `DVulkanGlobalEnums` version in your projects dub config.
* All structures have their `sType` field set to the appropriate value upon initialization; explicit
  initialization is not needed.
* `VkPipelineShaderStageCreateInfo.module` has been renamed to
  `VkPipelineShaderStageCreateInfo._module`, since `module` is a D keyword.

Examples can be found in the `examples` directory, and ran with `dub run d-vulkan:examplename`.

Bindings for all extensions are available, except for the `VK_KHR_*_surface` extensions, which
require types from external libraries (X11, XCB, ...). They can be manually loaded with
`vkGetInstanceProcAddr` if needed.

Derelict Loader
---------------

d-vulkan includes a minimal loader using derelict to load the Vulkan shared library. To use it, use
the `with-derelict-loader` configuration, and call `DVulkanDerelict.load()`. This will load the
library and also call `loadInstanceFunctions` for you.

Whitelisted Extension Loading
-----------------------------

In the default configuration, d-vulkan will load all know extensions when `loadAllFunctions` is
called. You can instead specify the extensions you use manually.

Use the `custom-extensions` configuration, then add a version for the Vulkan version you use and any
extension names that you use, prefixed with `DVulkan_`. For example:
`"versions": ["DVulkan_VK_VERSION_1_0", "DVulkan_VK_KHR_surface", "DVulkan_VK_KHR_swapchain"]`

Examples
--------

Two examples can be found in the `examples` directory, and can be ran with
`dub run d-vulkan:examplename`.

devices: Lists devices. Uses the derelict loader.

layers: Lists available layers. Uses the derelict loader, global enums, and whitelisted extension
loading.

Generating Bindings
-------------------

To generate bindings, download the [Vulkan-Docs](https://github.com/KhronosGroup/Vulkan-Docs) repo,
copy/move/symlink `vkdgen.py` into `src/spec/`, `cd` there, and execute it, passing in an output
folder to place the D files. Requires Python 3.
