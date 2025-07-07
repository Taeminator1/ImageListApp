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
                .project(target: "ImageListDomain", path: "../ImageListDomain", status: .required),
            ]
        )
    ]
)
