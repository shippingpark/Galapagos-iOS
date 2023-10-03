//
//  NetworkService.swift
//  Galapagos
//
//  Created by 조용인 on 2023/07/03.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation

import RxSwift

final class DefaultNetworkService: NetworkService {
    
    // MARK: - Properties
    private let session: URLSession = .shared
    
    // MARK: - Methods

    func request(_ endpoint: Endpoint) -> Single<Data> {
        guard let urlRequest = endpoint.toURLRequest() else { return .error(NetworkError.invalidURL) }
        
        return session.rx
            .data(request: urlRequest)
            .asSingle()
    }
}
