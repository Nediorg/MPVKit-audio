# MPVKit-Audio

`MPVKit-Audio` is Klopydrome's local, **audio-focused** fork of [MPVKit](https://github.com/mpvkit/MPVKit). It is not a general-purpose package and is maintained only for the macOS music player in this repository.

## Scope

The build keeps the libmpv client API and the macOS CoreAudio/AVFoundation audio outputs used by Klopydrome. FFmpeg is configured with audio decoders, audio-capable demuxers, audio filters, and network protocols needed for HTTP streaming. The following are disabled: video output, OpenGL, Vulkan/MoltenVK, hardware video acceleration, VideoToolbox rendering, shader compilation, Lua, the command-line player, Cocoa UI support, disc devices, and libavdevice.

> libmpv 0.41.0 still declares `libass` and `libplacebo` as unconditional Meson dependencies. They remain build-time link inputs, but no video renderer or subtitle UI is enabled or exposed by Klopydrome.

## Build the local binary target

The compiled XCFramework is intentionally ignored by Git. Build it once after cloning, and again after changing this fork:

```sh
./scripts/build-mpvkit-audio.sh
```

The command requires Homebrew tools `nasm`, `meson`, `ninja`, `cmake`, `pkg-config`, `wget`, and `git`. On a fresh checkout it builds macOS `arm64` and `x86_64` slices and may take 60 minutes. The canonical output consumed by Swift Package Manager is:30

```text
vendor/MPVKit-Audio/dist/release/xcframework/Libmpv.xcframework
```

The build also produces `Libmpv.xcframework.zip` for inspection or distribution, but the package deliberately references the unpacked XCFramework.

## Integration

The root package exposes this fork through the `MPVKit` product. Application code imports `Libmpv` directly for the C API; no video-view or rendering API is part of this integration.

## License

This fork retains the upstream [LGPL v3.0](LICENSE) licensing. The resulting bundle remains LGPL unless it is explicitly built with the optional GPL configuration.
