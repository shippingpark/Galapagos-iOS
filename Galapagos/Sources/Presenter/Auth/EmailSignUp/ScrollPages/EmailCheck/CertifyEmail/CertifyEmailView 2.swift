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
            maxCount: 0,
            errorMessage: ""
        )
        return textField
    }()
    
    private lazy var certifyEmailButton: GalapagosButton = {
        let button = GalapagosButton(
            isRound: false,
            iconTitle: nil,
            type: .Usage(.Disabled),
            title: "이메일 인증하기"
        )
        return button
    }()
    
    // MARK: - Properties
    
    // MARK: - Initialize
    
    // MARK: - Methods
    
    override func setAddSubView() {
        super.setAddSubView()
        addSubviews([
            emailTextField,
            certifyEmailButton
        ])
    }
    
    override func setConstraint() {
        super.setConstraint()
        
        emailTextField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(68)
        }
        
        certifyEmailButton.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
    
    }
    
    override func setAttribute() {
        super.setAttribute()
    }
    
    override func bind() {
        super.bind()
        
        emailTextField.rxType
            .asObservable()
            .subscribe(onNext: { type in
                if type == .filed {
                    self.certifyEmailButton.rxType.accept(.Usage(.Inactive))
                } else {
                    self.certifyEmailButton.rxType.accept(.Usage(.Disabled))
                }
            })
            .disposed(by: disposeBag)
    }
}
