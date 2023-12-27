//
//  SocialQuery.swift
//  Galapagos
//
//  Created by Siri on 12/27/23.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation

struct SocialQuery: Codable {
	let accessToken: String
	let deviceToken: String
	let provider: String
}
