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
        label.textColor = GalapagosAsset.black제목DisplayHeadingBody.color
        return label
    }()
    
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
    
    private lazy var checkCertifiCodeView: GalapagosTextField_Timer = {
        let view = GalapagosTextField_Timer(
            MAX_TIME: 10,
            startTime: "00:10"
        )
        view.isHidden = true
        return view
    }()
    
    
    
    // MARK: - Properties
    private var disposeBag = DisposeBag()
    private var viewModel: EmailSignUpViewModel
    
    /// 이메일 인증 API의 return을 담아낸다 (초기값 false)
    private let emailCertified: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    
    // MARK: - Initializers
    init(
        frame: CGRect,
        viewModel: EmailSignUpViewModel
    ) {
        self.viewModel = viewModel
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
            certifyEmailButton,
            checkCertifiCodeView
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
        
        checkCertifiCodeView.snp.makeConstraints {
            $0.top.equalTo(self.certifyEmailButton.snp.bottom).offset(32)
            $0.leading.trailing.equalTo(self).inset(24)
            $0.height.equalTo(100)
        }
    }
    
    private func bind() {
//        
//        emailTextField.isEnable
//            .asDriver(onErrorJustReturn: false)
//            .drive(certifyEmailButton.rx.isActive)
//            .disposed(by: disposeBag)
//        
//        certifyEmailButton.rx.tap
//            .subscribe(onNext: { [weak self] in
//                guard let self = self else { return }
//                // TODO: 이메엘 인증 API호출 (Usecase통해서)
//                // 인증 성공 결과를 Observable<Bool>로 전달 해줘야함
//                
//                /// 임시 fake
//                self.emailCertified.accept(true)
//                self.emailTextField.isEnable.accept(false)
//                self.emailTextField.isUserInteractionEnabled = false
//            })
//            .disposed(by: disposeBag)
//        
        // TODO: 이메일 인증받은 결과를 subscribe 해줘야함
        // 그리고, 결과에 따라서 인증코드 확인하는 View 보여줘야함
        emailCertified
            .distinctUntilChanged() // 기본값이 false라서, 인증이 될 때만 통과함
            .subscribe(onNext: { [weak self] isCertified in
                guard let self = self else { return }
                if isCertified{
                    // TODO: 인증된 상태라면 isHidden풀어주고, timer on
                    self.checkCertifiCodeView.isHidden = false
                    self.checkCertifiCodeView.isTimerStarted.accept(true)
                }else{
                    self.checkCertifiCodeView.isTimerStarted.accept(false)
                }
            })
            .disposed(by: disposeBag)
        
        // TODO: 확인버튼 눌렀을 때, API호출 해야함. 그리고 결과를 Observable<Bool>로 반환
        
        checkCertifiCodeView.isButtonTapped
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] isTapped in
                guard let self = self else { return }
                // TODO: 인증코드 확인하는 API호출 해야함 (Usecase에서)
                // 코드의 인증 결과를 Bool타입으로 전달해줘야함
                
                // Fake
                self.viewModel.readyForNextButton.accept(true)
            })
            .disposed(by: disposeBag)
        
        // TODO: 만약, 인증코드가 잘 되어있으면 -> isButtonTapped에 true전달, checkButton 비활성화, 해당 뷰 isUserInteractionEnabled 꺼주기 | 인증코드가 잘 안되어 있으면 -> 반댓값
    }
}

// MARK: - Extension
extension EmailCheckView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}
