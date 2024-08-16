// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.


import PackageDescription

let package = Package(
    name: "SimpleRunnerDriver",
    
    platforms: [.macOS(.v14), .iOS(.v16)],
    
    products: [
        .library(
            name: "SimpleRunnerDriver",
            type: .dynamic,
            targets: ["SimpleRunnerDriver"]),
    ],
    
    dependencies: [
        .package(
            url: "https://github.com/elegantchaos/SwiftGodot",
            branch: "dev"
        )
    ],
    
    targets: [
        .target(
            name: "SimpleRunnerDriver",
            dependencies: ["SwiftGodot"]
        )
    ]
)
