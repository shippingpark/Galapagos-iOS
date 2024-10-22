//
//  AuthViewController.swift
//  Galapagos
//
//  Created by 조용인 on 2023/06/07.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//
import Foundation

import RxCocoa
import RxSwift

import SiriUIKit
import SnapKit

import UIKit

class AuthViewController: BaseViewController {
	
	// MARK: - UI
	private lazy var logoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.image = GalapagosAsset.galapagosLogo.image
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 12
		return imageView
	}()
	
	private lazy var logoTitleImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.image = GalapagosAsset.galapagosLogoTitle.image
		return imageView
	}()
	
	private lazy var galapagosInfoLable: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.contentMode = .center
		label.textAlignment = .center
		let text = "동물들의 지상낙원,\n갈라파고스에 오신 것을 환영해요!"
		let attributedString = NSMutableAttributedString(string: text)
		
		let blackAttributes: [NSAttributedString.Key: Any] =
		[.foregroundColor: GalapagosAsset.blackDisplayHeadingBody.color]
		let greenAttributes: [NSAttributedString.Key: Any] =
		[.foregroundColor: GalapagosAsset.green.color]
		let galapagosRange = (text as NSString).range(of: "갈라파고스")
		attributedString.addAttributes(blackAttributes, range: NSRange(location: 0, length: text.count))
		attributedString.addAttributes(greenAttributes, range: galapagosRange)
		label.attributedText = attributedString
		label.font = GalapagosFontFamily.Pretendard.semiBold.font(size: 18)
		return label
	}()
	
	private lazy var kakaoSignInButton: UIButton = {
		let button = UIButton()
		button.layer.cornerRadius = button.frame.height/2
		button.setImage(GalapagosAsset.snsKakao.image, for: .normal)
		button.layer.borderWidth = 0
		return  button
	}()
	
	private lazy var naverSignInButton: UIButton = {
		let button = UIButton()
		button.layer.cornerRadius = button.frame.height/2
		button.setImage(GalapagosAsset.snsNaver.image, for: .normal)
		button.layer.borderWidth = 0
		return  button
	}()
	
	private lazy var appleSignInButton: UIButton = {
		let button = UIButton()
		button.layer.cornerRadius = button.frame.height/2
		button.setImage(GalapagosAsset.snsApple.image, for: .normal)
		button.layer.borderWidth = 0
		return  button
	}()
	
	private lazy var googleSignInButton: UIButton = {
		let button = UIButton()
		button.setImage(GalapagosAsset.snsGoogle.image, for: .normal)
		button.layer.borderWidth = 0
		return  button
	}()
	
	private lazy var emailSignUpLabel: UILabel = {
		let label = UILabel()
		let text = "이메일 회원가입"
		let attributedString = NSMutableAttributedString(string: text)
		
		let underLineAttributes: [NSAttributedString.Key: Any] = [
			.underlineStyle: NSUnderlineStyle.single.rawValue,
			.baselineOffset : NSNumber(value: 3)
		]
		attributedString.addAttributes(underLineAttributes, range: NSRange(location: 0, length: text.count))
		label.attributedText = attributedString
		label.font = GalapagosFontFamily.Pretendard.medium.font(size: 16)
		return label
	}()
	
	private lazy var emailSignInLabel: UILabel = {
		let label = UILabel()
		let text = "이메일 로그인"
		let attributedString = NSMutableAttributedString(string: text)
		
		let underLineAttributes: [NSAttributedString.Key: Any] = [
			.underlineStyle: NSUnderlineStyle.single.rawValue,
			.baselineOffset : NSNumber(value: 3)
		]
		attributedString.addAttributes(underLineAttributes, range: NSRange(location: 0, length: text.count))
		label.attributedText = attributedString
		label.font = GalapagosFontFamily.Pretendard.medium.font(size: 16)
		return label
	}()
	
	private lazy var separatorView: UIView = {
		let separator = UIView()
		separator.backgroundColor = GalapagosAsset.gray5DisableText2.color
		return separator
	}()
	
	private lazy var socialLoginStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .top
		stackView.distribution = .fillProportionally
		stackView.spacing = 20
		return stackView
	}()
	
	private lazy var emailLoginStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .center
		stackView.distribution = .equalSpacing
		stackView.spacing = 10
		return stackView
	}()
	
	// MARK: - Properties
	private let viewModel: AuthViewModel
	
	// MARK: - Initializers
	init(
		viewModel: AuthViewModel
	) {
		self.viewModel = viewModel
		super.init()
	}
	
	// MARK: - LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	// MARK: - Methods
	override func setConstraint() {
		logoImageView.snp.makeConstraints { logoImageView in
			logoImageView.centerX.equalToSuperview()
			logoImageView.top.equalToSuperview().offset(180)
			logoImageView.height.width.equalTo(110)
		}
		
		logoTitleImageView.snp.makeConstraints { logoTitleImageView in
			logoTitleImageView.centerX.equalToSuperview()
			logoTitleImageView.top.equalTo(logoImageView.snp.bottom).offset(24)
			logoTitleImageView.height.equalTo(30)
			logoTitleImageView.width.equalTo(150)
		}
		
		galapagosInfoLable.snp.makeConstraints{ infoLabel in
			infoLabel.centerX.equalToSuperview()
			infoLabel.top.equalTo(logoTitleImageView.snp.bottom).offset(50)
		}
		
		kakaoSignInButton.snp.makeConstraints { kakaoButton in
			kakaoButton.width.height.equalTo(56)
		}
		
		naverSignInButton.snp.makeConstraints { naverButton in
			naverButton.width.height.equalTo(56)
		}
		
		appleSignInButton.snp.makeConstraints { appleButton in
			appleButton.width.height.equalTo(56)
		}
		
		googleSignInButton.snp.makeConstraints { googleButton in
			googleButton.width.height.equalTo(56)
		}
		
		socialLoginStackView.snp.makeConstraints{ socialStack in
			socialStack.centerX.equalToSuperview()
			socialStack.top.equalTo(galapagosInfoLable.snp.bottom).multipliedBy(1.25)
		}
		
		separatorView.snp.makeConstraints{ separator in
			separator.width.equalTo(0.6)
			separator.height.equalTo(16)
		}
		
		emailLoginStackView.snp.makeConstraints{ emailStack in
			emailStack.centerX.equalToSuperview()
			emailStack.top.equalTo(socialLoginStackView.snp.bottom)
				.offset(20)
		}
	}
	
	override func setAddSubView() {
		self.view.addSubviews([
			logoImageView,
			logoTitleImageView,
			galapagosInfoLable,
			socialLoginStackView,
			emailLoginStackView
		])
		
		[ kakaoSignInButton,
			naverSignInButton,
			appleSignInButton,
			googleSignInButton ].forEach { self.socialLoginStackView.addArrangedSubview($0) }
		
		[	emailSignUpLabel,
			separatorView,
			emailSignInLabel ].forEach { self.emailLoginStackView.addArrangedSubview($0) }
	}
	
	override func bind() {
		let emailSignUpBtnTapped = emailSignUpLabel.rx.tapped().asObservable()
		let emailSignInBtnTapped = emailSignInLabel.rx.tapped().asObservable()
		let googleSignInBtnTapped = googleSignInButton.rx.tap
			.asObservable()
		
		let input = AuthViewModel.Input(
			emailSignUpBtnTapped: emailSignUpBtnTapped,
			emailSignInBtnTapped: emailSignInBtnTapped,
			googleSignInBtnTapped: googleSignInBtnTapped
		)
		
		_ = viewModel.transform(input: input)
	}
}
