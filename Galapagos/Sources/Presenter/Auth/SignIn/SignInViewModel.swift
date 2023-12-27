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
			.withUnretained(self)
			.flatMapLatest { owner, data -> Single<SignInModel> in
				let (email, password) = data
				let body = SignInBody(email: email, password: password)
				return owner.authUsecase.signIn(body: body)
			}
			.asSingle()
			.observe(on: MainScheduler.instance)
			.subscribe(onSuccess: { [weak self] model in
				UserDefaultManager.shared.save(model.jwt, for: .jwt)
				UserDefaultManager.shared.save(model.nickName, for: .nickname)
				self?.coordinator?.finish()
			}, onFailure: { error in
				// 여기서 사용자에게 로그인 실패를 알림
			})
			.disposed(by: disposeBag)
		
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
