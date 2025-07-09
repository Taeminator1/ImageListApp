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
            dependencies: [
                .project(target: "ImageListData", path: .relativeToRoot("Frameworks/ImageList/ImageListData"), status: .required),
                .project(target: "ImageListDomain", path: .relativeToRoot("Frameworks/ImageList/ImageListDomain"), status: .required),
                .project(target: "ImageListPresentation", path: .relativeToRoot("Frameworks/ImageList/ImageListPresentation"), status: .required),
            ]
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
        )
    ],
    schemes: [
        .scheme(
            name: "ImageListApp",
            buildAction: .buildAction(
                targets: [.init(stringLiteral: "ImageListApp")]
            ),
            testAction: .testPlans(
                [.relativeToRoot("ImageListAppTests/ImageListApp.xctestplan")]
            )
        )
    ]
)
