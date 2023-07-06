//
//  AddAnimalViewController.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/20.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//


import UIKit

import SnapKit
import SiriUIKit
import RxSwift
import RxCocoa

class AddAnimalViewController: BaseViewController {
  
  //MARK: - UI
  private lazy var mockLabel: UILabel = {
    let label = UILabel()
    label.text = "AddAnimal"
    label.textColor = GalapagosAsset.green.color
    label.font = GalapagosFontFamily.Pretendard.bold.font(size: 36)
    return label
  }()
  
  private lazy var navigationBar: GalapagosNavigationBarView = {
    let navigationBar = GalapagosNavigationBarView()
    navigationBar.setTitleText("")
    return navigationBar
  }()
  
  //MARK: - Properties
  private let viewModel: AddAnimalViewModel
  
  //MARK: - Initializers
  init(
    viewModel: AddAnimalViewModel
  ) {
    self.viewModel = viewModel
    super.init()
  }
  
  //MARK: - LifeCycle
  
  //MARK: - Methods
  
  override func setConstraint() {
    navigationBar.snp.makeConstraints{ navigationBar in
      navigationBar.top.equalTo(self.view.safeAreaLayoutGuide)
      navigationBar.leading.trailing.equalToSuperview()
      navigationBar.height.equalTo(50)
    }
    
    mockLabel.snp.makeConstraints{ mockLabel in
      mockLabel.centerX.equalToSuperview()
      mockLabel.centerY.equalToSuperview()
    }
  }
  
  override func setAddSubView() {
    self.view.addSubviews([
      navigationBar,
      mockLabel
    ])
  }
  
  override func bind() {
    let input = AddAnimalViewModel.Input(
      backButtonTapped: navigationBar.backButton.rx.tap.asSignal()
    )
    
    let output = viewModel.transform(input: input)
  }
}
