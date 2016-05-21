
module dvulkan.functions;

import dvulkan.types;
import std.typetuple;
import std.traits : Parameters;
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
extern(System) @nogc nothrow {
	version(DVulkan_VK_VERSION_1_0) {
		alias PFN_vkCreateInstance = VkResult function(const(VkInstanceCreateInfo)* pCreateInfo,const(VkAllocationCallbacks)* pAllocator,VkInstance* pInstance);
		alias PFN_vkDestroyInstance = void function(VkInstance instance,const(VkAllocationCallbacks)* pAllocator);
		alias PFN_vkEnumeratePhysicalDevices = VkResult function(VkInstance instance,uint32_t* pPhysicalDeviceCount,VkPhysicalDevice* pPhysicalDevices);
		alias PFN_vkGetPhysicalDeviceFeatures = void function(VkPhysicalDevice physicalDevice,VkPhysicalDeviceFeatures* pFeatures);
		alias PFN_vkGetPhysicalDeviceFormatProperties = void function(VkPhysicalDevice physicalDevice,VkFormat format,VkFormatProperties* pFormatProperties);
		alias PFN_vkGetPhysicalDeviceImageFormatProperties = VkResult function(VkPhysicalDevice physicalDevice,VkFormat format,VkImageType type,VkImageTiling tiling,VkImageUsageFlags usage,VkImageCreateFlags flags,VkImageFormatProperties* pImageFormatProperties);
		alias PFN_vkGetPhysicalDeviceProperties = void function(VkPhysicalDevice physicalDevice,VkPhysicalDeviceProperties* pProperties);
		alias PFN_vkGetPhysicalDeviceQueueFamilyProperties = void function(VkPhysicalDevice physicalDevice,uint32_t* pQueueFamilyPropertyCount,VkQueueFamilyProperties* pQueueFamilyProperties);
		alias PFN_vkGetPhysicalDeviceMemoryProperties = void function(VkPhysicalDevice physicalDevice,VkPhysicalDeviceMemoryProperties* pMemoryProperties);
		alias PFN_vkGetInstanceProcAddr = PFN_vkVoidFunction function(VkInstance instance,const(char)* pName);
		alias PFN_vkGetDeviceProcAddr = PFN_vkVoidFunction function(VkDevice device,const(char)* pName);
		alias PFN_vkCreateDevice = VkResult function(VkPhysicalDevice physicalDevice,const(VkDeviceCreateInfo)* pCreateInfo,const(VkAllocationCallbacks)* pAllocator,VkDevice* pDevice);
		alias PFN_vkDestroyDevice = void function(VkDevice device,const(VkAllocationCallbacks)* pAllocator);
		alias PFN_vkEnumerateInstanceExtensionProperties = VkResult function(const(char)* pLayerName,uint32_t* pPropertyCount,VkExtensionProperties* pProperties);
		alias PFN_vkEnumerateDeviceExtensionProperties = VkResult function(VkPhysicalDevice physicalDevice,const(char)* pLayerName,uint32_t* pPropertyCount,VkExtensionProperties* pProperties);
		alias PFN_vkEnumerateInstanceLayerProperties = VkResult function(uint32_t* pPropertyCount,VkLayerProperties* pProperties);
		alias PFN_vkEnumerateDeviceLayerProperties = VkResult function(VkPhysicalDevice physicalDevice,uint32_t* pPropertyCount,VkLayerProperties* pProperties);
		alias PFN_vkGetDeviceQueue = void function(VkDevice device,uint32_t queueFamilyIndex,uint32_t queueIndex,VkQueue* pQueue);
		alias PFN_vkQueueSubmit = VkResult function(VkQueue queue,uint32_t submitCount,const(VkSubmitInfo)* pSubmits,VkFence fence);
		alias PFN_vkQueueWaitIdle = VkResult function(VkQueue queue);
		alias PFN_vkDeviceWaitIdle = VkResult function(VkDevice device);
		alias PFN_vkAllocateMemory = VkResult function(VkDevice device,const(VkMemoryAllocateInfo)* pAllocateInfo,const(VkAllocationCallbacks)* pAllocator,VkDeviceMemory* pMemory);
		alias PFN_vkFreeMemory = void function(VkDevice device,VkDeviceMemory memory,const(VkAllocationCallbacks)* pAllocator);
		alias PFN_vkMapMemory = VkResult function(VkDevice device,VkDeviceMemory memory,VkDeviceSize offset,VkDeviceSize size,VkMemoryMapFlags flags,void** ppData);
		alias PFN_vkUnmapMemory = void function(VkDevice device,VkDeviceMemory memory);
		alias PFN_vkFlushMappedMemoryRanges = VkResult function(VkDevice device,uint32_t memoryRangeCount,const(VkMappedMemoryRange)* pMemoryRanges);
		alias PFN_vkInvalidateMappedMemoryRanges = VkResult function(VkDevice device,uint32_t memoryRangeCount,const(VkMappedMemoryRange)* pMemoryRanges);
		alias PFN_vkGetDeviceMemoryCommitment = void function(VkDevice device,VkDeviceMemory memory,VkDeviceSize* pCommittedMemoryInBytes);
		alias PFN_vkBindBufferMemory = VkResult function(VkDevice device,VkBuffer buffer,VkDeviceMemory memory,VkDeviceSize memoryOffset);
		alias PFN_vkBindImageMemory = VkResult function(VkDevice device,VkImage image,VkDeviceMemory memory,VkDeviceSize memoryOffset);
		alias PFN_vkGetBufferMemoryRequirements = void function(VkDevice device,VkBuffer buffer,VkMemoryRequirements* pMemoryRequirements);
		alias PFN_vkGetImageMemoryRequirements = void function(VkDevice device,VkImage image,VkMemoryRequirements* pMemoryRequirements);
		alias PFN_vkGetImageSparseMemoryRequirements = void function(VkDevice device,VkImage image,uint32_t* pSparseMemoryRequirementCount,VkSparseImageMemoryRequirements* pSparseMemoryRequirements);
		alias PFN_vkGetPhysicalDeviceSparseImageFormatProperties = void function(VkPhysicalDevice physicalDevice,VkFormat format,VkImageType type,VkSampleCountFlagBits samples,VkImageUsageFlags usage,VkImageTiling tiling,uint32_t* pPropertyCount,VkSparseImageFormatProperties* pProperties);
		alias PFN_vkQueueBindSparse = VkResult function(VkQueue queue,uint32_t bindInfoCount,const(VkBindSparseInfo)* pBindInfo,VkFence fence);
		alias PFN_vkCreateFence = VkResult function(VkDevice device,const(VkFenceCreateInfo)* pCreateInfo,const(VkAllocationCallbacks)* pAllocator,VkFence* pFence);
		alias PFN_vkDestroyFence = void function(VkDevice device,VkFence fence,const(VkAllocationCallbacks)* pAllocator);
		alias PFN_vkResetFences = VkResult function(VkDevice device,uint32_t fenceCount,const(VkFence)* pFences);
		alias PFN_vkGetFenceStatus = VkResult function(VkDevice device,VkFence fence);
		alias PFN_vkWaitForFences = VkResult function(VkDevice device,uint32_t fenceCount,const(VkFence)* pFences,VkBool32 waitAll,uint64_t timeout);
		alias PFN_vkCreateSemaphore = VkResult function(VkDevice device,const(VkSemaphoreCreateInfo)* pCreateInfo,const(VkAllocationCallbacks)* pAllocator,VkSemaphore* pSemaphore);
		alias PFN_vkDestroySemaphore = void function(VkDevice device,VkSemaphore semaphore,const(VkAllocationCallbacks)* pAllocator);
		alias PFN_vkCreateEvent = VkResult function(VkDevice device,const(VkEventCreateInfo)* pCreateInfo,const(VkAllocationCallbacks)* pAllocator,VkEvent* pEvent);
		alias PFN_vkDestroyEvent = void function(VkDevice device,VkEvent event,const(VkAllocationCallbacks)* pAllocator);
		alias PFN_vkGetEventStatus = VkResult function(VkDevice device,VkEvent event);
		alias PFN_vkSetEvent = VkResult function(VkDevice device,VkEvent event);
		alias PFN_vkResetEvent = VkResult function(VkDevice device,VkEvent event);
		alias PFN_vkCreateQueryPool = VkResult function(VkDevice device,const(VkQueryPoolCreateInfo)* pCreateInfo,const(VkAllocationCallbacks)* pAllocator,VkQueryPool* pQueryPool);
		alias PFN_vkDestroyQueryPool = void function(VkDevice device,VkQueryPool queryPool,const(VkAllocationCallbacks)* pAllocator);
		alias PFN_vkGetQueryPoolResults = VkResult function(VkDevice device,VkQueryPool queryPool,uint32_t firstQuery,uint32_t queryCount,size_t dataSize,void* pData,VkDeviceSize stride,VkQueryResultFlags flags);
		alias PFN_vkCreateBuffer = VkResult function(VkDevice device,const(VkBufferCreateInfo)* pCreateInfo,const(VkAllocationCallbacks)* pAllocator,VkBuffer* pBuffer);
		alias PFN_vkDestroyBuffer = void function(VkDevice device,VkBuffer buffer,const(VkAllocationCallbacks)* pAllocator);
		alias PFN_vkCreateBufferView = VkResult function(VkDevice device,const(VkBufferViewCreateInfo)* pCreateInfo,const(VkAllocationCallbacks)* pAllocator,VkBufferView* pView);
		alias PFN_vkDestroyBufferView = void function(VkDevice device,VkBufferView bufferView,const(VkAllocationCallbacks)* pAllocator);
		alias PFN_vkCreateImage = VkResult function(VkDevice device,const(VkImageCreateInfo)* pCreateInfo,const(VkAllocationCallbacks)* pAllocator,VkImage* pImage);
		alias PFN_vkDestroyImage = void function(VkDevice device,VkImage image,const(VkAllocationCallbacks)* pAllocator);
		alias PFN_vkGetImageSubresourceLayout = void function(VkDevice device,VkImage image,const(VkImageSubresource)* pSubresource,VkSubresourceLayout* pLayout);
		alias PFN_vkCreateImageView = VkResult function(VkDevice device,const(VkImageViewCreateInfo)* pCreateInfo,const(VkAllocationCallbacks)* pAllocator,VkImageView* pView);
		alias PFN_vkDestroyImageView = void function(VkDevice device,VkImageView imageView,const(VkAllocationCallbacks)* pAllocator);
		alias PFN_vkCreateShaderModule = VkResult function(VkDevice device,const(VkShaderModuleCreateInfo)* pCreateInfo,const(VkAllocationCallbacks)* pAllocator,VkShaderModule* pShaderModule);
		alias PFN_vkDestroyShaderModule = void function(VkDevice device,VkShaderModule shaderModule,const(VkAllocationCallbacks)* pAllocator);
		alias PFN_vkCreatePipelineCache = VkResult function(VkDevice device,const(VkPipelineCacheCreateInfo)* pCreateInfo,const(VkAllocationCallbacks)* pAllocator,VkPipelineCache* pPipelineCache);
		alias PFN_vkDestroyPipelineCache = void function(VkDevice device,VkPipelineCache pipelineCache,const(VkAllocationCallbacks)* pAllocator);
		alias PFN_vkGetPipelineCacheData = VkResult function(VkDevice device,VkPipelineCache pipelineCache,size_t* pDataSize,void* pData);
		alias PFN_vkMergePipelineCaches = VkResult function(VkDevice device,VkPipelineCache dstCache,uint32_t srcCacheCount,const(VkPipelineCache)* pSrcCaches);
		alias PFN_vkCreateGraphicsPipelines = VkResult function(VkDevice device,VkPipelineCache pipelineCache,uint32_t createInfoCount,const(VkGraphicsPipelineCreateInfo)* pCreateInfos,const(VkAllocationCallbacks)* pAllocator,VkPipeline* pPipelines);
		alias PFN_vkCreateComputePipelines = VkResult function(VkDevice device,VkPipelineCache pipelineCache,uint32_t createInfoCount,const(VkComputePipelineCreateInfo)* pCreateInfos,const(VkAllocationCallbacks)* pAllocator,VkPipeline* pPipelines);
		alias PFN_vkDestroyPipeline = void function(VkDevice device,VkPipeline pipeline,const(VkAllocationCallbacks)* pAllocator);
		alias PFN_vkCreatePipelineLayout = VkResult function(VkDevice device,const(VkPipelineLayoutCreateInfo)* pCreateInfo,const(VkAllocationCallbacks)* pAllocator,VkPipelineLayout* pPipelineLayout);
		alias PFN_vkDestroyPipelineLayout = void function(VkDevice device,VkPipelineLayout pipelineLayout,const(VkAllocationCallbacks)* pAllocator);
		alias PFN_vkCreateSampler = VkResult function(VkDevice device,const(VkSamplerCreateInfo)* pCreateInfo,const(VkAllocationCallbacks)* pAllocator,VkSampler* pSampler);
		alias PFN_vkDestroySampler = void function(VkDevice device,VkSampler sampler,const(VkAllocationCallbacks)* pAllocator);
		alias PFN_vkCreateDescriptorSetLayout = VkResult function(VkDevice device,const(VkDescriptorSetLayoutCreateInfo)* pCreateInfo,const(VkAllocationCallbacks)* pAllocator,VkDescriptorSetLayout* pSetLayout);
		alias PFN_vkDestroyDescriptorSetLayout = void function(VkDevice device,VkDescriptorSetLayout descriptorSetLayout,const(VkAllocationCallbacks)* pAllocator);
		alias PFN_vkCreateDescriptorPool = VkResult function(VkDevice device,const(VkDescriptorPoolCreateInfo)* pCreateInfo,const(VkAllocationCallbacks)* pAllocator,VkDescriptorPool* pDescriptorPool);
		alias PFN_vkDestroyDescriptorPool = void function(VkDevice device,VkDescriptorPool descriptorPool,const(VkAllocationCallbacks)* pAllocator);
		alias PFN_vkResetDescriptorPool = VkResult function(VkDevice device,VkDescriptorPool descriptorPool,VkDescriptorPoolResetFlags flags);
		alias PFN_vkAllocateDescriptorSets = VkResult function(VkDevice device,const(VkDescriptorSetAllocateInfo)* pAllocateInfo,VkDescriptorSet* pDescriptorSets);
		alias PFN_vkFreeDescriptorSets = VkResult function(VkDevice device,VkDescriptorPool descriptorPool,uint32_t descriptorSetCount,const(VkDescriptorSet)* pDescriptorSets);
		alias PFN_vkUpdateDescriptorSets = void function(VkDevice device,uint32_t descriptorWriteCount,const(VkWriteDescriptorSet)* pDescriptorWrites,uint32_t descriptorCopyCount,const(VkCopyDescriptorSet)* pDescriptorCopies);
		alias PFN_vkCreateFramebuffer = VkResult function(VkDevice device,const(VkFramebufferCreateInfo)* pCreateInfo,const(VkAllocationCallbacks)* pAllocator,VkFramebuffer* pFramebuffer);
		alias PFN_vkDestroyFramebuffer = void function(VkDevice device,VkFramebuffer framebuffer,const(VkAllocationCallbacks)* pAllocator);
		alias PFN_vkCreateRenderPass = VkResult function(VkDevice device,const(VkRenderPassCreateInfo)* pCreateInfo,const(VkAllocationCallbacks)* pAllocator,VkRenderPass* pRenderPass);
		alias PFN_vkDestroyRenderPass = void function(VkDevice device,VkRenderPass renderPass,const(VkAllocationCallbacks)* pAllocator);
		alias PFN_vkGetRenderAreaGranularity = void function(VkDevice device,VkRenderPass renderPass,VkExtent2D* pGranularity);
		alias PFN_vkCreateCommandPool = VkResult function(VkDevice device,const(VkCommandPoolCreateInfo)* pCreateInfo,const(VkAllocationCallbacks)* pAllocator,VkCommandPool* pCommandPool);
		alias PFN_vkDestroyCommandPool = void function(VkDevice device,VkCommandPool commandPool,const(VkAllocationCallbacks)* pAllocator);
		alias PFN_vkResetCommandPool = VkResult function(VkDevice device,VkCommandPool commandPool,VkCommandPoolResetFlags flags);
		alias PFN_vkAllocateCommandBuffers = VkResult function(VkDevice device,const(VkCommandBufferAllocateInfo)* pAllocateInfo,VkCommandBuffer* pCommandBuffers);
		alias PFN_vkFreeCommandBuffers = void function(VkDevice device,VkCommandPool commandPool,uint32_t commandBufferCount,const(VkCommandBuffer)* pCommandBuffers);
		alias PFN_vkBeginCommandBuffer = VkResult function(VkCommandBuffer commandBuffer,const(VkCommandBufferBeginInfo)* pBeginInfo);
		alias PFN_vkEndCommandBuffer = VkResult function(VkCommandBuffer commandBuffer);
		alias PFN_vkResetCommandBuffer = VkResult function(VkCommandBuffer commandBuffer,VkCommandBufferResetFlags flags);
		alias PFN_vkCmdBindPipeline = void function(VkCommandBuffer commandBuffer,VkPipelineBindPoint pipelineBindPoint,VkPipeline pipeline);
		alias PFN_vkCmdSetViewport = void function(VkCommandBuffer commandBuffer,uint32_t firstViewport,uint32_t viewportCount,const(VkViewport)* pViewports);
		alias PFN_vkCmdSetScissor = void function(VkCommandBuffer commandBuffer,uint32_t firstScissor,uint32_t scissorCount,const(VkRect2D)* pScissors);
		alias PFN_vkCmdSetLineWidth = void function(VkCommandBuffer commandBuffer,float lineWidth);
		alias PFN_vkCmdSetDepthBias = void function(VkCommandBuffer commandBuffer,float depthBiasConstantFactor,float depthBiasClamp,float depthBiasSlopeFactor);
		alias PFN_vkCmdSetBlendConstants = void function(VkCommandBuffer commandBuffer,const float[4] blendConstants);
		alias PFN_vkCmdSetDepthBounds = void function(VkCommandBuffer commandBuffer,float minDepthBounds,float maxDepthBounds);
		alias PFN_vkCmdSetStencilCompareMask = void function(VkCommandBuffer commandBuffer,VkStencilFaceFlags faceMask,uint32_t compareMask);
		alias PFN_vkCmdSetStencilWriteMask = void function(VkCommandBuffer commandBuffer,VkStencilFaceFlags faceMask,uint32_t writeMask);
		alias PFN_vkCmdSetStencilReference = void function(VkCommandBuffer commandBuffer,VkStencilFaceFlags faceMask,uint32_t reference);
		alias PFN_vkCmdBindDescriptorSets = void function(VkCommandBuffer commandBuffer,VkPipelineBindPoint pipelineBindPoint,VkPipelineLayout layout,uint32_t firstSet,uint32_t descriptorSetCount,const(VkDescriptorSet)* pDescriptorSets,uint32_t dynamicOffsetCount,const(uint32_t)* pDynamicOffsets);
		alias PFN_vkCmdBindIndexBuffer = void function(VkCommandBuffer commandBuffer,VkBuffer buffer,VkDeviceSize offset,VkIndexType indexType);
		alias PFN_vkCmdBindVertexBuffers = void function(VkCommandBuffer commandBuffer,uint32_t firstBinding,uint32_t bindingCount,const(VkBuffer)* pBuffers,const(VkDeviceSize)* pOffsets);
		alias PFN_vkCmdDraw = void function(VkCommandBuffer commandBuffer,uint32_t vertexCount,uint32_t instanceCount,uint32_t firstVertex,uint32_t firstInstance);
		alias PFN_vkCmdDrawIndexed = void function(VkCommandBuffer commandBuffer,uint32_t indexCount,uint32_t instanceCount,uint32_t firstIndex,int32_t vertexOffset,uint32_t firstInstance);
		alias PFN_vkCmdDrawIndirect = void function(VkCommandBuffer commandBuffer,VkBuffer buffer,VkDeviceSize offset,uint32_t drawCount,uint32_t stride);
		alias PFN_vkCmdDrawIndexedIndirect = void function(VkCommandBuffer commandBuffer,VkBuffer buffer,VkDeviceSize offset,uint32_t drawCount,uint32_t stride);
		alias PFN_vkCmdDispatch = void function(VkCommandBuffer commandBuffer,uint32_t x,uint32_t y,uint32_t z);
		alias PFN_vkCmdDispatchIndirect = void function(VkCommandBuffer commandBuffer,VkBuffer buffer,VkDeviceSize offset);
		alias PFN_vkCmdCopyBuffer = void function(VkCommandBuffer commandBuffer,VkBuffer srcBuffer,VkBuffer dstBuffer,uint32_t regionCount,const(VkBufferCopy)* pRegions);
		alias PFN_vkCmdCopyImage = void function(VkCommandBuffer commandBuffer,VkImage srcImage,VkImageLayout srcImageLayout,VkImage dstImage,VkImageLayout dstImageLayout,uint32_t regionCount,const(VkImageCopy)* pRegions);
		alias PFN_vkCmdBlitImage = void function(VkCommandBuffer commandBuffer,VkImage srcImage,VkImageLayout srcImageLayout,VkImage dstImage,VkImageLayout dstImageLayout,uint32_t regionCount,const(VkImageBlit)* pRegions,VkFilter filter);
		alias PFN_vkCmdCopyBufferToImage = void function(VkCommandBuffer commandBuffer,VkBuffer srcBuffer,VkImage dstImage,VkImageLayout dstImageLayout,uint32_t regionCount,const(VkBufferImageCopy)* pRegions);
		alias PFN_vkCmdCopyImageToBuffer = void function(VkCommandBuffer commandBuffer,VkImage srcImage,VkImageLayout srcImageLayout,VkBuffer dstBuffer,uint32_t regionCount,const(VkBufferImageCopy)* pRegions);
		alias PFN_vkCmdUpdateBuffer = void function(VkCommandBuffer commandBuffer,VkBuffer dstBuffer,VkDeviceSize dstOffset,VkDeviceSize dataSize,const(uint32_t)* pData);
		alias PFN_vkCmdFillBuffer = void function(VkCommandBuffer commandBuffer,VkBuffer dstBuffer,VkDeviceSize dstOffset,VkDeviceSize size,uint32_t data);
		alias PFN_vkCmdClearColorImage = void function(VkCommandBuffer commandBuffer,VkImage image,VkImageLayout imageLayout,const(VkClearColorValue)* pColor,uint32_t rangeCount,const(VkImageSubresourceRange)* pRanges);
		alias PFN_vkCmdClearDepthStencilImage = void function(VkCommandBuffer commandBuffer,VkImage image,VkImageLayout imageLayout,const(VkClearDepthStencilValue)* pDepthStencil,uint32_t rangeCount,const(VkImageSubresourceRange)* pRanges);
		alias PFN_vkCmdClearAttachments = void function(VkCommandBuffer commandBuffer,uint32_t attachmentCount,const(VkClearAttachment)* pAttachments,uint32_t rectCount,const(VkClearRect)* pRects);
		alias PFN_vkCmdResolveImage = void function(VkCommandBuffer commandBuffer,VkImage srcImage,VkImageLayout srcImageLayout,VkImage dstImage,VkImageLayout dstImageLayout,uint32_t regionCount,const(VkImageResolve)* pRegions);
		alias PFN_vkCmdSetEvent = void function(VkCommandBuffer commandBuffer,VkEvent event,VkPipelineStageFlags stageMask);
		alias PFN_vkCmdResetEvent = void function(VkCommandBuffer commandBuffer,VkEvent event,VkPipelineStageFlags stageMask);
		alias PFN_vkCmdWaitEvents = void function(VkCommandBuffer commandBuffer,uint32_t eventCount,const(VkEvent)* pEvents,VkPipelineStageFlags srcStageMask,VkPipelineStageFlags dstStageMask,uint32_t memoryBarrierCount,const(VkMemoryBarrier)* pMemoryBarriers,uint32_t bufferMemoryBarrierCount,const(VkBufferMemoryBarrier)* pBufferMemoryBarriers,uint32_t imageMemoryBarrierCount,const(VkImageMemoryBarrier)* pImageMemoryBarriers);
		alias PFN_vkCmdPipelineBarrier = void function(VkCommandBuffer commandBuffer,VkPipelineStageFlags srcStageMask,VkPipelineStageFlags dstStageMask,VkDependencyFlags dependencyFlags,uint32_t memoryBarrierCount,const(VkMemoryBarrier)* pMemoryBarriers,uint32_t bufferMemoryBarrierCount,const(VkBufferMemoryBarrier)* pBufferMemoryBarriers,uint32_t imageMemoryBarrierCount,const(VkImageMemoryBarrier)* pImageMemoryBarriers);
		alias PFN_vkCmdBeginQuery = void function(VkCommandBuffer commandBuffer,VkQueryPool queryPool,uint32_t query,VkQueryControlFlags flags);
		alias PFN_vkCmdEndQuery = void function(VkCommandBuffer commandBuffer,VkQueryPool queryPool,uint32_t query);
		alias PFN_vkCmdResetQueryPool = void function(VkCommandBuffer commandBuffer,VkQueryPool queryPool,uint32_t firstQuery,uint32_t queryCount);
		alias PFN_vkCmdWriteTimestamp = void function(VkCommandBuffer commandBuffer,VkPipelineStageFlagBits pipelineStage,VkQueryPool queryPool,uint32_t query);
		alias PFN_vkCmdCopyQueryPoolResults = void function(VkCommandBuffer commandBuffer,VkQueryPool queryPool,uint32_t firstQuery,uint32_t queryCount,VkBuffer dstBuffer,VkDeviceSize dstOffset,VkDeviceSize stride,VkQueryResultFlags flags);
		alias PFN_vkCmdPushConstants = void function(VkCommandBuffer commandBuffer,VkPipelineLayout layout,VkShaderStageFlags stageFlags,uint32_t offset,uint32_t size,const(void)* pValues);
		alias PFN_vkCmdBeginRenderPass = void function(VkCommandBuffer commandBuffer,const(VkRenderPassBeginInfo)* pRenderPassBegin,VkSubpassContents contents);
		alias PFN_vkCmdNextSubpass = void function(VkCommandBuffer commandBuffer,VkSubpassContents contents);
		alias PFN_vkCmdEndRenderPass = void function(VkCommandBuffer commandBuffer);
		alias PFN_vkCmdExecuteCommands = void function(VkCommandBuffer commandBuffer,uint32_t commandBufferCount,const(VkCommandBuffer)* pCommandBuffers);
	}
	version(DVulkan_VK_KHR_surface) {
		alias PFN_vkDestroySurfaceKHR = void function(VkInstance instance,VkSurfaceKHR surface,const(VkAllocationCallbacks)* pAllocator);
		alias PFN_vkGetPhysicalDeviceSurfaceSupportKHR = VkResult function(VkPhysicalDevice physicalDevice,uint32_t queueFamilyIndex,VkSurfaceKHR surface,VkBool32* pSupported);
		alias PFN_vkGetPhysicalDeviceSurfaceCapabilitiesKHR = VkResult function(VkPhysicalDevice physicalDevice,VkSurfaceKHR surface,VkSurfaceCapabilitiesKHR* pSurfaceCapabilities);
		alias PFN_vkGetPhysicalDeviceSurfaceFormatsKHR = VkResult function(VkPhysicalDevice physicalDevice,VkSurfaceKHR surface,uint32_t* pSurfaceFormatCount,VkSurfaceFormatKHR* pSurfaceFormats);
		alias PFN_vkGetPhysicalDeviceSurfacePresentModesKHR = VkResult function(VkPhysicalDevice physicalDevice,VkSurfaceKHR surface,uint32_t* pPresentModeCount,VkPresentModeKHR* pPresentModes);
	}
	version(DVulkan_VK_KHR_swapchain) {
		alias PFN_vkCreateSwapchainKHR = VkResult function(VkDevice device,const(VkSwapchainCreateInfoKHR)* pCreateInfo,const(VkAllocationCallbacks)* pAllocator,VkSwapchainKHR* pSwapchain);
		alias PFN_vkDestroySwapchainKHR = void function(VkDevice device,VkSwapchainKHR swapchain,const(VkAllocationCallbacks)* pAllocator);
		alias PFN_vkGetSwapchainImagesKHR = VkResult function(VkDevice device,VkSwapchainKHR swapchain,uint32_t* pSwapchainImageCount,VkImage* pSwapchainImages);
		alias PFN_vkAcquireNextImageKHR = VkResult function(VkDevice device,VkSwapchainKHR swapchain,uint64_t timeout,VkSemaphore semaphore,VkFence fence,uint32_t* pImageIndex);
		alias PFN_vkQueuePresentKHR = VkResult function(VkQueue queue,const(VkPresentInfoKHR)* pPresentInfo);
	}
	version(DVulkan_VK_KHR_display) {
		alias PFN_vkGetPhysicalDeviceDisplayPropertiesKHR = VkResult function(VkPhysicalDevice physicalDevice,uint32_t* pPropertyCount,VkDisplayPropertiesKHR* pProperties);
		alias PFN_vkGetPhysicalDeviceDisplayPlanePropertiesKHR = VkResult function(VkPhysicalDevice physicalDevice,uint32_t* pPropertyCount,VkDisplayPlanePropertiesKHR* pProperties);
		alias PFN_vkGetDisplayPlaneSupportedDisplaysKHR = VkResult function(VkPhysicalDevice physicalDevice,uint32_t planeIndex,uint32_t* pDisplayCount,VkDisplayKHR* pDisplays);
		alias PFN_vkGetDisplayModePropertiesKHR = VkResult function(VkPhysicalDevice physicalDevice,VkDisplayKHR display,uint32_t* pPropertyCount,VkDisplayModePropertiesKHR* pProperties);
		alias PFN_vkCreateDisplayModeKHR = VkResult function(VkPhysicalDevice physicalDevice,VkDisplayKHR display,const(VkDisplayModeCreateInfoKHR)* pCreateInfo,const(VkAllocationCallbacks)* pAllocator,VkDisplayModeKHR* pMode);
		alias PFN_vkGetDisplayPlaneCapabilitiesKHR = VkResult function(VkPhysicalDevice physicalDevice,VkDisplayModeKHR mode,uint32_t planeIndex,VkDisplayPlaneCapabilitiesKHR* pCapabilities);
		alias PFN_vkCreateDisplayPlaneSurfaceKHR = VkResult function(VkInstance instance,const(VkDisplaySurfaceCreateInfoKHR)* pCreateInfo,const(VkAllocationCallbacks)* pAllocator,VkSurfaceKHR* pSurface);
	}
	version(DVulkan_VK_KHR_display_swapchain) {
		alias PFN_vkCreateSharedSwapchainsKHR = VkResult function(VkDevice device,uint32_t swapchainCount,const(VkSwapchainCreateInfoKHR)* pCreateInfos,const(VkAllocationCallbacks)* pAllocator,VkSwapchainKHR* pSwapchains);
	}
	version(DVulkan_VK_KHR_sampler_mirror_clamp_to_edge) {
	}
	version(DVulkan_VK_ANDROID_native_buffer) {
	}
	version(DVulkan_VK_EXT_debug_report) {
		alias PFN_vkCreateDebugReportCallbackEXT = VkResult function(VkInstance instance,const(VkDebugReportCallbackCreateInfoEXT)* pCreateInfo,const(VkAllocationCallbacks)* pAllocator,VkDebugReportCallbackEXT* pCallback);
		alias PFN_vkDestroyDebugReportCallbackEXT = void function(VkInstance instance,VkDebugReportCallbackEXT callback,const(VkAllocationCallbacks)* pAllocator);
		alias PFN_vkDebugReportMessageEXT = void function(VkInstance instance,VkDebugReportFlagsEXT flags,VkDebugReportObjectTypeEXT objectType,uint64_t object,size_t location,int32_t messageCode,const(char)* pLayerPrefix,const(char)* pMessage);
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
	}
	version(DVulkan_VK_AMD_extension_4) {
	}
	version(DVulkan_VK_AMD_extension_5) {
	}
	version(DVulkan_VK_AMD_extension_6) {
	}
	version(DVulkan_VK_EXT_debug_marker) {
		alias PFN_vkDebugMarkerSetObjectTagEXT = VkResult function(VkDevice device,VkDebugMarkerObjectTagInfoEXT* pTagInfo);
		alias PFN_vkDebugMarkerSetObjectNameEXT = VkResult function(VkDevice device,VkDebugMarkerObjectNameInfoEXT* pNameInfo);
		alias PFN_vkCmdDebugMarkerBeginEXT = void function(VkCommandBuffer commandBuffer,VkDebugMarkerMarkerInfoEXT* pMarkerInfo);
		alias PFN_vkCmdDebugMarkerEndEXT = void function(VkCommandBuffer commandBuffer);
		alias PFN_vkCmdDebugMarkerInsertEXT = void function(VkCommandBuffer commandBuffer,VkDebugMarkerMarkerInfoEXT* pMarkerInfo);
	}
}
__gshared {
	version(DVulkan_VK_VERSION_1_0) {
		PFN_vkCreateInstance vkCreateInstance;
		PFN_vkDestroyInstance vkDestroyInstance;
		PFN_vkEnumeratePhysicalDevices vkEnumeratePhysicalDevices;
		PFN_vkGetPhysicalDeviceFeatures vkGetPhysicalDeviceFeatures;
		PFN_vkGetPhysicalDeviceFormatProperties vkGetPhysicalDeviceFormatProperties;
		PFN_vkGetPhysicalDeviceImageFormatProperties vkGetPhysicalDeviceImageFormatProperties;
		PFN_vkGetPhysicalDeviceProperties vkGetPhysicalDeviceProperties;
		PFN_vkGetPhysicalDeviceQueueFamilyProperties vkGetPhysicalDeviceQueueFamilyProperties;
		PFN_vkGetPhysicalDeviceMemoryProperties vkGetPhysicalDeviceMemoryProperties;
		PFN_vkGetInstanceProcAddr vkGetInstanceProcAddr;
		PFN_vkGetDeviceProcAddr vkGetDeviceProcAddr;
		PFN_vkCreateDevice vkCreateDevice;
		PFN_vkDestroyDevice vkDestroyDevice;
		PFN_vkEnumerateInstanceExtensionProperties vkEnumerateInstanceExtensionProperties;
		PFN_vkEnumerateDeviceExtensionProperties vkEnumerateDeviceExtensionProperties;
		PFN_vkEnumerateInstanceLayerProperties vkEnumerateInstanceLayerProperties;
		PFN_vkEnumerateDeviceLayerProperties vkEnumerateDeviceLayerProperties;
		PFN_vkGetDeviceQueue vkGetDeviceQueue;
		PFN_vkQueueSubmit vkQueueSubmit;
		PFN_vkQueueWaitIdle vkQueueWaitIdle;
		PFN_vkDeviceWaitIdle vkDeviceWaitIdle;
		PFN_vkAllocateMemory vkAllocateMemory;
		PFN_vkFreeMemory vkFreeMemory;
		PFN_vkMapMemory vkMapMemory;
		PFN_vkUnmapMemory vkUnmapMemory;
		PFN_vkFlushMappedMemoryRanges vkFlushMappedMemoryRanges;
		PFN_vkInvalidateMappedMemoryRanges vkInvalidateMappedMemoryRanges;
		PFN_vkGetDeviceMemoryCommitment vkGetDeviceMemoryCommitment;
		PFN_vkBindBufferMemory vkBindBufferMemory;
		PFN_vkBindImageMemory vkBindImageMemory;
		PFN_vkGetBufferMemoryRequirements vkGetBufferMemoryRequirements;
		PFN_vkGetImageMemoryRequirements vkGetImageMemoryRequirements;
		PFN_vkGetImageSparseMemoryRequirements vkGetImageSparseMemoryRequirements;
		PFN_vkGetPhysicalDeviceSparseImageFormatProperties vkGetPhysicalDeviceSparseImageFormatProperties;
		PFN_vkQueueBindSparse vkQueueBindSparse;
		PFN_vkCreateFence vkCreateFence;
		PFN_vkDestroyFence vkDestroyFence;
		PFN_vkResetFences vkResetFences;
		PFN_vkGetFenceStatus vkGetFenceStatus;
		PFN_vkWaitForFences vkWaitForFences;
		PFN_vkCreateSemaphore vkCreateSemaphore;
		PFN_vkDestroySemaphore vkDestroySemaphore;
		PFN_vkCreateEvent vkCreateEvent;
		PFN_vkDestroyEvent vkDestroyEvent;
		PFN_vkGetEventStatus vkGetEventStatus;
		PFN_vkSetEvent vkSetEvent;
		PFN_vkResetEvent vkResetEvent;
		PFN_vkCreateQueryPool vkCreateQueryPool;
		PFN_vkDestroyQueryPool vkDestroyQueryPool;
		PFN_vkGetQueryPoolResults vkGetQueryPoolResults;
		PFN_vkCreateBuffer vkCreateBuffer;
		PFN_vkDestroyBuffer vkDestroyBuffer;
		PFN_vkCreateBufferView vkCreateBufferView;
		PFN_vkDestroyBufferView vkDestroyBufferView;
		PFN_vkCreateImage vkCreateImage;
		PFN_vkDestroyImage vkDestroyImage;
		PFN_vkGetImageSubresourceLayout vkGetImageSubresourceLayout;
		PFN_vkCreateImageView vkCreateImageView;
		PFN_vkDestroyImageView vkDestroyImageView;
		PFN_vkCreateShaderModule vkCreateShaderModule;
		PFN_vkDestroyShaderModule vkDestroyShaderModule;
		PFN_vkCreatePipelineCache vkCreatePipelineCache;
		PFN_vkDestroyPipelineCache vkDestroyPipelineCache;
		PFN_vkGetPipelineCacheData vkGetPipelineCacheData;
		PFN_vkMergePipelineCaches vkMergePipelineCaches;
		PFN_vkCreateGraphicsPipelines vkCreateGraphicsPipelines;
		PFN_vkCreateComputePipelines vkCreateComputePipelines;
		PFN_vkDestroyPipeline vkDestroyPipeline;
		PFN_vkCreatePipelineLayout vkCreatePipelineLayout;
		PFN_vkDestroyPipelineLayout vkDestroyPipelineLayout;
		PFN_vkCreateSampler vkCreateSampler;
		PFN_vkDestroySampler vkDestroySampler;
		PFN_vkCreateDescriptorSetLayout vkCreateDescriptorSetLayout;
		PFN_vkDestroyDescriptorSetLayout vkDestroyDescriptorSetLayout;
		PFN_vkCreateDescriptorPool vkCreateDescriptorPool;
		PFN_vkDestroyDescriptorPool vkDestroyDescriptorPool;
		PFN_vkResetDescriptorPool vkResetDescriptorPool;
		PFN_vkAllocateDescriptorSets vkAllocateDescriptorSets;
		PFN_vkFreeDescriptorSets vkFreeDescriptorSets;
		PFN_vkUpdateDescriptorSets vkUpdateDescriptorSets;
		PFN_vkCreateFramebuffer vkCreateFramebuffer;
		PFN_vkDestroyFramebuffer vkDestroyFramebuffer;
		PFN_vkCreateRenderPass vkCreateRenderPass;
		PFN_vkDestroyRenderPass vkDestroyRenderPass;
		PFN_vkGetRenderAreaGranularity vkGetRenderAreaGranularity;
		PFN_vkCreateCommandPool vkCreateCommandPool;
		PFN_vkDestroyCommandPool vkDestroyCommandPool;
		PFN_vkResetCommandPool vkResetCommandPool;
		PFN_vkAllocateCommandBuffers vkAllocateCommandBuffers;
		PFN_vkFreeCommandBuffers vkFreeCommandBuffers;
		PFN_vkBeginCommandBuffer vkBeginCommandBuffer;
		PFN_vkEndCommandBuffer vkEndCommandBuffer;
		PFN_vkResetCommandBuffer vkResetCommandBuffer;
		PFN_vkCmdBindPipeline vkCmdBindPipeline;
		PFN_vkCmdSetViewport vkCmdSetViewport;
		PFN_vkCmdSetScissor vkCmdSetScissor;
		PFN_vkCmdSetLineWidth vkCmdSetLineWidth;
		PFN_vkCmdSetDepthBias vkCmdSetDepthBias;
		PFN_vkCmdSetBlendConstants vkCmdSetBlendConstants;
		PFN_vkCmdSetDepthBounds vkCmdSetDepthBounds;
		PFN_vkCmdSetStencilCompareMask vkCmdSetStencilCompareMask;
		PFN_vkCmdSetStencilWriteMask vkCmdSetStencilWriteMask;
		PFN_vkCmdSetStencilReference vkCmdSetStencilReference;
		PFN_vkCmdBindDescriptorSets vkCmdBindDescriptorSets;
		PFN_vkCmdBindIndexBuffer vkCmdBindIndexBuffer;
		PFN_vkCmdBindVertexBuffers vkCmdBindVertexBuffers;
		PFN_vkCmdDraw vkCmdDraw;
		PFN_vkCmdDrawIndexed vkCmdDrawIndexed;
		PFN_vkCmdDrawIndirect vkCmdDrawIndirect;
		PFN_vkCmdDrawIndexedIndirect vkCmdDrawIndexedIndirect;
		PFN_vkCmdDispatch vkCmdDispatch;
		PFN_vkCmdDispatchIndirect vkCmdDispatchIndirect;
		PFN_vkCmdCopyBuffer vkCmdCopyBuffer;
		PFN_vkCmdCopyImage vkCmdCopyImage;
		PFN_vkCmdBlitImage vkCmdBlitImage;
		PFN_vkCmdCopyBufferToImage vkCmdCopyBufferToImage;
		PFN_vkCmdCopyImageToBuffer vkCmdCopyImageToBuffer;
		PFN_vkCmdUpdateBuffer vkCmdUpdateBuffer;
		PFN_vkCmdFillBuffer vkCmdFillBuffer;
		PFN_vkCmdClearColorImage vkCmdClearColorImage;
		PFN_vkCmdClearDepthStencilImage vkCmdClearDepthStencilImage;
		PFN_vkCmdClearAttachments vkCmdClearAttachments;
		PFN_vkCmdResolveImage vkCmdResolveImage;
		PFN_vkCmdSetEvent vkCmdSetEvent;
		PFN_vkCmdResetEvent vkCmdResetEvent;
		PFN_vkCmdWaitEvents vkCmdWaitEvents;
		PFN_vkCmdPipelineBarrier vkCmdPipelineBarrier;
		PFN_vkCmdBeginQuery vkCmdBeginQuery;
		PFN_vkCmdEndQuery vkCmdEndQuery;
		PFN_vkCmdResetQueryPool vkCmdResetQueryPool;
		PFN_vkCmdWriteTimestamp vkCmdWriteTimestamp;
		PFN_vkCmdCopyQueryPoolResults vkCmdCopyQueryPoolResults;
		PFN_vkCmdPushConstants vkCmdPushConstants;
		PFN_vkCmdBeginRenderPass vkCmdBeginRenderPass;
		PFN_vkCmdNextSubpass vkCmdNextSubpass;
		PFN_vkCmdEndRenderPass vkCmdEndRenderPass;
		PFN_vkCmdExecuteCommands vkCmdExecuteCommands;
		private alias EXTN_FUNCS_VK_VERSION_1_0 = TypeTuple!(
			vkCreateInstance,
			vkDestroyInstance,
			vkEnumeratePhysicalDevices,
			vkGetPhysicalDeviceFeatures,
			vkGetPhysicalDeviceFormatProperties,
			vkGetPhysicalDeviceImageFormatProperties,
			vkGetPhysicalDeviceProperties,
			vkGetPhysicalDeviceQueueFamilyProperties,
			vkGetPhysicalDeviceMemoryProperties,
			vkGetInstanceProcAddr,
			vkGetDeviceProcAddr,
			vkCreateDevice,
			vkDestroyDevice,
			vkEnumerateInstanceExtensionProperties,
			vkEnumerateDeviceExtensionProperties,
			vkEnumerateInstanceLayerProperties,
			vkEnumerateDeviceLayerProperties,
			vkGetDeviceQueue,
			vkQueueSubmit,
			vkQueueWaitIdle,
			vkDeviceWaitIdle,
			vkAllocateMemory,
			vkFreeMemory,
			vkMapMemory,
			vkUnmapMemory,
			vkFlushMappedMemoryRanges,
			vkInvalidateMappedMemoryRanges,
			vkGetDeviceMemoryCommitment,
			vkBindBufferMemory,
			vkBindImageMemory,
			vkGetBufferMemoryRequirements,
			vkGetImageMemoryRequirements,
			vkGetImageSparseMemoryRequirements,
			vkGetPhysicalDeviceSparseImageFormatProperties,
			vkQueueBindSparse,
			vkCreateFence,
			vkDestroyFence,
			vkResetFences,
			vkGetFenceStatus,
			vkWaitForFences,
			vkCreateSemaphore,
			vkDestroySemaphore,
			vkCreateEvent,
			vkDestroyEvent,
			vkGetEventStatus,
			vkSetEvent,
			vkResetEvent,
			vkCreateQueryPool,
			vkDestroyQueryPool,
			vkGetQueryPoolResults,
			vkCreateBuffer,
			vkDestroyBuffer,
			vkCreateBufferView,
			vkDestroyBufferView,
			vkCreateImage,
			vkDestroyImage,
			vkGetImageSubresourceLayout,
			vkCreateImageView,
			vkDestroyImageView,
			vkCreateShaderModule,
			vkDestroyShaderModule,
			vkCreatePipelineCache,
			vkDestroyPipelineCache,
			vkGetPipelineCacheData,
			vkMergePipelineCaches,
			vkCreateGraphicsPipelines,
			vkCreateComputePipelines,
			vkDestroyPipeline,
			vkCreatePipelineLayout,
			vkDestroyPipelineLayout,
			vkCreateSampler,
			vkDestroySampler,
			vkCreateDescriptorSetLayout,
			vkDestroyDescriptorSetLayout,
			vkCreateDescriptorPool,
			vkDestroyDescriptorPool,
			vkResetDescriptorPool,
			vkAllocateDescriptorSets,
			vkFreeDescriptorSets,
			vkUpdateDescriptorSets,
			vkCreateFramebuffer,
			vkDestroyFramebuffer,
			vkCreateRenderPass,
			vkDestroyRenderPass,
			vkGetRenderAreaGranularity,
			vkCreateCommandPool,
			vkDestroyCommandPool,
			vkResetCommandPool,
			vkAllocateCommandBuffers,
			vkFreeCommandBuffers,
			vkBeginCommandBuffer,
			vkEndCommandBuffer,
			vkResetCommandBuffer,
			vkCmdBindPipeline,
			vkCmdSetViewport,
			vkCmdSetScissor,
			vkCmdSetLineWidth,
			vkCmdSetDepthBias,
			vkCmdSetBlendConstants,
			vkCmdSetDepthBounds,
			vkCmdSetStencilCompareMask,
			vkCmdSetStencilWriteMask,
			vkCmdSetStencilReference,
			vkCmdBindDescriptorSets,
			vkCmdBindIndexBuffer,
			vkCmdBindVertexBuffers,
			vkCmdDraw,
			vkCmdDrawIndexed,
			vkCmdDrawIndirect,
			vkCmdDrawIndexedIndirect,
			vkCmdDispatch,
			vkCmdDispatchIndirect,
			vkCmdCopyBuffer,
			vkCmdCopyImage,
			vkCmdBlitImage,
			vkCmdCopyBufferToImage,
			vkCmdCopyImageToBuffer,
			vkCmdUpdateBuffer,
			vkCmdFillBuffer,
			vkCmdClearColorImage,
			vkCmdClearDepthStencilImage,
			vkCmdClearAttachments,
			vkCmdResolveImage,
			vkCmdSetEvent,
			vkCmdResetEvent,
			vkCmdWaitEvents,
			vkCmdPipelineBarrier,
			vkCmdBeginQuery,
			vkCmdEndQuery,
			vkCmdResetQueryPool,
			vkCmdWriteTimestamp,
			vkCmdCopyQueryPoolResults,
			vkCmdPushConstants,
			vkCmdBeginRenderPass,
			vkCmdNextSubpass,
			vkCmdEndRenderPass,
			vkCmdExecuteCommands,
		);
	} else { private alias EXTN_FUNCS_VK_VERSION_1_0 = TypeTuple!(); }
	version(DVulkan_VK_KHR_surface) {
		PFN_vkDestroySurfaceKHR vkDestroySurfaceKHR;
		PFN_vkGetPhysicalDeviceSurfaceSupportKHR vkGetPhysicalDeviceSurfaceSupportKHR;
		PFN_vkGetPhysicalDeviceSurfaceCapabilitiesKHR vkGetPhysicalDeviceSurfaceCapabilitiesKHR;
		PFN_vkGetPhysicalDeviceSurfaceFormatsKHR vkGetPhysicalDeviceSurfaceFormatsKHR;
		PFN_vkGetPhysicalDeviceSurfacePresentModesKHR vkGetPhysicalDeviceSurfacePresentModesKHR;
		private alias EXTN_FUNCS_VK_KHR_surface = TypeTuple!(
			vkDestroySurfaceKHR,
			vkGetPhysicalDeviceSurfaceSupportKHR,
			vkGetPhysicalDeviceSurfaceCapabilitiesKHR,
			vkGetPhysicalDeviceSurfaceFormatsKHR,
			vkGetPhysicalDeviceSurfacePresentModesKHR,
		);
	} else { private alias EXTN_FUNCS_VK_KHR_surface = TypeTuple!(); }
	version(DVulkan_VK_KHR_swapchain) {
		PFN_vkCreateSwapchainKHR vkCreateSwapchainKHR;
		PFN_vkDestroySwapchainKHR vkDestroySwapchainKHR;
		PFN_vkGetSwapchainImagesKHR vkGetSwapchainImagesKHR;
		PFN_vkAcquireNextImageKHR vkAcquireNextImageKHR;
		PFN_vkQueuePresentKHR vkQueuePresentKHR;
		private alias EXTN_FUNCS_VK_KHR_swapchain = TypeTuple!(
			vkCreateSwapchainKHR,
			vkDestroySwapchainKHR,
			vkGetSwapchainImagesKHR,
			vkAcquireNextImageKHR,
			vkQueuePresentKHR,
		);
	} else { private alias EXTN_FUNCS_VK_KHR_swapchain = TypeTuple!(); }
	version(DVulkan_VK_KHR_display) {
		PFN_vkGetPhysicalDeviceDisplayPropertiesKHR vkGetPhysicalDeviceDisplayPropertiesKHR;
		PFN_vkGetPhysicalDeviceDisplayPlanePropertiesKHR vkGetPhysicalDeviceDisplayPlanePropertiesKHR;
		PFN_vkGetDisplayPlaneSupportedDisplaysKHR vkGetDisplayPlaneSupportedDisplaysKHR;
		PFN_vkGetDisplayModePropertiesKHR vkGetDisplayModePropertiesKHR;
		PFN_vkCreateDisplayModeKHR vkCreateDisplayModeKHR;
		PFN_vkGetDisplayPlaneCapabilitiesKHR vkGetDisplayPlaneCapabilitiesKHR;
		PFN_vkCreateDisplayPlaneSurfaceKHR vkCreateDisplayPlaneSurfaceKHR;
		private alias EXTN_FUNCS_VK_KHR_display = TypeTuple!(
			vkGetPhysicalDeviceDisplayPropertiesKHR,
			vkGetPhysicalDeviceDisplayPlanePropertiesKHR,
			vkGetDisplayPlaneSupportedDisplaysKHR,
			vkGetDisplayModePropertiesKHR,
			vkCreateDisplayModeKHR,
			vkGetDisplayPlaneCapabilitiesKHR,
			vkCreateDisplayPlaneSurfaceKHR,
		);
	} else { private alias EXTN_FUNCS_VK_KHR_display = TypeTuple!(); }
	version(DVulkan_VK_KHR_display_swapchain) {
		PFN_vkCreateSharedSwapchainsKHR vkCreateSharedSwapchainsKHR;
		private alias EXTN_FUNCS_VK_KHR_display_swapchain = TypeTuple!(
			vkCreateSharedSwapchainsKHR,
		);
	} else { private alias EXTN_FUNCS_VK_KHR_display_swapchain = TypeTuple!(); }
	version(DVulkan_VK_KHR_sampler_mirror_clamp_to_edge) {
		private alias EXTN_FUNCS_VK_KHR_sampler_mirror_clamp_to_edge = TypeTuple!(
		);
	} else { private alias EXTN_FUNCS_VK_KHR_sampler_mirror_clamp_to_edge = TypeTuple!(); }
	version(DVulkan_VK_ANDROID_native_buffer) {
		private alias EXTN_FUNCS_VK_ANDROID_native_buffer = TypeTuple!(
		);
	} else { private alias EXTN_FUNCS_VK_ANDROID_native_buffer = TypeTuple!(); }
	version(DVulkan_VK_EXT_debug_report) {
		PFN_vkCreateDebugReportCallbackEXT vkCreateDebugReportCallbackEXT;
		PFN_vkDestroyDebugReportCallbackEXT vkDestroyDebugReportCallbackEXT;
		PFN_vkDebugReportMessageEXT vkDebugReportMessageEXT;
		private alias EXTN_FUNCS_VK_EXT_debug_report = TypeTuple!(
			vkCreateDebugReportCallbackEXT,
			vkDestroyDebugReportCallbackEXT,
			vkDebugReportMessageEXT,
		);
	} else { private alias EXTN_FUNCS_VK_EXT_debug_report = TypeTuple!(); }
	version(DVulkan_VK_NV_glsl_shader) {
		private alias EXTN_FUNCS_VK_NV_glsl_shader = TypeTuple!(
		);
	} else { private alias EXTN_FUNCS_VK_NV_glsl_shader = TypeTuple!(); }
	version(DVulkan_VK_NV_extension_1) {
		private alias EXTN_FUNCS_VK_NV_extension_1 = TypeTuple!(
		);
	} else { private alias EXTN_FUNCS_VK_NV_extension_1 = TypeTuple!(); }
	version(DVulkan_VK_IMG_filter_cubic) {
		private alias EXTN_FUNCS_VK_IMG_filter_cubic = TypeTuple!(
		);
	} else { private alias EXTN_FUNCS_VK_IMG_filter_cubic = TypeTuple!(); }
	version(DVulkan_VK_AMD_extension_1) {
		private alias EXTN_FUNCS_VK_AMD_extension_1 = TypeTuple!(
		);
	} else { private alias EXTN_FUNCS_VK_AMD_extension_1 = TypeTuple!(); }
	version(DVulkan_VK_AMD_extension_2) {
		private alias EXTN_FUNCS_VK_AMD_extension_2 = TypeTuple!(
		);
	} else { private alias EXTN_FUNCS_VK_AMD_extension_2 = TypeTuple!(); }
	version(DVulkan_VK_AMD_rasterization_order) {
		private alias EXTN_FUNCS_VK_AMD_rasterization_order = TypeTuple!(
		);
	} else { private alias EXTN_FUNCS_VK_AMD_rasterization_order = TypeTuple!(); }
	version(DVulkan_VK_AMD_extension_4) {
		private alias EXTN_FUNCS_VK_AMD_extension_4 = TypeTuple!(
		);
	} else { private alias EXTN_FUNCS_VK_AMD_extension_4 = TypeTuple!(); }
	version(DVulkan_VK_AMD_extension_5) {
		private alias EXTN_FUNCS_VK_AMD_extension_5 = TypeTuple!(
		);
	} else { private alias EXTN_FUNCS_VK_AMD_extension_5 = TypeTuple!(); }
	version(DVulkan_VK_AMD_extension_6) {
		private alias EXTN_FUNCS_VK_AMD_extension_6 = TypeTuple!(
		);
	} else { private alias EXTN_FUNCS_VK_AMD_extension_6 = TypeTuple!(); }
	version(DVulkan_VK_EXT_debug_marker) {
		PFN_vkDebugMarkerSetObjectTagEXT vkDebugMarkerSetObjectTagEXT;
		PFN_vkDebugMarkerSetObjectNameEXT vkDebugMarkerSetObjectNameEXT;
		PFN_vkCmdDebugMarkerBeginEXT vkCmdDebugMarkerBeginEXT;
		PFN_vkCmdDebugMarkerEndEXT vkCmdDebugMarkerEndEXT;
		PFN_vkCmdDebugMarkerInsertEXT vkCmdDebugMarkerInsertEXT;
		private alias EXTN_FUNCS_VK_EXT_debug_marker = TypeTuple!(
			vkDebugMarkerSetObjectTagEXT,
			vkDebugMarkerSetObjectNameEXT,
			vkCmdDebugMarkerBeginEXT,
			vkCmdDebugMarkerEndEXT,
			vkCmdDebugMarkerInsertEXT,
		);
	} else { private alias EXTN_FUNCS_VK_EXT_debug_marker = TypeTuple!(); }
}
private alias ALL_FUNCS = TypeTuple!(
	EXTN_FUNCS_VK_VERSION_1_0,
	EXTN_FUNCS_VK_KHR_surface,
	EXTN_FUNCS_VK_KHR_swapchain,
	EXTN_FUNCS_VK_KHR_display,
	EXTN_FUNCS_VK_KHR_display_swapchain,
	EXTN_FUNCS_VK_KHR_sampler_mirror_clamp_to_edge,
	EXTN_FUNCS_VK_ANDROID_native_buffer,
	EXTN_FUNCS_VK_EXT_debug_report,
	EXTN_FUNCS_VK_NV_glsl_shader,
	EXTN_FUNCS_VK_NV_extension_1,
	EXTN_FUNCS_VK_IMG_filter_cubic,
	EXTN_FUNCS_VK_AMD_extension_1,
	EXTN_FUNCS_VK_AMD_extension_2,
	EXTN_FUNCS_VK_AMD_rasterization_order,
	EXTN_FUNCS_VK_AMD_extension_4,
	EXTN_FUNCS_VK_AMD_extension_5,
	EXTN_FUNCS_VK_AMD_extension_6,
	EXTN_FUNCS_VK_EXT_debug_marker,
);


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
