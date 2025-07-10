import ProjectDescription

let project = Project(
    name: "ImageListDomain",
    targets: [
        .target(
            name: "ImageListDomain",
            destinations: .iOS,
            product: .framework,
            bundleId: "dev.tuist.ImageListDomain",
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "AppError", path: .relativeToRoot("Frameworks/AppError"), status: .required),
            ]
        ),
        .target(
            name: "ImageListDomainTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.ImageListDomainTests",
            sources: ["Tests/**"],
            dependencies: [
                .project(target: "AppError", path: .relativeToRoot("Frameworks/AppError"), status: .required),
            ]
        ),
    ]
)
