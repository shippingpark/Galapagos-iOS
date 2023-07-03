//
//  NetworkError.swift
//  Galapagos
//
//  Created by 조용인 on 2023/07/03.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation

/// 네트워크 통신 중, Error타입 커스텀 지정
public enum NetworkError: LocalizedError {
    
    case invalidURL
    case unknown
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "올바르지 않은 URL입니다."
        case .unknown:
            return "알 수 없는 오류입니다."
        }
    }
}
