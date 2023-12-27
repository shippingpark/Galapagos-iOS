//
//  AuthViewModel.swift
//  Galapagos
//
//  Created by 조용인 on 2023/06/07.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//
import Foundation

import RxCocoa
import RxSwift

class AuthViewModel: ViewModelType{
	
	struct Input {
		let emailSignUpBtnTapped: Observable<Void>
		let emailSignInBtnTapped: Observable<Void>
		let googleSignInBtnTapped: Observable<Void>
		
		
	}
	
	struct Output {}
	
	var disposeBag: DisposeBag = DisposeBag()
	
	weak var coordinator: AuthCoordinator?
	
	init(
		coordinator: AuthCoordinator
	) {
		self.coordinator = coordinator
	}
	
	
	func transform(input: Input) -> Output {
		input.emailSignUpBtnTapped
			.withUnretained(self)
			.subscribe(onNext: { owner, _ in
				owner.coordinator?.destination.accept(.signUp)
			}).disposed(by: disposeBag)
		
		input.emailSignInBtnTapped
			.withUnretained(self)
			.subscribe(onNext: { owner, _ in
				owner.coordinator?.destination.accept(.signIn)
			}).disposed(by: disposeBag)
		
		return Output()
	}
	
}
