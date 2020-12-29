// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyDorpdown",
    platforms: [
        .iOS(.v10),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SwiftyDorpdown",
            targets: ["SwiftyDorpdown"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/SnapKit/SnapKit", from: "5.0.0"),
        .package(url: "https://github.com/slackhq/PanModal", from: "1.2.7"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SwiftyDorpdown",
            dependencies: [.product(name: "SnapKit", package: "SnapKit"),
                           .product(name: "PanModal", package: "PanModal")],
            resources: [
                    .process("Resources/Images")]),
        .testTarget(
            name: "SwiftyDorpdownTests",
            dependencies: ["SwiftyDorpdown"]),
    ]
)
