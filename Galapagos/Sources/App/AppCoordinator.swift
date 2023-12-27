//
//  AppCoordinator.swift
//  Galapagos
//
//  Created by 조용인 on 2023/05/24.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class AppCoordinator: CoordinatorType {    

  // MARK: - Navigation DEPTH 0 -
  enum AppCoordinatorChild{
    case auth
    case tabBar
  }
  
  // MARK: - Need To Initializing
  var disposeBag: DisposeBag
  var navigationController: UINavigationController
  
  // MARK: - Don't Need To Initializing
  var childCoordinators: [CoordinatorType] = []
  var delegate: CoordinatorDelegate?
	var destination = PublishRelay<AppCoordinatorChild>()
	weak var baseViewController: UIViewController?
	
  init(
    navigationController: UINavigationController
  ) {
    self.navigationController = navigationController
    self.disposeBag = DisposeBag()
    self.setState()
  }
  
  func setState(){
    self.destination
			.withUnretained(self)
      .subscribe(onNext: { owner, state in
        switch state{
        case .auth:
					GalapagosIndecatorManager.shared.show()
          let authCoordinator = AuthCoordinator(
            navigationController: owner.navigationController
          )
          authCoordinator.delegate = owner
          authCoordinator.start()
          owner.childCoordinators.append(authCoordinator)
        case .tabBar:
					GalapagosIndecatorManager.shared.show()
          let tabBarCoordinator = TabBarCoordinator(
            navigationController: owner.navigationController
          )
          tabBarCoordinator.start()
					owner.childCoordinators.append(tabBarCoordinator)
        }
      }).disposed(by: disposeBag)
  }
  
  func start() {
    let splashViewController = SplashViewController(
      viewModel: SplashViewModel(
        coordinator: self
      )
    )
		self.baseViewController = splashViewController
		self.pushViewController(viewController: splashViewController, animated: false)
  }
}

extension AppCoordinator: CoordinatorDelegate{
  func didFinish(childCoordinator: CoordinatorType) {
		self.popToRootViewController(animated: true)
		self.childCoordinators.removeAll()
		if childCoordinator is AuthCoordinator {
			self.destination.accept(.tabBar)
		} else {
			self.destination.accept(.auth)
		}
  }
}
