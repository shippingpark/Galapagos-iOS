//
//  VerifyEmailCodeBody.swift
//  Galapagos
//
//  Created by Siri on 2023/10/04.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation

struct VerifyEmailCodeBody: Codable {
	let email: String
	let code: String
}
