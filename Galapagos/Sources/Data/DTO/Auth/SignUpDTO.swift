//
//  SignUpDTO.swift
//  Galapagos
//
//  Created by Siri on 2023/10/10.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation

struct SignUpDTO: Codable {
	let userIdx: String
	let nickName: String
	let jwt: String
	
	func toDomain() -> SignUpModel {
		return SignUpModel(
			nickName: nickName,
			jwt: jwt
		)
	}
	
}
