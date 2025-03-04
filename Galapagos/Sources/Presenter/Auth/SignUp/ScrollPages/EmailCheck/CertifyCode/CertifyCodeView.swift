//
//  CertifyCodeView.swift
//  Galapagos
//
//  Created by Siri on 2023/10/02.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation

import SiriUIKit
import UIKit


import RxCocoa
import RxSwift


final class CertifyCodeView: BaseView {
	
	// MARK: - UI Components
	public lazy var infoLabel: UILabel = {
		let label = UILabel()
		label.text = "이메일로 전송된 인증번호를 입력해주세요"
		label.font = SiriUIKitFontFamily.Pretendard.medium.font(size: 14)
		return label
	}()
	
	public lazy var timerTextField: GalapagosTextField_Timer = {
		let textField = GalapagosTextField_Timer(
			placeHolder: "인증코드 6자리 입력",
			maxCount: 6
		)
		return textField
	}()
	
	public lazy var errorMessage: GalapagosErrorMessage = {
		let errorMessage = GalapagosErrorMessage(
			title: "인증코드를 받지 못하셨나요?",
			type: .info
		)
		return errorMessage
	}()
	
	public lazy var reSendEmail: UIButton = {
		let button = UIButton()
		button.setUnderlineTitle(
			"이메일 재전송",
			font: SiriUIKitFontFamily.Pretendard.medium.font(size: 14),
			color: GalapagosAsset.blackDisplayHeadingBody.color
		)
		return button
	}()
	
	
	
	// MARK: - Properties
	
	private let viewModel: CertifyCodeViewModel
	private let parentViewModel: EmailCheckViewModel
	
	// MARK: - Initialize
	init(
		viewModel: CertifyCodeViewModel,
		parentViewModel: EmailCheckViewModel
	) {
		self.viewModel = viewModel
		self.parentViewModel = parentViewModel
		
		super.init(frame: .zero)
		self.backgroundColor = GalapagosAsset.gray5Bg2.color
	}
	
	override func setAddSubView() {
		super.setAddSubView()
		addSubviews([
			infoLabel,
			timerTextField,
			errorMessage,
			reSendEmail
		])
		
	}
	
	override func setConstraint() {
		super.setConstraint()
		
		infoLabel.snp.makeConstraints {
			$0.top.equalToSuperview()
			$0.leading.equalToSuperview()
		}
		
		timerTextField.snp.makeConstraints {
			$0.top.equalTo(infoLabel.snp.bottom).galapagosOffset(offset: ._12)
			$0.leading.trailing.equalToSuperview()
			$0.height.equalTo(68)
		}
		
		errorMessage.snp.makeConstraints {
			$0.top.equalTo(timerTextField.snp.bottom).offset(6)
			$0.leading.equalToSuperview()
		}
		
		reSendEmail.snp.makeConstraints {
			$0.leading.equalTo(errorMessage.snp.trailing).offset(4)
			$0.centerY.equalTo(errorMessage)
		}
		
	}
	
	override func setAttribute() {
		super.setAttribute()
	}
	
	override func bind() {
		super.bind()
		
		let input = CertifyCodeViewModel.Input(
			certifyCode: timerTextField.rx.text.orEmpty.asObservable(),
			email: parentViewModel.userEmail.asObservable(),
			sendCertifyCodeTapped: timerTextField.rx.confirmBtnTapped.asObservable(),
			reSendEmailTapped: reSendEmail.rx.tap.asObservable()
		)
		
		let output = viewModel.transform(input: input)
		
		timerTextField.rx.controlEvent(.editingDidBegin)
			.asDriver()
			.drive(onNext: { [weak self] in
				self?.errorMessage.reset()
			})
			.disposed(by: disposeBag)
		
		reSendEmail.rx.tap
			.bind(to: timerTextField.resetTimerSubject)
			.disposed(by: disposeBag)
		
		output.resultOfCertify
			.skip(1)
			.withUnretained(self)
			.observe(on: MainScheduler.instance)
			.subscribe(onNext: { owner, isAvailable in
				owner.parentViewModel.nextButtonIsAvailable.accept(isAvailable)
				owner.reSendEmail.isHidden = isAvailable
				if isAvailable {
					owner.timerTextField.rxType.accept(.disabled)
					owner.errorMessage.rxType.accept(.success)
				} else {
					owner.timerTextField.rxType.accept(.error)
					owner.errorMessage.rxType.accept(.error)
				}
			})
			.disposed(by: disposeBag)
		
		output.receivedMessage
			.withUnretained(self)
			.observe(on: MainScheduler.instance)
			.subscribe(onNext: { owner, message in
				owner.errorMessage.setErrorMessage(message: message)
			})
			.disposed(by: disposeBag)
		
		
		output.resendEmailMessage
			.observe(on: MainScheduler.instance)
			.subscribe(onNext: { message in
				GalapagosToastManager.shared.addToast(message: "인증코드가 이메일로 전송되었습니다.")
			}, onError: { error in
				GalapagosToastManager.shared.addToast(message: error.localizedDescription )
			})
			.disposed(by: disposeBag)
	}
	// MARK: - Methods
}
