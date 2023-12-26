//
//  EmptyMainPetView.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/27.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit

import RxSwift
import SiriUIKit
import SnapKit

class EmptyMainPetView: BaseView {
  
  private var shadowView = RadiusBoxView(radius: 12, style: .shadow)
  
  private lazy var petStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = UIScreen.main.bounds.width / 24.375
    return stackView
  }()
  
  private lazy var addPetInfoLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    let text = "아직 등록된 대표 동물이 없어요.\n동물을 추가하고 대표 동물을 설정해보세요!"
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = label.font.xHeight * 0.5  // 행간 150%
    paragraphStyle.alignment = .center
    
    let attributedString = NSMutableAttributedString(string: text)
    attributedString.addAttribute(
      .paragraphStyle,
      value: paragraphStyle,
      range: NSRange(location: 0, length: text.count)
    )
    
    let blackAttributes: [NSAttributedString.Key: Any] = [
      .foregroundColor: GalapagosAsset.blackDisplayHeadingBody.color
    ]
    let greenAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: GalapagosAsset.green.color]
    let greenRange = (text as NSString).range(of: "동물을 추가하고 대표 동물을 설정")
    
    attributedString.addAttributes(
      blackAttributes,
      range: NSRange(location: 0, length: text.count)
    )
    attributedString.addAttributes(greenAttributes, range: greenRange)
    label.attributedText = attributedString
    label.font = GalapagosFontFamily.Pretendard.semiBold.font(size: 14)
    return label
  }()
  
  var addPetButton: UIButton = {
    let button = UIButton()
    var config = UIButton.Configuration.filled()
    config.imagePlacement = .leading
    config.imagePadding = 8
    button.configuration = config
    button.tintColor = GalapagosAsset.green.color
    button.setImage(
      GalapagosAsset._16x16plusDefault.image,
      for: .normal
    )
    return button
  }()
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.addPetButton.cornerRadius = 26
  }
  
  override func setAddSubView() {
    self.addSubview(shadowView)
    
    shadowView.addSubview(petStackView)
    [addPetInfoLabel, addPetButton].forEach { subview in
      petStackView.addArrangedSubview(subview)
    }
  }
  
  override func setConstraint() {
    shadowView.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.edges.equalToSuperview()
    }
    
    petStackView.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
    
    addPetInfoLabel.snp.makeConstraints { make in
      make.width.lessThanOrEqualToSuperview()
    }
    
    addPetButton.snp.makeConstraints { make in
      make.height.equalTo(52)
      make.width.equalTo(145)
    }
  }
  
  override func setAttribute() {
    let buttonFont = GalapagosFontFamily.Pretendard.semiBold.font(size: 16)
    let title = "동물 추가하기"
    
    addPetButton.titleLabel?.font = buttonFont
    addPetButton.setTitleColor(.white, for: .normal)
    addPetButton.setTitleColor(.white, for: .highlighted)

    // UIButton의 각 상태에 대해 폰트를 다시 설정
    addPetButton.setAttributedTitle(
      attributedString(
        for: title,
        with: buttonFont
      ),
      for: .normal
    )
    addPetButton.setAttributedTitle(
      attributedString(
        for: title,
        with: buttonFont
      ),
      for: .highlighted
    )
  }
  
  private func attributedString(
    for string: String,
    with font: UIFont
  ) -> NSAttributedString {
    return NSAttributedString(
      string: string,
      attributes: [.font: font]
    )
  }
}
