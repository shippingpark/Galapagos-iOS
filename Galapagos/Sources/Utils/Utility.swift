//
//  Utility.swift
//  Galapagos
//
//  Created by Siri on 2023/10/04.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation

class Utility {
    
    /// - `data`를 `T` 타입으로 디코딩하자~
    static func decode<T: Decodable>(_ type: T.Type, from data: Data) -> T? {
        do {
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return decodedObject
        } catch {
            print("Failed to decode \(T.self) from data: \(error)")
            return nil
        }
    }
}
