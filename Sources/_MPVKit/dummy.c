// libplacebo exposes this symbol even when libmpv is built with both GL and
// Vulkan outputs disabled. The audio-only integration has no Vulkan loader and
// cannot reach this path; returning NULL makes any accidental probe fail cleanly.
void *vkGetInstanceProcAddr(void *instance, const char *name) {
    (void)instance;
    (void)name;
    return 0;
}
