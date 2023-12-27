//
//  DiaryListViewController.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/11.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit

import SiriUIKit

class DiaryListViewController: BaseViewController {
  
  // MARK: - UI
  
  private lazy var navigationBar: GalapagosNavigationTabBarView = {
    let navigationBar = GalapagosNavigationTabBarView()
    navigationBar.setPageType(.diary)
    return navigationBar
  }()
  
  private lazy var typeOfAnimalTab: GalapagosDynamicTabView = {
    let tab = GalapagosDynamicTabView(
      type: .underHeader,
      titles: self.typeOfAnimal
    )
    
    tab
      .rx
      .changedPage
      .drive { pageIndex in
        print("\(pageIndex)")
      }
      .disposed(by: disposeBag)
    
    return tab
  }()
  
	private lazy var button: UIButton = {
		let button = UIButton()
		button.backgroundColor = .darkGray
		button.setTitle("상세 다이어리", for: .normal)
		return button
  }()
  
	// button2....?
	private lazy var button2: UIButton = {
		let button = UIButton()
		button.backgroundColor = .blue
		button.setTitle("펫 추가", for: .normal)
		return button
  }()
  
  // MARK: - Properties
  
  private let viewModel: DiaryListViewModel
  private var typeOfAnimal: [String] = ["전체", "도마뱀"]
  
  // MARK: - Initializers
  
  init(viewModel: DiaryListViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  // MARK: - Methods
  
  override func setAddSubView() {
    self.view.addSubviews([
      navigationBar,
      typeOfAnimalTab,
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
    
    typeOfAnimalTab.snp.makeConstraints { tab in
      tab.top.equalTo(navigationBar.snp.bottom)
      tab.horizontalEdges.equalToSuperview()
    }
    
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
    let input = DiaryListViewModel.Input(
      buttonTapped: button.rx.tap.asSignal(),
      button2Tapped: button2.rx.tap.asSignal()
    )
    _ = viewModel.transform(input: input)
  }
}
