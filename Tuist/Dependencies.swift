//
//  Dependencies.swift
//  Config
//
//  Created by 조용인 on 2023/05/22.
//

import ProjectDescription

let spm = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/ReactiveX/RxSwift", requirement: .upToNextMajor(from: "6.6.0")),
    .remote(url: "https://github.com/RxSwiftCommunity/RxGesture", requirement: .upToNextMinor(from: "4.0.0")),
    .remote(url: "https://github.com/SnapKit/SnapKit", requirement: .upToNextMajor(from: "5.6.0")),
    .remote(url: "https://github.com/devxoul/Then", requirement: .upToNextMajor(from: "2.0.0")),
    .remote(url: "https://github.com/evgenyneu/keychain-swift", requirement: .upToNextMajor(from: "20.0.0")),
    .remote(url: "https://github.com/google/GoogleSignIn-iOS", requirement: .branch("main"))
    ],
    baseSettings: .settings(configurations: [
                .debug(name: "DEV"),
                .release(name: "Release")
]))

let dependencies = Dependencies(
    swiftPackageManager: spm,
    platforms: [.iOS]
)

