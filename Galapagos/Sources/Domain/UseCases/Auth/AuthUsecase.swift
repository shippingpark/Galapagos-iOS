//
//  AuthUsecase.swift
//  Galapagos
//
//  Created by Siri on 12/27/23.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation
import RxSwift

protocol AuthUsecase {
	func sendEmailCode(body: SendEmailCodeBody) -> Single<SendEmailCodeModel>
	func verifyEmailCode(body: VerifyEmailCodeBody) -> Single<VerifyEmailCodeModel>
	func signUp(body: SignUpBody) -> Single<SignUpModel>
	func signIn(body: SignInBody) -> Single<SignInModel>
	func social(query: SocialQuery) -> Single<SocialModel>
}
