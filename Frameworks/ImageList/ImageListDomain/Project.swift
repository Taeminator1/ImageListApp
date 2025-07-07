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
            ]
        )
    ]
)
