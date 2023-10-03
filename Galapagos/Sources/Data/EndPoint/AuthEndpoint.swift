//
//  AuthEndpoint.swift
//  Galapagos
//
//  Created by Siri on 2023/10/04.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation

enum AuthEndpoint: Endpoint {
    
    case sendCodeWithEmail(body: SendCodeWithEmailBody)
    
    var baseURL: URL? {
        return URL(string: "http://3.34.8.109:3040/email")
    }
    
    var method: HTTPMethod {
        switch self {
            case .sendCodeWithEmail:
                return .POST
        }
    }
    
    var path: String {
        switch self {
            case .sendCodeWithEmail:
                return "/send-code"
        }
    
    }
    
    var parameters: HTTPRequestParameterType? {
        switch self {
            case .sendCodeWithEmail(let body):
                return .body(body)
        }
    }
    
    
}
