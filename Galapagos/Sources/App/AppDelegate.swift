//
//  AppDelegate.swift
//  Galapagos
//
//  Created by 조용인 on 2023/05/23.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate{
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = UINavigationController()
        
        appCoordinator = AppCoordinator(
            navigationController: navigationController
        )
        
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        appCoordinator?.start()
        
        return true
    }
    
}
