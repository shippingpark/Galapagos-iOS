//
//  EmailCheckView.swift
//  Galapagos
//
//  Created by 조용인 on 2023/06/23.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit
import SiriUIKit

import SnapKit

import RxSwift
import RxCocoa
import RxGesture

final class EmailCheckView: UIView {
    // MARK: - UI
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일을\n입력해주세요"
        label.numberOfLines = 2
        label.font = GalapagosFontFamily.Pretendard.bold.font(size: 28)
        label.textColor = GalapagosAsset.blackHeading.color
        return label
    }()
    
    private lazy var emailTextField: GalapagosTextField_SelectEmail = {
        let textField = GalapagosTextField_SelectEmail(
            placeHolder: "이메일을 입력해주세요",
            keyboardType: .emailAddress
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
    private var disposeBag = DisposeBag()
    private var viewModel: EmailSignUpViewModel
    
    private var FakeCertified: Driver<Bool> /// 원래는 UseCase의 결과를 바인딩 해줘야함.
    
    // MARK: - Initializers
    init(
        frame: CGRect,
        viewModel: EmailSignUpViewModel
    ) {
        self.viewModel = viewModel
        self.FakeCertified = Driver.just(false)
        super.init(frame: .zero)
        
        setAddSubView()
        setConstraint()
        bind()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    // MARK: - Methods
    
    private func setAddSubView() {
        self.addSubviews([
            titleLabel,
            emailTextField,
            certifyEmailButton
        ])
    }
    
    private func setConstraint() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self)
            $0.leading.equalTo(self).offset(24)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalTo(self).inset(24)
            $0.height.equalTo(68)
        }
    
        certifyEmailButton.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(self).inset(24)
            $0.height.equalTo(50)
        }
    }
    
    private func bind() {
        
        emailTextField.isEnable
            .debug()
            .asDriver(onErrorJustReturn: false)
            .drive(certifyEmailButton.rx.isActive)
            .disposed(by: disposeBag)
        
        certifyEmailButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.viewModel.readyForNextButton.accept(true)
                self.emailTextField.isEnable.accept(false)
            })
            .disposed(by: disposeBag)
        
    }
}

// MARK: - Extension
extension EmailCheckView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}
