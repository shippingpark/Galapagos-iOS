//
//  AuthRepository.swift
//  Galapagos
//
//  Created by Siri on 12/27/23.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation
import RxSwift

protocol AuthRepository {
	func sendEmailCode(body: SendEmailCodeBody) -> Single<SendEmailCodeDTO>
	func verifyEmailCode(body: VerifyEmailCodeBody) -> Single<VerifyEmailCodeDTO>
	func signUp(body: SignUpBody) -> Single<SignUpDTO>
	func signIn(body: SignInBody) -> Single<SignInDTO>
	func social(query: SocialQuery) -> Single<SocialDTO>
}
