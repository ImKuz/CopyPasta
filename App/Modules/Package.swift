// swift-tools-version:5.5

import PackageDescription

let content: [(Product, [Target])] = [
    (
        .library(name: "AppAssembler", targets: ["AppAssembler"]),
        [
            .target(
                name: "AppAssembler",
                dependencies: [
                    "SharedInterfaces",
                    "CatalogClient",
                    "CatalogServer",
                    "CatalogSource",
                    "IPAddressProvider",
                    "Database",
                    "ToolKit",
                    // Features
                    "RootFeature",
                    "CatalogFeature",
                    "AddItemFeature",
                    "RemoteFeature",
                    .product(name: "Swinject", package: "Swinject"),
                ],
                path: "Modules/AppAssembler/Sources"
            )
        ]
    ),
    (
        .library(name: "ToolKit", targets: ["ToolKit"]),
        [
            .target(
                name: "ToolKit",
                path: "Modules/ToolKit/Sources"
            ),
        ]
    ),
    (
        .library(name: "SharedInterfaces", targets: ["SharedInterfaces"]),
        [
            .target(
                name: "SharedInterfaces",
                dependencies: [
                    "ToolKit",
                    "Models",
                    .product(name: "IdentifiedCollections", package: "swift-identified-collections"),
                ],
                path: "Modules/SharedInterfaces/Sources"
            ),
        ]
    ),
    (
        .library(name: "Models", targets: ["Models"]),
        [
            .target(
                name: "Models",
                path: "Modules/Models/Sources"
            ),
        ]
    ),
    (
        .library(name: "Database", targets: ["Database"]),
        [
            .target(
                name: "Database",
                dependencies: [
                    "ToolKit",
                    "Swinject"
                ],
                path: "Modules/Database/Sources"
            ),
        ]
    ),
    (
        .library(name: "Contracts", targets: ["Contracts"]),
        [
            .target(
                name: "Contracts",
                dependencies: [
                    .product(name: "GRPC", package: "grpc-swift")
                ],
                path: "Modules/Contracts/Sources"
            ),
        ]
    ),
    (
        .library(name: "IPAddressProvider", targets: ["IPAddressProvider"]),
        [
            .target(
                name: "IPAddressProvider",
                dependencies: ["Swinject"],
                path: "Modules/IPAddressProvider/Sources"
            ),
        ]
    ),
    (
        .library(name: "CatalogServer", targets: ["CatalogServer"]),
        [
            .target(
                name: "CatalogServer",
                dependencies: [
                    "Swinject",
                    "ToolKit",
                    "Models",
                    "Contracts",
                    "IPAddressProvider",
                    .product(name: "GRPC", package: "grpc-swift")
                ],
                path: "Modules/CatalogServer/Sources"
            ),
        ]
    ),
    (
        .library(name: "CatalogClient", targets: ["CatalogClient"]),
        [
            .target(
                name: "CatalogClient",
                dependencies: [
                    "Swinject",
                    "ToolKit",
                    "Models",
                    "Contracts",
                ],
                path: "Modules/CatalogClient/Sources"
            ),
        ]
    ),
    (
        .library(name: "CatalogSource", targets: ["CatalogSource"]),
        [
            .target(
                name: "CatalogSource",
                dependencies: [
                    "Swinject",
                    "ToolKit",
                    "Models",
                    "Contracts",
                    "Database",
                    "CatalogClient",
                    "SharedInterfaces",
                    .product(name: "IdentifiedCollections", package: "swift-identified-collections"),
                ],
                path: "Modules/CatalogSource/Sources"
            ),
        ]
    ),
    (
        .library(name: "Logger", targets: ["Logger"]),
        [
            .target(
                name: "Logger",
                dependencies: [
                    "ToolKit",
                    "Swinject",
                    .product(name: "Logging", package: "swift-log"),
                ],
                path: "Modules/Logger/Sources"
            ),
        ]
    ),

    // MARK: - Features

    (
        .library(name: "RootFeature", targets: ["RootFeature"]),
        [
            .target(
                name: "RootFeature",
                dependencies: [
                    "ToolKit",
                    "SharedInterfaces",
                    "Models",
                    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                    .product(name: "Swinject", package: "Swinject")
                ],
                path: "Modules/Features/RootFeature/Sources"
            ),
        ]
    ),
    (
        .library(name: "CatalogFeature", targets: ["CatalogFeature"]),
        [
            .target(
                name: "CatalogFeature",
                dependencies: [
                    "ToolKit",
                    "Contracts",
                    "SharedInterfaces",
                    "Database",
                    "Models",
                    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                    .product(name: "IdentifiedCollections", package: "swift-identified-collections"),
                    .product(name: "Swinject", package: "Swinject"),
                ],
                path: "Modules/Features/CatalogFeature/Sources"
            ),
        ]
    ),
    (
        .library(name: "AddItemFeature", targets: ["AddItemFeature"]),
        [
            .target(
                name: "AddItemFeature",
                dependencies: [
                    "ToolKit",
                    "SharedInterfaces",
                    "Models",
                    "CatalogSource",
                    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                    .product(name: "Swinject", package: "Swinject"),
                ],
                path: "Modules/Features/AddItemFeature/Sources"
            ),
        ]
    ),
    (
        .library(name: "RemoteFeature", targets: ["RemoteFeature"]),
        [
            .target(
                name: "RemoteFeature",
                dependencies: [
                    "ToolKit",
                    "SharedInterfaces",
                    "Models",
                    "CatalogServer",
                    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                    .product(name: "Swinject", package: "Swinject"),
                ],
                path: "Modules/Features/RemoteFeature/Sources"
            )
        ]
    ),
]

let package = Package(
    name: "CopyPastaModules",
    platforms: [ .iOS(.v15) ],
    products: content.map { $0.0 },
    dependencies: [
        .package(
            name: "swift-composable-architecture",
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            branch: "main"
        ),
        .package(
            url: "https://github.com/grpc/grpc-swift.git",
            from: "1.0.0"
        ),
        .package(
            name: "Swinject",
            url: "https://github.com/Swinject/Swinject",
            from: "2.8.1"
        ),
        .package(
            name: "swift-identified-collections",
            url: "https://github.com/pointfreeco/swift-identified-collections",
            from: "0.3.2"
        ),
        .package(
            url: "https://github.com/apple/swift-log.git",
            from: "1.0.0"
        ),
    ],
    targets: content.flatMap { $0.1 }
)
