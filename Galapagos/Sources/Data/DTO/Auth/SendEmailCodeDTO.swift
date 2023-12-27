//
//  SendEmailCodeDTO.swift
//  Galapagos
//
//  Created by Siri on 2023/10/04.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation


struct SendEmailCodeDTO: Codable {
	let message: String
	
	func toDomain() -> SendEmailCodeModel {
		return SendEmailCodeModel(message: message)
	}
}
