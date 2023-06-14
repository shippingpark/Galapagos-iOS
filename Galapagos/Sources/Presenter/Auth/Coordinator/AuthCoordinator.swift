//
//  AuthCoordinator.swift
//  Galapagos
//
//  Created by 조용인 on 2023/05/26.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AuthCoordinator: Coordinator {
  //MARK: - Navigation DEPTH 1 -
  enum AuthCoordinatorChild{
    case SignIn, EmailSignUp, EmailSignIn
    /// SignIn이 AuthHome의 역할
  }
  
  //MARK: - Need To Initializing
  var disposeBag: DisposeBag
  var userActionState: BehaviorRelay<AuthCoordinatorChild>/// init에서만 호출하고, stream을 유지하기위해 BehaviorSubject 사용
  var navigationController: UINavigationController
  
  //MARK: - Don't Need To Initializing
  var childCoordinators: [Coordinator] = []
  var delegate: CoordinatorDelegate?
  
  init(
    navigationController: UINavigationController,
    userActionState: AuthCoordinatorChild
  ){
    self.navigationController = navigationController
    self.userActionState = BehaviorRelay(value: userActionState)
    self.disposeBag = DisposeBag()
    
  }
  
  func setState() {
    //
  }
  
  func start() {
    self.userActionState
      .debug()
      .subscribe(onNext: { [weak self] state in
        guard let self = self else {return}
        switch state{
        case .SignIn:
          let signInViewController = SignInViewController(
            viewModel: SignInViewModel(
              /// 여기에 나중에는 useCase도 추가 되어야겠지
              coordinator: self
            )
          )
          self.pushViewController(viewController: signInViewController)
        case .EmailSignUp:
          let emailSignUpViewController = EmailSignUpViewController(
            viewModel: EmailSignUpViewModel(
              /// 여기에 나중에는 useCase도 추가 되어야겠지
              coordinator: self
            )
          )
          self.pushViewController(viewController: emailSignUpViewController)
        case .EmailSignIn:
          let emailSignInViewController = EmailSignInViewController(
            viewModel: EmailSignInViewModel(
              /// 여기에 나중에는 useCase도 추가 되어야겠지
              coordinator: self
            )
          )
          self.pushViewController(viewController: emailSignInViewController)
        }
        
      }).disposed(by: disposeBag)
  }
  
  
}
