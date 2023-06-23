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


enum TargetType {
    case DesignSystem
    case App
}

protocol ProjectProfile {
    var projectName: String { get }
    
    func generateDependencies(targetName target: TargetType) -> [TargetDependency]
    func generateTarget() -> [Target]
    func generateAppConfigurations() -> Settings
}

class BaseProjectProfile: ProjectProfile{
    
    let projectName: String = "Galapagos"
    
    
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
    
    func generateDependencies(targetName target: TargetType) -> [TargetDependency] {
        switch target{
        case .App:
            return [
                .external(name: "RxSwift"),
                .external(name: "RxCocoa"),
                .external(name: "RxRelay"),
                .external(name: "RxGesture"),
                .external(name: "SnapKit"),
                .external(name: "Then"),
                .external(name: "KeychainSwift"),
                .target(name: "SiriUIKit")
            ]
        case .DesignSystem:
            return [
                .external(name: "RxSwift"),
                .external(name: "RxCocoa"),
                .external(name: "RxRelay"),
                .external(name: "RxGesture"),
                .external(name: "SnapKit"),
                .external(name: "Then"),
                .external(name: "KeychainSwift"),
            ]
        }
    }
    
    func generateAppConfigurations() -> Settings {
        return Settings.settings(configurations: [
            .debug(name: "DEV", xcconfig: .relativeToCurrentFile("Galapagos/Sources/Configure/DEV.xcconfig")),
            .release(name: "Release", xcconfig: .relativeToCurrentFile("Galapagos/Sources/Configure/Release.xcconfig")),
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
                dependencies: generateDependencies(targetName: .App),
                settings: generateAppConfigurations()
            ),
            Target(
                name: "SiriUIKit",
                platform: .iOS,
                product: .framework,
                bundleId: "com.busyModernPeople.\(projectName).SiriUIKit",
                deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
                infoPlist: .default,
                sources: ["SiriUIKit/Sources/**"],
                resources: "\(projectName)/Resources/**",
                dependencies: generateDependencies(targetName: .DesignSystem)
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


