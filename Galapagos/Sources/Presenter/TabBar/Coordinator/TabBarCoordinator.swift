//
//  TabBarCoordinator.swift
//  Galapagos
//
//  Created by 조용인 on 2023/05/26.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa

class TabBarCoordinator: Coordinator {
    //MARK: - Navigation DEPTH 1 -
    enum TabBarCoordinatorChild{
        case Main, Diary, Communicate, Mypage
    }
    
    //MARK: - Need To Initializing
    var disposeBag: DisposeBag
    var userActionState: BehaviorRelay<TabBarCoordinatorChild>/// init에서만 호출하고, stream을 유지하기위해 BehaviorSubject 사용
    var navigationController: UINavigationController
    
    //MARK: - Don't Need To Initializing
    var childCoordinators: [Coordinator] = []
    var delegate: CoordinatorDelegate?
    
    init(
        navigationController: UINavigationController,
        userActionState: TabBarCoordinatorChild
    ){
        self.navigationController = navigationController
        self.userActionState = BehaviorRelay(value: userActionState)
        self.disposeBag = DisposeBag()
    }
    
    func setState() {
        //
    }
    
    func start() {
        //
    }
    
    
}

