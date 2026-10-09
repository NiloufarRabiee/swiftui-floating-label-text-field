// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "FloatingLabelTextField",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "FloatingLabelTextField",
            targets: ["FloatingLabelTextField"]
        )
    ],
    targets: [
        .target(
            name: "FloatingLabelTextField"
        ),
        .testTarget(
            name: "FloatingLabelTextFieldTests",
            dependencies: ["FloatingLabelTextField"]
        )
    ]
)
