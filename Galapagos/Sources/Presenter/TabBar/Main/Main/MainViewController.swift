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
  
  private var shadowView = ShadowView()

  private lazy var navigationBar: GalapagosNavigationTabBarView = {
    let navigationBar = GalapagosNavigationTabBarView()
    navigationBar.setPageType(.main)
    return navigationBar
  }()
  
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
    self.view.addSubviews([
      navigationBar,
      shadowView,
      button,
      button2
    ])
  }
  
  override func setConstraint() {
    
    navigationBar.snp.makeConstraints{ navigationBar in
        navigationBar.top.equalTo(self.view.safeAreaLayoutGuide)
        navigationBar.leading.trailing.equalToSuperview()
        navigationBar.height.equalTo(50)
    }
    
    shadowView.snp.makeConstraints { make in
      make.top.equalTo(navigationBar.snp.bottom).offset(40)
      make.centerX.equalToSuperview()
      make.width.equalToSuperview().multipliedBy(0.88)
      make.height.equalTo(shadowView.snp.width)
    }
    
    button.snp.makeConstraints { make in
      make.width.equalTo(300)
      make.height.equalTo(40)
      make.center.equalTo(shadowView.snp.center)
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

