// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "rekognition_face_liveness",
    platforms: [
        // If your plugin only supports iOS, remove `.macOS(...)`.
        // If your plugin only supports macOS, remove `.iOS(...)`.
        .iOS("14.0"),
    ],
    products: [
        // If the plugin name contains "_", replace with "-" for the library name.
        .library(name: "rekognition-face-liveness", targets: ["rekognition_face_liveness"])
    ],
    dependencies: [
        .package(url: "https://github.com/aws-amplify/amplify-swift", from: "2.3.1"),
        // Webeleven fork of amplify-ui-swift-liveness, pinned to a patched 1.4.4 that fixes
        // the VideoChunker AVAssetWriter append-after-finish data race (crash:
        // NSInternalInconsistencyException "Must start a session ... before appending pixel
        // buffers"). The bug is still present in upstream 1.4.4. Drop this fork and return to
        // the upstream package once the fix lands upstream.
        .package(url: "https://github.com/Webeleven/amplify-ui-swift-liveness", exact: "1.4.4-webeleven.1")
    ],
    targets: [
        .target(
            name: "rekognition_face_liveness",
            dependencies: [
                .product(name: "Amplify", package: "amplify-swift"),
                .product(name: "AWSCognitoAuthPlugin", package: "amplify-swift"),
                .product(name: "FaceLiveness", package: "amplify-ui-swift-liveness")
            ],
            resources: []
        )
    ]
)
