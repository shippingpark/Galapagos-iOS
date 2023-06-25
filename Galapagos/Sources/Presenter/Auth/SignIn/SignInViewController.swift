//
//  SignInViewController.swift
//  Galapagos
//
//  Created by 조용인 on 2023/06/07.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit
import SnapKit
import Then
import SiriUIKit


class SignInViewController: BaseViewController {
  
  //MARK: - UI
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = "갈파 텍스트 로고"
    label.textColor = GalapagosAsset.green.color
    label.font = GalapagosFontFamily.Pretendard.bold.font(size: 28)
    return label
  }()
  
  private lazy var logoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = GalapagosAsset.gray6DisableBtnBg.color
    imageView.clipsToBounds = true
    imageView.cornerRadius = 12
    return imageView
  }()
  
  private lazy var galapagosInfoLable: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.contentMode = .center
    label.textAlignment = .center
    let text = "동물들의 지상낙원,\n갈라파고스에 오신 것을 환영해요!"
    let attributedString = NSMutableAttributedString(string: text)
    
    let blackAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: GalapagosAsset.blackHeading.color]
    let greenAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: GalapagosAsset.green.color]
    let galapagosRange = (text as NSString).range(of: "갈라파고스")
    attributedString.addAttributes(blackAttributes, range: NSRange(location: 0, length: text.count))
    attributedString.addAttributes(greenAttributes, range: galapagosRange)
    label.attributedText = attributedString
    label.font = GalapagosFontFamily.Pretendard.semiBold.font(size: 18)
    return label
  }()
  
  private lazy var kakaoSignInButton: GalapagosButton = {
      let button = GalapagosButton(buttonStyle: .fill, isCircle: true)
    button.setImage(GalapagosAsset.snsKakao.image, for: .normal)
    button.borderWidth = 0
    return  button
  }()
  
  private lazy var naverSignInButton: GalapagosButton = {
    let button = GalapagosButton(buttonStyle: .fill, isCircle: true)
    button.setImage(GalapagosAsset.snsNaver.image, for: .normal)
    button.borderWidth = 0
    return  button
  }()
  
  private lazy var appleSignInButton: GalapagosButton = {
    let button = GalapagosButton(buttonStyle: .fill, isCircle: true)
    button.setImage(GalapagosAsset.snsApple.image, for: .normal)
    button.borderWidth = 0
    return  button
  }()
  
  private lazy var googleSignInButton: GalapagosButton = {
    let button = GalapagosButton(buttonStyle: .fill, isCircle: true)
    button.setImage(GalapagosAsset.snsGoogle.image, for: .normal)
    button.borderWidth = 0
    return  button
  }()
  
  private lazy var emailSignUpButton: GalapagosButton = {
    let button = GalapagosButton(buttonStyle: .outline)
    let attributedString = NSAttributedString(string: "이메일 회원가입",
                                              attributes: [
                                                .underlineStyle : NSUnderlineStyle.single.rawValue,
                                                .baselineOffset : NSNumber(value: 2),
                                                .underlineColor : GalapagosAsset.gray1Main.color
                                              ])
    button.setAttributedTitle(attributedString, for: .normal)
    button.setTitleColor(GalapagosAsset.gray1Main.color, for: .normal)
    button.titleLabel?.font = GalapagosFontFamily.Pretendard.medium.font(size: 14)
    button.borderWidth = 0
    return  button
  }()
  
  private lazy var emailSignInButton: GalapagosButton = {
    let button = GalapagosButton(buttonStyle: .outline)
    let attributedString =
    NSAttributedString(string: "이메일 로그인",
                       attributes: [
                        .underlineStyle : NSUnderlineStyle.single.rawValue,
                        .baselineOffset : NSNumber(value: 2),
                        .underlineColor : GalapagosAsset.gray1Main.color
                       ])
    button.setAttributedTitle(attributedString, for: .normal)
    button.setTitleColor(GalapagosAsset.gray1Main.color, for: .normal)
    button.titleLabel?.font = GalapagosFontFamily.Pretendard.medium.font(size: 14)
    button.borderWidth = 0
    return  button
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
    stackView.alignment = .top
    stackView.distribution = .fillProportionally
    stackView.spacing = 20
    return stackView
  }()
  
  //MARK: - Properties
  private let viewModel: SignInViewModel
  
  //MARK: - Initializers
  init(
    viewModel: SignInViewModel
  ) {
    self.viewModel = viewModel
    super.init()
  }
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  //MARK: - Methods
  override func setConstraint() {
    titleLabel.snp.makeConstraints{ titleLable in
      titleLable.centerX.equalToSuperview()
      titleLable.centerY.equalToSuperview().multipliedBy(0.4)
    }
    
    logoImageView.snp.makeConstraints { logoImageView in
      logoImageView.centerX.equalToSuperview()
      logoImageView.top.equalTo(titleLabel.snp.bottom).multipliedBy(1.2)
      logoImageView.height.width.equalTo(185)
    }
    
    galapagosInfoLable.snp.makeConstraints{ infoLabel in
      infoLabel.centerX.equalToSuperview()
      infoLabel.top.equalTo(logoImageView.snp.bottom).multipliedBy(1.1)
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
    
    emailLoginStackView.snp.makeConstraints{ emailStack in
      emailStack.centerX.equalToSuperview()
      emailStack.top.equalTo(socialLoginStackView.snp.bottom)
        .offset(20)
    }
  }
  override func setAddSubView() {
    self.view.addSubviews([
      titleLabel,
      logoImageView,
      galapagosInfoLable,
      socialLoginStackView,
      emailLoginStackView
    ])
    
    [kakaoSignInButton, naverSignInButton,
     appleSignInButton, googleSignInButton].forEach { self.socialLoginStackView.addArrangedSubview($0) }
    
    [emailSignUpButton, emailSignInButton].forEach { self.emailLoginStackView.addArrangedSubview($0) }
  }
  
  override func bind() {
    let emailSignUpBtnTapped = emailSignUpButton.rx.tap
      .asObservable()
    let emailSignInBtnTapped = emailSignInButton.rx.tap
      .asObservable()
    
    let input = SignInViewModel.Input(
      emailSignUpBtnTapped: emailSignUpBtnTapped,
      emailSignInBtnTapped: emailSignInBtnTapped
    )
    let output = viewModel.transform(input: input)
  }
}
