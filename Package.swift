// swift-tools-version:6.0

import PackageDescription

// Audio-only fork of MPVKit for Klopydrome (macOS music player).
// FFmpeg and libmpv are built without the video stack (no Vulkan/MoltenVK,
// no GPU rendering, no subtitles, no disc/SMB protocols); only audio
// decoders/demuxers/filters are enabled. The resulting libmpv.dylib is built
// by ./scripts/build-mpvkit-audio.sh into dist/release/Libmpv.framework — it is
// self-contained: libmpv + the whole FFmpeg audio stack + the ass-render
// stack (libass/libplacebo/libfreetype/libharfbuzz/libfribidi/libunibreak/
// lcms2) are merged into a single dynamic library, so there are zero external
// unresolved symbols and the app links only this one framework.
let package = Package(
    name: "MPVKit",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "MPVKit",
            targets: ["_MPVKit"]
        ),
    ],
    targets: [
        .target(
            name: "_MPVKit",
            dependencies: [
                "Libmpv",
            ],
            path: "Sources/_MPVKit",
            linkerSettings: [
                .linkedFramework("AVFoundation"),
                .linkedFramework("CoreAudio"),
                .linkedFramework("CoreVideo"),
                .linkedFramework("CoreMedia"),
                .linkedFramework("CoreFoundation"),
            ]
        ),

        // Self-contained dynamic libmpv framework (audio-only).
        .binaryTarget(name: "Libmpv", path: "dist/release/xcframework/Libmpv.xcframework"),
    ],
    swiftLanguageModes: [.v5]
)
