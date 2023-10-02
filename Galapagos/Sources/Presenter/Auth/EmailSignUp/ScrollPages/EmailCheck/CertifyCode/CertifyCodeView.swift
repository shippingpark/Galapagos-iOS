//
//  CertifyCodeView.swift
//  Galapagos
//
//  Created by Siri on 2023/10/02.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation
import UIKit
import SiriUIKit

import RxSwift
import RxCocoa

final class CertifyCodeView: BaseView {
    
    // MARK: - UI Components
    
    private lazy var checkCertifiCodeView: GalapagosTextField_Timer = {
        let view = GalapagosTextField_Timer(
            MAX_TIME: 10,
            startTime: "00:10"
        )
        view.isHidden = true
        return view
    }()
    
    // MARK: - Properties
    
    
    // MARK: - Initialize
    
    
    // MARK: - Methods
}
