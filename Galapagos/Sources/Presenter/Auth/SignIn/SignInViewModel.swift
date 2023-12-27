//
//  SignInViewModel.swift
//  Galapagos
//
//  Created by 조용인 on 2023/06/11.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//
import Foundation

import RxCocoa
import RxSwift

class SignInViewModel: ViewModelType{
	
	struct Input {
		let email: Observable<String>
		let password: Observable<String>
		let backBtnTapped: Observable<Void>
		let resettingPasswordBtnTapped: Observable<Void>
		let signInBtnTapped: Observable<Void>
	}
	
	struct Output {
		let signInBtnEnable: Observable<Bool>
	}
	
	var disposeBag: DisposeBag = DisposeBag()
	weak var coordinator: AuthCoordinator?
	private let authUsecase: AuthUsecase
	
	init(
		coordinator: AuthCoordinator,
		authUsecase: AuthUsecase
	) {
		self.coordinator = coordinator
		self.authUsecase = authUsecase
	}
	
	
	func transform(input: Input) -> Output {
		let signInBtnEnable = Observable.combineLatest(input.email, input.password)
			.map { email, password in
				return !email.isEmpty && !password.isEmpty
			}
		
		input.signInBtnTapped
			.withLatestFrom(Observable.combineLatest(input.email, input.password))
			.flatMapLatest { [weak self] email, password -> Single<SignInModel> in
				guard let self = self else { return .empty() }
				let body = SignInBody(email: email, password: password)
				return self.authUsecase.signIn(body: body)
			}
//			.observe(on: MainScheduler.instance)
//			.subscribe(onNext: { [weak self] result in
//				switch result {
//				case .success(let model):
//					UserDefaultManager.shared.save(model.jwt, for: .jwt)
//					UserDefaultManager.shared.save(model.nickName, for: .nickName)
//					self?.coordinator?.finish()
//				case .failure(let error):
//					// 여기서 사용자에게 로그인 실패를 알림
//				}
//			})
//			.disposed(by: disposeBag)
		
		input.backBtnTapped
			.withUnretained(self)
			.observe(on: MainScheduler.instance)
			.subscribe(onNext: { owner, _ in
				owner.coordinator?.popViewController(animated: true)
			})
			.disposed(by: disposeBag)
		
		return Output(
			signInBtnEnable: signInBtnEnable
		)
	}
	
	
}
