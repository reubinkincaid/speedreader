// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "SpeedReader",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "SpeedReader", targets: ["SpeedReader"])
    ],
    targets: [
        .executableTarget(
            name: "SpeedReader",
            dependencies: [],
            resources: [
                .process("Resources")
            ]
        )
    ]
)

