import ProjectDescription

let project = Project(
    name: "AppError",
    targets: [
        .target(
            name: "AppError",
            destinations: .iOS,
            product: .framework,
            bundleId: "dev.tuist.AppError",
            sources: ["Sources/**"],
            dependencies: []
        )
    ]
)
