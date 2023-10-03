//
//  CertifyCodeWithEmailUsecase.swift
//  Galapagos
//
//  Created by Siri on 2023/10/04.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation
import RxSwift

protocol CertifyCodeWithEmailUsecase {
    func sendCodeWithEmail(body: SendCodeWithEmailBody) -> Single<String>
}

