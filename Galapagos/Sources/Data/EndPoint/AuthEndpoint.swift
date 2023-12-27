//
//  AuthEndpoint.swift
//  Galapagos
//
//  Created by Siri on 12/27/23.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation

enum AuthEndpoint: Endpoint {
	
	case sendEmailCode(body: SendEmailCodeBody)
	case verifyEmailCode(body: VerifyEmailCodeBody)
	case signUp(body: SignUpBody)
	case signIn(body: SignInBody)
	case social(query: SocialQuery)
	
	
	var baseURL: URL? {
		return URL(string: Xcconfig.BASE_URL)
	}
	
	var method: HTTPMethod {
		return .POST
	}
	
	var headers: HTTPHeaders {
		return [
			"Content-Type": "application/json"
		]
	}
	
	var path: String {
		switch self {
		case .sendEmailCode:
			return "/email/send-code"
		case .verifyEmailCode:
			return "/email/confirm"
		case .signUp:
			return "/users/signup"
		case .signIn:
			return "/users/email-login"
		case .social(let query):
			return "/users/auth/\(query.provider)/login"
		}
		
	}
	
	var parameters: HTTPRequestParameterType? {
		switch self {
		case .sendEmailCode(let body):
			return .body(body)
		case .verifyEmailCode(let body):
			return .body(body)
		case .signUp(let body):
			return .body(body)
		case .signIn(let body):
			return .body(body)
		case .social(let query):
			return .query([
				"accessToken": query.accessToken,
				"deviceToken": query.deviceToken
			])
		}
	}
	
	
}
