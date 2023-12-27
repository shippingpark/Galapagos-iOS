//
//  SocialDTO.swift
//  Galapagos
//
//  Created by Siri on 12/27/23.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation

struct SocialDTO: Codable {
	let email: String?
	let nickname: String?
	let jwt: String?
	
	func toDomain() -> SocialModel {
		return SocialModel(
			email: email,
			nickname: nickname,
			jwt: jwt
		)
	}
	
}
