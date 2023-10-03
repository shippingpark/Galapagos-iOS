//
//  DefaultAuthRepository.swift
//  Galapagos
//
//  Created by Siri on 2023/10/04.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation
import RxSwift

final class DefaultAuthRepository: AuthRepository {
    
    private let networkService: NetworkService
    
    init() {
        self.networkService = DefaultNetworkService()
    }
    
    func sendCodeWithEmail(body: SendCodeWithEmailBody) -> Single<CertifyCode> {
        let endpoint = AuthEndpoint.sendCodeWithEmail(body: body)
        
        return Single<CertifyCode>.create { result in
            let disposable = self.networkService.request(endpoint)
                .subscribe(onSuccess: { data in
                    if let userData = Utility.decode(CertifyCodeWithEmailDTO.self, from: data) {
                        result(.success(userData.toDomain()))
                    }
                }, onFailure: { error in
                    result(.failure(error)) /// 원래는 커스텀 에러케이스 만들어야함,,,
                })
            return Disposables.create {
                disposable.dispose()
            }
        }
        
    }

}
