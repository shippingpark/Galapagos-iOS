//
//  AppCoordinator.swift
//  Galapagos
//
//  Created by 조용인 on 2023/05/24.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit


class AppCoordinator: Coordinator {
    
    var childCoordinatorType: Any
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var delegate: CoordinatorDelegate?
    
    init(
        navigationController: UINavigationController,
        childCoordinatorType: AppCoordinatorChild
    ) {
        self.navigationController = navigationController
        self.childCoordinatorType = childCoordinatorType
    }
    
    func start() {
        let splashViewController = SplashViewController(
            viewModel: SplashViewModel(
                /// 여기에 나중에는 useCase도 추가 되어야겠지
                coordinator: self
            )
        ) /// 나중에, viewModel, useCase등등 추가적인 의존성 주입 필요함
        self.pushViewController(viewController: splashViewController)
    }
    
    func moveToNextViewController(to childType: Any) {
        let appCoordinatorchild = childType as! AppCoordinatorChild
        switch appCoordinatorchild{
        case .Auth:
            let authCoordinator = AuthCoordinator(
                navigationController: self.navigationController,
                childCoordinatorType: .SignUp
            )
            authCoordinator.delegate = self
            authCoordinator.start()
        case .TabBar:
            let tabBarCoordinator = TabBarCoordinator(
                navigationController: self.navigationController,
                childCoordinatorType: .Main
            )
            tabBarCoordinator.delegate = self
            tabBarCoordinator.start()
        }
    }
    
}

extension AppCoordinator: CoordinatorDelegate{
    func didFinish(childCoordinator: Coordinator) {
        self.moveToNextViewController(to: self.childCoordinatorType)
        childCoordinator.finish()
    }
}
