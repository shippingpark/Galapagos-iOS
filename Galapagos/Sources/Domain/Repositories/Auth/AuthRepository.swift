//
//  AuthRepository.swift
//  Galapagos
//
//  Created by Siri on 2023/10/04.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation
import RxSwift

protocol AuthRepository {
    func sendCodeWithEmail(body: SendCodeWithEmailBody) -> Single<CertifyCode>
}
