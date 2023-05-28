//
//  AuthCoordinator.swift
//  Galapagos
//
//  Created by 조용인 on 2023/05/26.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit
import RxSwift

class AuthCoordinator: Coordinator {
    //MARK: - Navigation DEPTH 1 -
    enum AuthCoordinatorChild{
        case SignIn, SignUp
    }
    
    //MARK: - Need To Initializing
    var disposeBag: DisposeBag
    var userActionState: BehaviorSubject<AuthCoordinatorChild>/// init에서만 호출하고, stream을 유지하기위해 BehaviorSubject 사용
    var navigationController: UINavigationController
    
    //MARK: - Don't Need To Initializing
    var childCoordinators: [Coordinator] = []
    var delegate: CoordinatorDelegate?
    
    init(
        navigationController: UINavigationController,
        userActionState: AuthCoordinatorChild
    ){
        self.navigationController = navigationController
        self.userActionState = BehaviorSubject(value: userActionState)
        self.disposeBag = DisposeBag()
    }
    
    func setState() {
        //
    }
    
    func start() {
        //
    }
    
    
}
