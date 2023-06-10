//
//  TabBarCoordinator.swift
//  Galapagos
//
//  Created by 조용인 on 2023/05/26.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//


import UIKit
import RxSwift
import RxRelay


class TabBarCoordinator: Coordinator {
    
    //MARK: - Need To Initializing
    var disposeBag: DisposeBag
    //userActionState 사용될 일이 없음
    var userActionState: BehaviorRelay<TabBarCoordinatorFlow> = BehaviorRelay(value: .main)
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    //MARK: - Don't Need To Initializing
    var childCoordinators: [Coordinator] = []
    var delegate: CoordinatorDelegate?
    
    init(
        navigationController: UINavigationController
    ){
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
        self.disposeBag = DisposeBag()
    }
    
    func setState() {
        //
    }
    
    func start() {
        let pages: [TabBarCoordinatorFlow] = TabBarCoordinatorFlow.allCases
        let controllers: [UINavigationController] = pages.map { flow in
            self.createTabNavigationController(of: flow)
        }
        self.configureTabBarController(with: controllers)
    }
}

//TabBar는 ViewModel이 없는 유일한 Coordinator, 기타 설정 위한 함수
private extension TabBarCoordinator {
    
    private func configureTabBarController(with tabViewControllers: [UIViewController]) {
        self.tabBarController.setViewControllers(tabViewControllers, animated: true)
        //임시
        self.tabBarController.view.backgroundColor = .darkGray
        self.tabBarController.tabBar.backgroundColor = .white
        self.tabBarController.tabBar.tintColor = .black
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(tabBarController, animated: true)
    }
    
    func createTabNavigationController(of page: TabBarCoordinatorFlow) -> UINavigationController {
        let tabNavigationController = UINavigationController()
        tabNavigationController.setNavigationBarHidden(true, animated: false)
        tabNavigationController.tabBarItem = page.tabBarItem
        connectTabCoordinator(of: page, to: tabNavigationController)
        return tabNavigationController
    }
    
    func connectTabCoordinator(of page: TabBarCoordinatorFlow, to tabNavigationController: UINavigationController) {
        switch page {
        case .main:
            let mainCoordinator = MainCoordinator(navigationController: tabNavigationController)
            mainCoordinator.start()
            childCoordinators.append(mainCoordinator)
        case .diary:
            let diaryCoordinator = DiaryCoordinator(navigationController: tabNavigationController)
            diaryCoordinator.start()
            childCoordinators.append(diaryCoordinator)
        case .community:
            let communityCoordinator = CommunityCoordinator(navigationController: tabNavigationController)
            communityCoordinator.start()
            childCoordinators.append(communityCoordinator)
        case .mypage:
            let mypageCoordinator = MyPageCoordinator(navigationController: tabNavigationController)
            mypageCoordinator.start()
            childCoordinators.append(mypageCoordinator)
        }
    }
}

