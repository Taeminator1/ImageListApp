import ProjectDescription

let project = Project(
    name: "ImageListPresentation",
    targets: [
        .target(
            name: "ImageListPresentation",
            destinations: .iOS,
            product: .framework,
            bundleId: "dev.tuist.ImageListPresentation",
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "Kingfisher"),
                .project(target: "AppError", path: .relativeToRoot("Frameworks/AppError"), status: .required),
                .project(target: "ImageListDomain", path: .relativeToRoot("Frameworks/ImageList/ImageListDomain"), status: .required),
            ]
        )
    ]
)
