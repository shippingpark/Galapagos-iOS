//
//  DefaultAuthUsecase.swift
//  Galapagos
//
//  Created by Siri on 12/27/23.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation
import RxSwift

final class DefaultAuthUsecase: AuthUsecase {
	
	private let authRepository: AuthRepository
	
	init(authRepository: AuthRepository) {
		self.authRepository = authRepository
	}
	
	func sendEmailCode(body: SendEmailCodeBody) -> Single<SendEmailCodeModel> {
		return authRepository.sendEmailCode(body: body)
			.map { dto in
				return dto.toDomain()
			}
	}
	
	func verifyEmailCode(body: VerifyEmailCodeBody) -> Single<VerifyEmailCodeModel> {
		return authRepository.verifyEmailCode(body: body)
			.map { dto in
				return dto.toDomain()
			}
	}
	
	func signUp(body: SignUpBody) -> Single<SignUpModel> {
		return authRepository.signUp(body: body)
			.map { dto in
				return dto.toDomain()
			}
	}
	
	func signIn(body: SignInBody) -> Single<SignInModel> {
		return authRepository.signIn(body: body)
			.map { dto in
				return dto.toDomain()
			}
	}
	
	func social(query: SocialQuery) -> Single<SocialModel> {
		return authRepository.social(query: query)
			.map { dto in
				return dto.toDomain()
			}
	}
	
}
