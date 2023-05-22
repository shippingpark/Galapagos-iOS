import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

/*
                +-------------+
                |             |
                |     App     | Contains BMPGalapagos App target and BMPGalapagos unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project


protocol ProjectProfile {
    var projectName: String { get }
    var dependencies: [TargetDependency] { get }
    
    func generateTarget() -> [Target]
    func generateConfigurations() -> Settings
}

class BaseProjectProfile: ProjectProfile{
    let projectName: String = "Galapagos"
    
    let dependencies: [TargetDependency] = [
        .external(name: "RxSwift"),
        .external(name: "RxCocoa"),
        .external(name: "RxRelay"),
        .external(name: "RxGesture"),
        .external(name: "SnapKit"),
        .external(name: "Then"),
        .external(name: "KeychainSwift"),
    ]
    
    func generateConfigurations() -> Settings {
        return Settings.settings(configurations: [
//            .debug(name: "Debug", xcconfig: .relativeToRoot("\(projectName)/Sources/Config/Debug.xcconfig")),
//            .release(name: "Release", xcconfig: .relativeToRoot("\(projectName)/Sources/Config/Release.xcconfig")),
        ])
    }
    
    func generateTarget() -> [Target] {
        [
            Target(
                name: projectName,
                platform: .iOS,
                product: .app,
                bundleId: "com.busyModernPeople.\(projectName)",
                deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
                infoPlist: .default,
                sources: ["\(projectName)/Sources/**"],
                resources: "\(projectName)/Resources/**",
                
//                entitlements: "\(projectName).entitlements",
//                scripts: [
//                    .pre(path: "Scripts/SwiftLintRunScript.sh", arguments: [], name: "SwiftLint"),
//                    .pre(path: "Scripts/UpdatePackageRunScript.sh", arguments: [], name: "OpenSource")
//                ],
                dependencies: dependencies
            )
        ]
    }
    
}

let profile = BaseProjectProfile()

let project: Project = .init(
    name: profile.projectName,
    organizationName: "com.busyModernPeople",
//    settings: profile.generateConfigurations(),
    targets: profile.generateTarget()
)


