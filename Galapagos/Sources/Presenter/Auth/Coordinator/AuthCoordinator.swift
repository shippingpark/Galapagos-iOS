//
//  AuthCoordinator.swift
//  Galapagos
//
//  Created by 조용인 on 2023/05/26.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class AuthCoordinator: CoordinatorType {
	// MARK: - Navigation DEPTH 1 -
	enum AuthCoordinatorChild{
		case signUp
		case signIn
	}
	
	var childCoordinators: [CoordinatorType] = []
	var delegate: CoordinatorDelegate?
	var baseViewController: UIViewController?
	
	var disposeBag: DisposeBag
	var navigationController: UINavigationController
	
	var destination = PublishRelay<AuthCoordinatorChild>()
	
	init(
		navigationController: UINavigationController
	){
		self.navigationController = navigationController
		self.disposeBag = DisposeBag()
		self.setState()
	}
	
	func setState() {
		self.destination
			.subscribe(onNext: { [weak self] state in
				guard let self = self else {return}
				switch state{
				case .signUp:
					GalapagosIndecatorManager.shared.show()
					self.popToRootViewController(animated: true)
					let signUpViewController = SignUpViewController(
						viewModel: SignUpViewModel(
							coordinator: self,
							authUsecase: DefaultAuthUsecase(
								authRepository: DefaultAuthRepository()
							)
						)
					)
					self.pushViewController(viewController: signUpViewController, animated: true)
				case .signIn:
					GalapagosIndecatorManager.shared.show()
					self.popToRootViewController(animated: true)
					let signInViewController = SignInViewController(
						viewModel: SignInViewModel(
							coordinator: self,
							authUsecase: DefaultAuthUsecase(
								authRepository: DefaultAuthRepository()
							)
						)
					)
					self.pushViewController(viewController: signInViewController, animated: true)
				}
			}).disposed(by: disposeBag)
	}
	
	func start() {
		let authViewController = AuthViewController(
			viewModel: AuthViewModel(
				coordinator: self
			)
		)
		self.baseViewController = authViewController
		self.pushViewController(viewController: authViewController, animated: false)
	}
	
}
