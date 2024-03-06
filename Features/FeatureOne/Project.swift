import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "FeatureOne",
    packages: [
        .remote(url: "https://github.com/Alamofire/Alamofire",
                requirement: .upToNextMajor(from: "5.0.0"))
    ],
    settings: .projectSettings,
    targets: [
        Target(name: "FeatureOneFramework_iOS",
               destinations: .iOS,
               product: .framework,
               bundleId: "io.tuist.featureOne",
               sources: ["Sources/**"],
               dependencies: [
                   .package(product: "Alamofire"),
               ],
               settings: .targetSettings
              ),
        Target(
            name: "FeatureOneFramework_watchOS",
            destinations: .watchOS,
            product: .framework,
            bundleId: "io.tuist.featureOne",
            sources: ["Sources/**"],
            dependencies: [
                .package(product: "Alamofire"),
            ],
            settings: .targetSettings
        ),
    ],
    schemes: Scheme.allSchemes(for: ["FeatureOneFramework"])
)
