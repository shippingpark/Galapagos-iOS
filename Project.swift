import ProjectDescription
import Foundation
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
	case SiriUIKit
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
	
	let infoPlist: [String: Plist.Value] = [
		"Base_Url" : "$(BASE_URL)",
		"ITSAppUsesNonExemptEncryption": false,
		"CFBundleShortVersionString": "1.0",
		"CFBundleVersion": "1",
		"CFBundleDevelopmentRegion": "ko_KR",
		"UILaunchStoryboardName": "LaunchScreen",
		"UIUserInterfaceStyle": "Light",
		"UIApplicationSceneManifest": [
				"UIApplicationSupportsMultipleScenes": false,
				"UISceneConfigurations": [
						"UIWindowSceneSessionRoleApplication": [
								[
										"UISceneConfigurationName": "Default Configuration",
										"UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
								],
						]
				]
		],
		"CFBundleIconName": "AppIcon",
		"UIAppFonts": [
			"Item 0": "Pretendard-Medium.otf",
			"Item 1": "Pretendard-Regular.otf",
			"Item 2": "Pretendard-SemiBold.otf",
			"Item 3": "Pretendard-Bold.otf"
		],
		"GIDClientID": "785218990545-f6eh18bsp2ej759a7etufpohr86vpju5.apps.googleusercontent.com",
		"CFBundleURLTypes": [
			[
				"CFBundleURLSchemes": ["com.googleusercontent.apps.785218990545-f6eh18bsp2ej759a7etufpohr86vpju5"],
				"CFBundleURLName": "com.busyModernPeople.Galapagos"
			]
		],
		"NSAppTransportSecurity": [
			"NSAllowsArbitraryLoads": true
		]
	]
	
	func generateDependencies(targetName target: TargetType) -> [TargetDependency] {
		switch target{
		case .App:
			return commonDependencies() + [
				.target(name: "SiriUIKit")
			]
		case .SiriUIKit:
			return commonDependencies()
		}
	}
	
	func generateAppConfigurations() -> Settings {
		return Settings.settings(
//			base: [
//				"OTHER_LDFLAGS": "-ObjC",
//				"HEADER_SEARCH_PATHS": [
//                    "$(inherited) $(SRCROOT)/Tuist/Dependencies/SwiftPackageManager/.build/checkouts/GoogleSignIn/Sources/Public $(SRCROOT)/Tuist/Dependencies/SwiftPackageManager/.build/checkouts/AppAuth-iOS/Source/AppAuth $(SRCROOT)/Tuist/Dependencies/SwiftPackageManager/.build/checkouts/AppAuth-iOS/Source/AppAuthCore $(SRCROOT)/Tuist/Dependencies/SwiftPackageManager/.build/checkouts/gtm-session-fetcher/Sources/Core/Public $(SRCROOT)/Tuist/Dependencies/SwiftPackageManager/.build/checkouts/GoogleSignIn/Sources/../../ $(SRCROOT)/Tuist/Dependencies/SwiftPackageManager/.build/checkouts/GTMAppAuth/GTMAppAuth/Sources/Public/GTMAppAuth"]
//			],
			configurations: [
				.debug(name: "Dev", xcconfig: .relativeToCurrentFile("Galapagos/Resources/Configure/DEV.xcconfig")),
				.release(name: "Release", xcconfig: .relativeToCurrentFile("Galapagos/Resources/Configure/Release.xcconfig")),
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
				scripts: [
					.pre(
						script: """
							ROOT_DIR=\(ProcessInfo.processInfo.environment["TUIST_ROOT_DIR"] ?? "")
							
							${ROOT_DIR}/swiftlint --config ${ROOT_DIR}/.swiftlint.yml
							
							""",
						name: "SwiftLint",
						basedOnDependencyAnalysis: false
					)
				],
				dependencies: [
					.target(name: "SiriUIKit")
				],
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
				scripts: [
					.pre(
						script: """
							ROOT_DIR=\(ProcessInfo.processInfo.environment["TUIST_ROOT_DIR"] ?? "")
							
							${ROOT_DIR}/swiftlint --config ${ROOT_DIR}/.swiftlint.yml
							
							""",
						name: "SwiftLint",
						basedOnDependencyAnalysis: false
					)
				],
				dependencies: generateDependencies(targetName: .SiriUIKit)
			)
		]
	}
	
}

let profile = BaseProjectProfile()


let project: Project = .init(
	name: profile.projectName,
	organizationName: "com.busyModernPeople",
	packages: [
		.remote(
			url: "https://github.com/ReactiveX/RxSwift",
			requirement: .upToNextMajor(from: "6.5.0")),
		.remote(
			url: "https://github.com/RxSwiftCommunity/RxGesture",
			requirement: .upToNextMajor(from: "4.0.0")),
		.remote(
			url: "https://github.com/SnapKit/SnapKit",
			requirement: .upToNextMajor(from: "5.0.0")),
		.remote(
			url: "https://github.com/google/GoogleSignIn-iOS",
			requirement: .upToNextMajor(from: "7.0.0")),
		.remote(
			url: "https://github.com/DaveWoodCom/XCGLogger.git",
			requirement: .upToNextMajor(from: "7.0.0"))

	],
	settings: .settings(configurations: [
		.debug(name: "Dev"),
		.release(name: "Release")
	]),
	targets: profile.generateTarget()
)

extension BaseProjectProfile {
	fileprivate func commonDependencies() -> [TargetDependency] {
		return [
			.package(product: "RxSwift",
							 type: .runtime),
			.package(product: "RxCocoa",
							 type: .runtime),
			.package(product: "RxRelay",
							 type: .runtime),
			.package(product: "RxGesture",
							 type: .runtime),
			.package(product: "SnapKit",
							 type: .runtime),
			.package(product: "GoogleSignIn",
							 type: .runtime),
			.package(product: "XCGLogger",
							 type: .runtime)
		]
	}
}
