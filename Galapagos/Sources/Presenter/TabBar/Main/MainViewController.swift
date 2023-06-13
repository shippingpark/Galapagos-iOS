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
    
  private var button = UIButton().then {
    $0.backgroundColor = .darkGray
    $0.setTitle("임시버튼, 다이어리 이동", for: .normal)
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
      self.view.addSubview(button)
  }
  
  override func setConstraint() {
    button.snp.makeConstraints { make in
      make.width.equalTo(300)
      make.height.equalTo(40)
      make.center.equalToSuperview()
    }
  }
  
  override func bind() {
    let input = MainViewModel.Input(
      buttonTapped: button.rx.tap.asSignal()
    )
    let output = viewModel.transform(input: input)
  }
}

