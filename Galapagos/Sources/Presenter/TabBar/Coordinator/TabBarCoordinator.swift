//
//  TabBarCoordinator.swift
//  Galapagos
//
//  Created by 조용인 on 2023/05/26.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit

import RxRelay
import RxSwift


final class TabBarCoordinator: CoordinatorType {
  
  // MARK: - Coordinator DEPTH 1 -
  
	private let tabBarController = TabBarViewController()	// 베이스로 들고다닐 TabBarViewController
	
  var childCoordinators: [CoordinatorType] = []
	var delegate: CoordinatorDelegate?
	var baseViewController: UIViewController?
	
	var navigationController: UINavigationController
  var disposeBag: DisposeBag = DisposeBag()
	
	var destination = PublishRelay<TabBarCoordinatorFlow>()
	
  init(
		navigationController: UINavigationController
	) {
    self.navigationController = navigationController
    self.setState()
  }
  
  func setState() {
		
		self.tabBarController.tabBarItemSubject
			.withUnretained(self)
			.subscribe(onNext: { owner, idx in
				let tabBarItem = TabBarCoordinatorFlow(rawValue: idx) ?? .main
				owner.destination.accept(tabBarItem)
			})
			.disposed(by: disposeBag)
		
    self.destination
      .distinctUntilChanged() // 이전 상태와 동일한 상태는 무시
			.withUnretained(self)
      .subscribe(onNext: { owner, state in
        owner.tabBarController.selectedIndex = state.rawValue
      }).disposed(by: disposeBag)
  }
  
	// MARK: - TabBarCoordinator의 Start는, 기존의 VC를 push 해주기 전에 TabBarItem별 VC를 세팅하는 작업
  func start() {
    let pages: [TabBarCoordinatorFlow] = TabBarCoordinatorFlow.allCases
    let controllers: [UINavigationController] = pages.map { flow in
      self.createTabNavigationController(of: flow)
    }
    self.configureTabBarController(with: controllers)
  }
  
}


// MARK: - Extension

private extension TabBarCoordinator {
  
  func createTabNavigationController(of page: TabBarCoordinatorFlow) -> UINavigationController {
    let navigationController = UINavigationController()
    navigationController.setNavigationBarHidden(true, animated: false)
    connectTabCoordinator(of: page, to: navigationController)
    return navigationController
  }
  
  func connectTabCoordinator(of page: TabBarCoordinatorFlow, to navigationController: UINavigationController) {
    switch page {
    case .main:
      let mainCoordinator = MainCoordinator(
				navigationController: navigationController,
				parentsCoordinator: self
			)
      mainCoordinator.delegate = self
      mainCoordinator.start()
      childCoordinators.append(mainCoordinator)
    case .diaryList:
      let diaryCoordinator = DiaryListCoordinator(
				navigationController: navigationController,
				parentsCoordinator: self
			)
      diaryCoordinator.delegate = self
      diaryCoordinator.start()
      childCoordinators.append(diaryCoordinator)
    case .community:
      let communityCoordinator = CommunityCoordinator(
				navigationController: navigationController,
				parentsCoordinator: self
			)
      communityCoordinator.delegate = self
      communityCoordinator.start()
      childCoordinators.append(communityCoordinator)
    case .mypage:
      let mypageCoordinator = MyPageCoordinator(
				navigationController: navigationController,
				parentsCoordinator: self
			)
      mypageCoordinator.delegate = self
      mypageCoordinator.start()
      childCoordinators.append(mypageCoordinator)
    }
  }
	
	private func configureTabBarController(with tabViewControllers: [UIViewController]) {
		self.tabBarController.setViewControllers(tabViewControllers, animated: true)
		self.navigationController.setNavigationBarHidden(true, animated: false)
		self.navigationController.viewControllers = [tabBarController]
	}
}


// MARK: - CoordinatorDelegate

extension TabBarCoordinator: CoordinatorDelegate {
  func didFinish(childCoordinator: CoordinatorType) {
    self.popViewController(animated: true)
    self.finish()
  }
}
