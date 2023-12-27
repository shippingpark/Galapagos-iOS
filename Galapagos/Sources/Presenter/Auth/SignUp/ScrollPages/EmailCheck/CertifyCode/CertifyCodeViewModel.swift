//
//  CertifyCodeViewModel.swift
//  Galapagos
//
//  Created by Siri on 2023/10/02.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation
import UIKit

import RxCocoa
import RxSwift


final class CertifyCodeViewModel: ViewModelType {
	
	struct Input {
		let certifyCode: Observable<String>
		let email: Observable<String>
		let sendCertifyCodeTapped: Observable<Void>
		let reSendEmailTapped: Observable<Void>
	}
	
	struct Output {
		let receivedMessage: Observable<String>
		let resendEmailMessage: Observable<String>
		let resultOfCertify: Observable<Bool>
	}
	
	var disposeBag: DisposeBag = DisposeBag()
	private let authUsecase: AuthUsecase
	
	init(authUsecase: AuthUsecase) {
		self.authUsecase = authUsecase
	}
	
	
	func transform(input: Input) -> Output {
		let certifyResult = BehaviorRelay<Bool>(value: false)
		
		let certifyMessage = input.sendCertifyCodeTapped
			.withLatestFrom(Observable.combineLatest(input.email, input.certifyCode))
			.flatMap { [weak self] email, code -> Single<String> in
				guard let self = self else { return .just("Error") }
				let body = VerifyEmailCodeBody(email: email, code: code)
				return self.authUsecase.verifyEmailCode(body: body)
					.do(onSuccess: { resultModel in
						certifyResult.accept(true)
					}, onError: { error in
						certifyResult.accept(false)
					})
					.map { $0.message }
					.catch { error in
						return Single.just("\(error.localizedDescription)")
					}
			}
			.share()
			.asObservable()
		
		let resendEmailMessage = input.reSendEmailTapped
			.withLatestFrom(input.email)
			.flatMapLatest { [weak self] email -> Observable<String> in
				guard let self = self else { return .empty() }
				let body = SendEmailCodeBody(email: email)
				return self.authUsecase.sendEmailCode(body: body)
					.map { $0.message }
					.catch { error in
						return Single.just("\(error.localizedDescription)")
					}
					.asObservable()
			}
		
		return Output(
			receivedMessage: certifyMessage,
			resendEmailMessage: resendEmailMessage,
			resultOfCertify: certifyResult.asObservable()
		)
	}
	
	
}
