//
//  EmptyMainAnimalView.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/27.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit

import RxSwift
import SiriUIKit
import SnapKit

class EmptyMainAnimalView: BaseView {
  
  private var shadowView = RadiusBoxView(radius: 12, style: .shadow)
  
  private lazy var animalStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = UIScreen.main.bounds.width / 24.375
    return stackView
  }()
  
  private lazy var addAnimalInfoLabel: UILabel = {
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
      .foregroundColor: GalapagosAsset.black제목DisplayHeadingBody.color
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
  
  var addAnimalButton: UIButton = {
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
    self.addAnimalButton.cornerRadius = 26
  }
  
  override func setAddSubView() {
    self.addSubview(shadowView)
    
    shadowView.addSubview(animalStackView)
    [addAnimalInfoLabel, addAnimalButton].forEach { subview in
      animalStackView.addArrangedSubview(subview)
    }
  }
  
  override func setConstraint() {
    shadowView.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.edges.equalToSuperview()
    }
    
    animalStackView.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
    
    addAnimalInfoLabel.snp.makeConstraints { make in
      make.width.lessThanOrEqualToSuperview()
    }
    
    addAnimalButton.snp.makeConstraints { make in
      make.height.equalTo(52)
      make.width.equalTo(145)
    }
  }
  
  override func setAttribute() {
    let buttonFont = GalapagosFontFamily.Pretendard.semiBold.font(size: 16)
    let title = "동물 추가하기"
    
    addAnimalButton.titleLabel?.font = buttonFont
    addAnimalButton.setTitleColor(.white, for: .normal)
    addAnimalButton.setTitleColor(.white, for: .highlighted)

    // UIButton의 각 상태에 대해 폰트를 다시 설정
    addAnimalButton.setAttributedTitle(
      attributedString(
        for: title,
        with: buttonFont
      ),
      for: .normal
    )
    addAnimalButton.setAttributedTitle(
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
