//
//  CertifyEmailViewModel.swift
//  Galapagos
//
//  Created by Siri on 2023/10/02.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation
import UIKit

import RxSwift

final class CertifyEmailViewModel: ViewModelType {
	
	struct Input {
		let email: Observable<String>
		let sendCodeButtonTapped: Observable<Void>
	}
	
	struct Output {
		let receivedMessage: Observable<String>
	}
	
	var disposeBag: DisposeBag = DisposeBag()
	private let authUsecase: AuthUsecase
	
	init(authUsecase: AuthUsecase) {
		self.authUsecase = authUsecase
	}
	
	
	func transform(input: Input) -> Output {
		
		let receivedMessage = input.sendCodeButtonTapped
			.withLatestFrom(input.email)
			.withUnretained(self)
			.flatMapLatest{ owner, email -> Observable<String> in
				let body = SendEmailCodeBody(email: email)
				return owner.authUsecase.sendEmailCode(body: body)
					.map { $0.message }
					.asObservable()
			}
		
		return Output(
			receivedMessage: receivedMessage
		)
	}
	
}
