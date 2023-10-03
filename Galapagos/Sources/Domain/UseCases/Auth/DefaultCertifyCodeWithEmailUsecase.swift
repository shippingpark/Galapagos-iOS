//
//  DefaultCertifyCodeWithEmailUsecase.swift
//  Galapagos
//
//  Created by Siri on 2023/10/04.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation
import RxSwift


class DefaultCertifyCodeWithEmailUsecase: CertifyCodeWithEmailUsecase {
    
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func sendCodeWithEmail(body: SendCodeWithEmailBody) -> Single<String> {
        return authRepository.sendCodeWithEmail(body: body)
            .map { $0.message }
    }
}
