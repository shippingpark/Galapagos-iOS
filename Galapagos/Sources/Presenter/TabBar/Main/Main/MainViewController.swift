//
//  MainViewController.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/11.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit

import Then
import SnapKit

final class MainViewController: BaseViewController {
  
  // MARK: - UI
  
  private var shadowView = ShadowView()
  private var button = UIButton().then {
    $0.backgroundColor = .darkGray
    $0.setTitle("펫 추가", for: .normal)
  }
  
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
    self.view.addSubviews([button, button2])
  }
  
  override func setConstraint() {
    button.snp.makeConstraints { make in
      make.width.equalTo(300)
      make.height.equalTo(40)
      make.center.equalToSuperview()
    }
    button2.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(button.snp.bottom)
        .offset(20)
    }
  }
  
  override func bind() {
    let input = MainViewModel.Input(
      buttonTapped: button.rx.tap.asSignal(),
      button2Tapped: button2.rx.tap.asSignal()
    )
    let output = viewModel.transform(input: input)
  }
}

