// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ShowTouches",
	platforms: [
		.iOS(.v8),
    ],
    products: [
        .library(
            name: "ShowTouches",
            targets: ["ShowTouches"]),
    ],
    targets: [
        .target(
            name: "ShowTouches",
            dependencies: []),
    ]
)
