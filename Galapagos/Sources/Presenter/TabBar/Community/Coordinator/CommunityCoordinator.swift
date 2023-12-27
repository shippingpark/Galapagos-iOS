//
//  CommunityCoordinator.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/11.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import RxRelay
import RxSwift
import UIKit

class CommunityCoordinator: CoordinatorType {
  
  // MARK: - Coordinator DEPTH 2 -
	
	enum CommunityCoordinatorFlow {
		case free
		case qna
		case notification
	}
	
	var childCoordinators: [CoordinatorType] = []
	var delegate: CoordinatorDelegate?
	var baseViewController: UIViewController?
	
	var navigationController: UINavigationController
	var parentsCoordinator: TabBarCoordinator
	var disposeBag: DisposeBag = DisposeBag()
	
	var destination = PublishRelay<CommunityCoordinatorFlow>()
	
  init(
		navigationController: UINavigationController,
		parentsCoordinator: TabBarCoordinator
	) {
    self.navigationController = navigationController
		self.parentsCoordinator = parentsCoordinator
  }
  
  func setState() {
		self.destination
			.withUnretained(self)
			.subscribe(onNext: { owner, state in
				guard let tabBarViewController = owner.navigationController.tabBarController as? TabBarViewController else { return }
				tabBarViewController.hideCustomTabBar()
				switch state {
				case .free:
					owner.pushToFree()
				case .qna:
					owner.pushToQnA()
				case .notification:
					owner.pushToNotification()
				}
			}).disposed(by: disposeBag)
  }
  
  func start() {
		let communityViewController = CommunityViewController(
			viewModel: CommunityViewModel(
				coordinator: self
			)
		)
		self.pushViewController(viewController: communityViewController, animated: false)
		self.baseViewController = communityViewController
	}
}

// MARK: - Private Method
extension CommunityCoordinator {
	fileprivate func pushToFree() {
		let communityFreeCoordinator = CommunityFreeCoordinator(
			navigationController: self.navigationController
		)
		communityFreeCoordinator.delegate = self
		communityFreeCoordinator.start()
		self.childCoordinators.append(communityFreeCoordinator)
	}
	
	fileprivate func pushToQnA() {
		let communityQnACoordinator = CommunityQnACoordinator(
			navigationController: self.navigationController
		)
		communityQnACoordinator.delegate = self
		communityQnACoordinator.start()
		self.childCoordinators.append(communityQnACoordinator)
	}
	
	fileprivate func pushToNotification() {
		let communityNotificationCoordinator = CommunityNotificationCoordinator(
			navigationController: self.navigationController
		)
		communityNotificationCoordinator.delegate = self
		communityNotificationCoordinator.start()
		self.childCoordinators.append(communityNotificationCoordinator)
	}
	
	
}

extension CommunityCoordinator: CoordinatorDelegate {
	func didFinish(childCoordinator: CoordinatorType) { // 복귀 시 탭바 재생성
		guard let tabBarViewController = self.navigationController.tabBarController as? TabBarViewController else { return }
		tabBarViewController.showCustomTabBar()
		self.popToRootViewController(animated: true)
	}
}
