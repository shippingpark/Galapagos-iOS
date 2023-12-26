//
//  UserDefaultManager.swift
//  Galapagos
//
//  Created by Siri on 12/27/23.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation

class UserDefaultManager {
	
	static let shared = UserDefaultManager()
	private let userDefaults = UserDefaults.standard
	
	private init() {
		
	}
	
	/// 요기에는 내 맘대로 추가 해야징~
	enum Key: String {
		case accessToken
		case refreshToken
	}
	
	func save<T>(_ value: T, for key: Key) {
		userDefaults.set(value, forKey: key.rawValue)
	}
	
	func load<T>(for key: Key) -> T? {
		return userDefaults.object(forKey: key.rawValue) as? T
	}
	
	func delete(for key: Key) {
		userDefaults.removeObject(forKey: key.rawValue)
	}
	
}
