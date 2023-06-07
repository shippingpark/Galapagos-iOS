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
    
    let infoPlist: [String: InfoPlist.Value] = [
        "CFBundleShortVersionString": "1.0",
        "CFBundleVersion": "1",
        "CFBundleDevelopmentRegion": "ko_KR",
        "UILaunchStoryboardName": "LaunchScreen",
        "UIUserInterfaceStyle": "Light",
        "UIAppFonts": [
            "Item 0": "Pretendard-Medium.otf",
            "Item 1": "Pretendard-Regular.otf",
            "Item 2": "Pretendard-SemiBold.otf",
            "Item 3": "Pretendard-Bold.otf"
        ]
    ]
    
    func generateConfigurations() -> Settings {
        return Settings.settings(configurations: [
            .debug(name: "Debug", xcconfig: .relativeToRoot("\(projectName)/Sources/Configure/Debug.xcconfig")),
            .release(name: "Release", xcconfig: .relativeToRoot("\(projectName)/Sources/Configure/Release.xcconfig")),
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
                infoPlist: .extendingDefault(with: infoPlist),
                sources: ["\(projectName)/Sources/**"],
                resources: "\(projectName)/Resources/**",
                
//                entitlements: "\(projectName).entitlements",
                dependencies: dependencies,
                settings: .settings(configurations: [
                    .debug(name: "DEV", xcconfig: .relativeToRoot("\(projectName)/Sources/Configure/DEV.xcconfig")),
                    .release(name: "Release", xcconfig: .relativeToRoot("\(projectName)/Sources/Configure/Release.xcconfig"))
                ])
            )
        ]
    }
    
}

let profile = BaseProjectProfile()

let project: Project = .init(
    name: profile.projectName,
    organizationName: "com.busyModernPeople",
    settings: .settings(configurations: [
        .debug(name: "DEV"),
        .release(name: .release)
    ]),
    targets: profile.generateTarget()
)


