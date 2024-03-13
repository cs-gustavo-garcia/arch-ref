import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "ArchrefApp",
    packages: [
        .remote(url: "https://github.com/Alamofire/Alamofire",
                requirement: .upToNextMajor(from: "5.0.0")),
        .local(path: .relativeToManifest("../LocalSwiftPackage/"))
    ],
    settings: .projectSettings,
    targets: [
        Target(
            name: "ArchrefApp",
            destinations: .iOS,
            product: .app,
            bundleId: "archref.app",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .default,
            sources: "Sources/App/**",
            dependencies: [
                .package(product: "Alamofire"),
                .package(product: "LocalSwiftPackage")
            ],
            settings: .targetSettings
        ),
        Target(
            name: "ArchrefAppTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "archref.unittests",
            deploymentTargets: .iOS("15.0"),
            sources: "Sources/Tests/**",
            dependencies: [
                .target(name: "ArchrefApp")
            ]),
    ],
    schemes: Scheme.allSchemes(for: ["ArchrefApp"], executable: "ArchrefApp")
)
