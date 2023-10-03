//
//  CertifyEmailView.swift
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

final class CertifyEmailView: BaseView {
    
    // MARK: - UI Components
    
    private lazy var emailTextField: GalapagosTextField = {
        let textField = GalapagosTextField(
            placeHolder: "이메일을 입력해주세요",
            maxCount: 8,
            errorMessage: "이메일 형식이 아닙니다."
        )
        return textField
    }()
    
    private lazy var certifyEmailButton: GalapagosButton = {
        let button = GalapagosButton(buttonStyle: .fill, isEnable: false)
        button.setTitle("이메일 인증하기", for: .normal)
        button.titleLabel?.font = GalapagosFontFamily.Pretendard.semiBold.font(size: 16)
        return button
    }()
    
    // MARK: - Properties
    
    // MARK: - Initialize
    
    // MARK: - Methods
    
    override func setAddSubView() {
        super.setAddSubView()
    }
    
    override func setConstraint() {
        super.setConstraint()
    }
    
    override func setAttribute() {
        super.setAttribute()
    }
    
    override func bind() {
        super.bind()
    }
}
