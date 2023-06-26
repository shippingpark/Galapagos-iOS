//
//  MainViewController.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/11.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit

import SnapKit
import SiriUIKit

final class MainViewController: BaseViewController {
  
  // MARK: - UI
  private lazy var addAnimalStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .fillProportionally
    stackView.spacing = UIScreen.main.bounds.width / 24.375
    return stackView
  }()

  private var shadowView = RadiusBoxView(radius: .small, style: .shadow)

  private lazy var navigationBar: GalapagosNavigationTabBarView = {
    let navigationBar = GalapagosNavigationTabBarView()
    navigationBar.setPageType(.main)
    return navigationBar
  }()
  
  private lazy var addPetInfoLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    let text = "아직 등록된 대표 동물이 없어요.\n동물을 추가하고 대표 동물을 설정해보세요!"
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = label.font.xHeight * 0.5  // 행간 150%
    paragraphStyle.alignment = .center

    let attributedString = NSMutableAttributedString(string: text)
    attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: text.count))
    
    let blackAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: GalapagosAsset.blackHeading.color]
    let greenAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: GalapagosAsset.green.color]
    let greenRange = (text as NSString).range(of: "동물을 추가하고 대표 동물을 설정")
    attributedString.addAttributes(blackAttributes, range: NSRange(location: 0, length: text.count))
    attributedString.addAttributes(greenAttributes, range: greenRange)
    label.attributedText = attributedString
    label.font = GalapagosFontFamily.Pretendard.semiBold.font(size: 14)
    return label
  }()

  private var addPetButton: GalapagosButton = {
    let button = GalapagosButton(buttonStyle: .fill, isCircle: true)
    //이미지 추가 시 라벨과 이미지 사이 간격 필요, 그러나 UIEdgeInsets는 15.0부터 deprecated 되는 기능
    //따라서 UIButton.Configuration.plain() 으로 image padding 설정해 주려 하였으나,
    //폰트, 라벨 색상, 버튼 이미지에 달하는 전체적인 코드를 변경 코드를 다 수정해 주어야 해서 사용 X
    let spacing: CGFloat = 8
    button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
    button.setImage(GalapagosAsset._16x16plusDefault.image, for: .normal)
    button.setTitle("동물 추가하기", for: .normal)
    
    return button
  }()

  private var button2 = UIButton().then {
    $0.backgroundColor = .blue
    $0.setTitle("상세 다이어리", for: .normal)
  }
  
  // MARK: - Properties
  
  private let viewModel: MainViewModel
  
  // MARK: - Initializers
  
  init(viewModel: MainViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  // MARK: - Methods
  
  override func setAddSubView() {
    
    self.view.addSubviews([
      navigationBar,
      shadowView
//      button2 //메인동물 상세 이동
    ])
    
    shadowView.addSubview(addAnimalStackView)
    [addPetInfoLabel, addPetButton].forEach { subview in
      addAnimalStackView.addArrangedSubview(subview)
    }
  }
  
  override func setConstraint() {
    navigationBar.snp.makeConstraints{ navigationBar in
        navigationBar.top.equalTo(self.view.safeAreaLayoutGuide)
        navigationBar.leading.trailing.equalToSuperview()
        navigationBar.height.equalTo(50)
    }
    
    shadowView.snp.makeConstraints { make in
      make.top.equalTo(navigationBar.snp.bottom).offset(navigationBarToContentsOffset)
      make.centerX.equalToSuperview()
      make.horizontalEdges.equalToSuperview().inset(galpagosHorizontalOffset)
      make.height.equalTo(shadowView.snp.width)
    }
    
    addAnimalStackView.snp.makeConstraints { make in
        make.center.equalToSuperview()
    }
    
    addPetInfoLabel.snp.makeConstraints { make in
        make.width.lessThanOrEqualToSuperview()
    }
    
    addPetButton.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.height.equalTo(50)
      make.width.equalTo(145)
    }
//    button2.snp.makeConstraints { make in
//      make.centerX.equalToSuperview()
//      make.top.equalTo(button.snp.bottom)
//        .offset(20)
//    }
  }
  
  override func bind() {
    let input = MainViewModel.Input(
      addPetButtonTapped: addPetButton.rx.tap.asSignal(),
      button2Tapped: button2.rx.tap.asSignal()
    )
    let output = viewModel.transform(input: input)
  }
}

