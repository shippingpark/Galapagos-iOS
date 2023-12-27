//
//  MypageCoordinator.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/11.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import RxRelay
import RxSwift
import UIKit

class MyPageCoordinator: CoordinatorType {
	
	enum MyPageCoordinatorFlow {
		case etc
	}
	
	var childCoordinators: [CoordinatorType] = []
	var delegate: CoordinatorDelegate?
	var baseViewController: UIViewController?
	
	var navigationController: UINavigationController
	var parentsCoordinator: TabBarCoordinator
	var disposeBag: DisposeBag = DisposeBag()
	
	var destination = PublishRelay<MyPageCoordinatorFlow>()
	
	init(
		navigationController: UINavigationController,
		parentsCoordinator: TabBarCoordinator
	) {
		self.navigationController = navigationController
		self.parentsCoordinator = parentsCoordinator
		self.setState()
	}
	
	func setState(){
		self.destination
			.withUnretained(self)
			.subscribe(onNext: { owner, state in
				guard let tabBarViewController = owner.navigationController.tabBarController as? TabBarViewController else { return }
				tabBarViewController.hideCustomTabBar()
				switch state {
				case .etc:
					break
					/*
					owner.pushToAddAnimal()
					 */
				}
			}).disposed(by: disposeBag)
	}
	
	func start() {
		/*
		let myPageViewController = MyPageViewController(
			viewModel: MyPageViewModel(
				coordinator: self
			)
		)
		self.pushViewController(viewController: myPageViewController, animated: true)
		self.baseViewController = myPageViewController
		 */
	}
		 
}

// MARK: Private Methods
extension MyPageCoordinator {
	/*
	fileprivate func pushToAddAnimal() {
		let addAnimalCoordinator = AddAnimalCoordinator(
			navigationController: self.navigationController
		)
		addAnimalCoordinator.delegate = self
		addAnimalCoordinator.start()
		self.childCoordinators.append(addAnimalCoordinator)
	}
	*/
}

extension MyPageCoordinator: CoordinatorDelegate {
	func didFinish(childCoordinator: CoordinatorType) { // 복귀 시 탭바 재생성
		guard let tabBarViewController = self.navigationController.tabBarController as? TabBarViewController else { return }
		tabBarViewController.showCustomTabBar()
		self.popToRootViewController(animated: true)
	}
}
