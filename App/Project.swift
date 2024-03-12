import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "App",
    packages: [
        .remote(url: "https://github.com/Alamofire/Alamofire",
                requirement: .upToNextMajor(from: "5.0.0")),
        .local(path: .relativeToManifest("../LocalSwiftPackage"))
    ],
    settings: .projectSettings,
    targets: [
        Target(
            name: "App",
            destinations: .iOS,
            product: .app,
            bundleId: "archref.app",
            infoPlist: .default,
            sources: "Sources/App/**",
            dependencies: [
                .package(product: "Alamofire"),
                .package(product: "LocalSwiftPackage")
            ],
            settings: .targetSettings
        ),
        Target(name: "AppTests",
               destinations: .iOS,
               product: .unitTests,
               bundleId: "archref.unittests")
    ],
    schemes: Scheme.allSchemes(for: ["App"], executable: "App")
)
