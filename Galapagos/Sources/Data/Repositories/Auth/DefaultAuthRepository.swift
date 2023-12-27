//
//  DefaultAuthRepository.swift
//  Galapagos
//
//  Created by Siri on 2023/10/06.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation
import RxSwift

final class DefaultAuthRepository: AuthRepository {
	
	private let networkService: NetworkService
	
	init() {
		self.networkService = DefaultNetworkService()
	}
	
	func sendEmailCode(body: SendEmailCodeBody) -> Single<SendEmailCodeDTO> {
		let endpoint = AuthEndpoint.sendEmailCode(body: body)
		return networkService.request(endpoint)
			.flatMap { data in
				guard let dto = Utility.decode(SendEmailCodeDTO.self, from: data) else {
					return Single.error(NetworkError.decodingFailed)
				}
				return Single.just(dto)
			}
	}
	
	func verifyEmailCode(body: VerifyEmailCodeBody) -> Single<VerifyEmailCodeDTO> {
		let endpoint = AuthEndpoint.verifyEmailCode(body: body)
		return networkService.request(endpoint)
			.flatMap { data in
				guard let dto = Utility.decode(VerifyEmailCodeDTO.self, from: data) else {
					return Single.error(NetworkError.decodingFailed)
				}
				return Single.just(dto)
			}
	}
	
	func signUp(body: SignUpBody) -> Single<SignUpDTO> {
		let endpoint = AuthEndpoint.signUp(body: body)
		return networkService.request(endpoint)
			.flatMap { data in
				guard let dto = Utility.decode(SignUpDTO.self, from: data) else {
					return Single.error(NetworkError.decodingFailed)
				}
				return Single.just(dto)
			}
	}
	
	func signIn(body: SignInBody) -> Single<SignInDTO> {
		let endpoint = AuthEndpoint.signIn(body: body)
		return networkService.request(endpoint)
			.flatMap { data in
				guard let dto = Utility.decode(SignInDTO.self, from: data) else {
					return Single.error(NetworkError.decodingFailed)
				}
				return Single.just(dto)
			}
	}
	
	func social(query: SocialQuery) -> Single<SocialDTO> {
		let endpoint = AuthEndpoint.social(query: query)
		return networkService.request(endpoint)
			.flatMap { data in
				guard let dto = Utility.decode(SocialDTO.self, from: data) else {
					return Single.error(NetworkError.decodingFailed)
				}
				return Single.just(dto)
			}
	}
	
	
}
