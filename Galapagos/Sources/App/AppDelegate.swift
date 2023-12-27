//
//  AppDelegate.swift
//  Galapagos
//
//  Created by 조용인 on 2023/05/23.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation
import GoogleSignIn
import UIKit
import XCGLogger

let logger = XCGLogger.default

@main
class AppDelegate: UIResponder, UIApplicationDelegate{
  var window: UIWindow?
  var appCoordinator: AppCoordinator?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
		
		// MARK: - logger 초기 세팅 (너무 low한 레벨은 가져오지 말자)
		logger.setup(
			level: .verbose,
			showFileNames: true,
			showLineNumbers: true,
			writeToFile: nil,
			fileLevel: .verbose
		)
		
    return true
  }
  
  func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey: Any] = [:]
  ) -> Bool {
    var handled: Bool

      handled = GIDSignIn.sharedInstance.handle(url)
      if handled {
        return true
      }
      return false
  }
  
}
