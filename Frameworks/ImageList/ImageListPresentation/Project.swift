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
                .project(target: "ImageListDomain", path: "../ImageListDomain", status: .required),
            ]
        )
    ]
)
