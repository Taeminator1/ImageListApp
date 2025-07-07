import ProjectDescription

let project = Project(
    name: "ImageListApp",
    targets: [
        .target(
            name: "ImageListApp",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.ImageListApp",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["ImageListApp/Sources/**"],
            resources: ["ImageListApp/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "ImageListAppTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.ImageListAppTests",
            infoPlist: .default,
            sources: ["ImageListApp/Tests/**"],
            resources: [],
            dependencies: [.target(name: "ImageListApp")]
        ),
    ]
)
