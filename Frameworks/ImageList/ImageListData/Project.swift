import ProjectDescription

let project = Project(
    name: "ImageListData",
    targets: [
        .target(
            name: "ImageListData",
            destinations: .iOS,
            product: .framework,
            bundleId: "dev.tuist.ImageListData",
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "AppError", path: .relativeToRoot("Frameworks/AppError"), status: .required),
                .project(target: "ImageListDomain", path: .relativeToRoot("Frameworks/ImageList/ImageListDomain"), status: .required),
            ]
        )
    ]
)
