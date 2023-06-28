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

  private var shadowView = RadiusBoxView(radius: .defaultSmall, style: .shadow)

  private lazy var navigationBar: GalapagosNavigationTabBarView = {
    let navigationBar = GalapagosNavigationTabBarView()
    navigationBar.setPageType(.main)
    return navigationBar
  }()
  
  private lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.showsVerticalScrollIndicator = false
    return scrollView
  }()
    
  private lazy var contentView: UIView = {
    let contentView = UIView()
    return contentView
  }()
  
  private var petContainerView = UIView()
  private var communityContainerView = UIView()
  private var emptyMainPetView = EmptyMainPetView()
  private var emptyStarCommunityView = EmptyStarCommunityView()
  
  private lazy var communityLabel: UILabel = {
    let label = UILabel()
    label.text = "즐겨찾는 게시판"
    label.textColor = GalapagosAsset.blackHeading.color
    label.font = GalapagosFontFamily.Pretendard.bold.font(size: 24)
    return label
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
      scrollView
    ])

    scrollView.addSubview(contentView)
    contentView.addSubviews([
      petContainerView,
      communityContainerView
    ])
    communityContainerView.addSubview(communityLabel)
  }
  
  override func setConstraint() {
    navigationBar.snp.makeConstraints { navigationBar in
      navigationBar.top.equalTo(self.view.safeAreaLayoutGuide)
      navigationBar.leading.trailing.equalToSuperview()
      navigationBar.height.equalTo(50)
    }
    
    scrollView.snp.makeConstraints { make in
      make.top.equalTo(navigationBar.snp.bottom)
      make.leading.trailing.bottom.equalToSuperview()
    }
    
    // contentView의 제약 조건 설정
    contentView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
      make.width.equalToSuperview()
      make.height.greaterThanOrEqualTo(view.safeAreaLayoutGuide).offset(60).priority(.low)//탭바 아이템 위치를 못 잡아서 기기마다 스크롤 최하단 위치 다른 문제 발생
      //우선 가장 작은 휴대폰 SE 기준으로 설정, TabBar View 자체 커스텀화 할 예정
    }

    petContainerView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(navigationBarToContentsOffset)
      make.horizontalEdges.equalToSuperview().inset(galpagosHorizontalOffset)
    }
    
    communityLabel.snp.makeConstraints { make in
      make.top.horizontalEdges.equalToSuperview()
    }
    
    communityContainerView.snp.makeConstraints { make in
      make.horizontalEdges.equalToSuperview().inset(galpagosHorizontalOffset)
      make.top.equalTo(petContainerView.snp.bottom).offset(contentsToContentsOffset)
      make.bottom.equalTo(contentView.snp.bottom)
      
    }
  }
  
  func showViewBasedOnHasMain(_ hasMainPet: Bool) {
    if hasMainPet {
      
    } else {
      petContainerView.addSubview(emptyMainPetView)
      self.emptyPetViewConstraint()
    }
  }
  
  func showViewBasedOnHasCommunity(_ hasStarCommunity: Bool) {
    if hasStarCommunity {
      
    } else {
      communityContainerView.addSubview(emptyStarCommunityView)
      self.emptyStarConmmnityViewConstraint()
    }
  }
  
  func mainPetConstraint() {
    emptyMainPetView.snp.makeConstraints { make in
      make.top.equalTo(petContainerView.snp.top)
      make.center.equalToSuperview()
      make.height.width.equalTo(petContainerView.snp.width)
    }
  }
  
  func starCommnunityConstraint() {
    
    
  }
  
  func emptyPetViewConstraint() {
    emptyMainPetView.snp.makeConstraints { make in
      make.top.equalTo(petContainerView.snp.top)
      make.center.equalToSuperview()
      make.height.width.equalTo(petContainerView.snp.width)
    }
  }
  
  func emptyStarConmmnityViewConstraint() {
    emptyStarCommunityView.snp.makeConstraints { make in
      make.top.equalTo(communityLabel.snp.bottom).offset(navigationBarToContentsOffset)
      make.centerX.equalToSuperview()
      make.width.equalTo(communityContainerView.snp.width)
      make.height.equalTo(emptyStarCommunityView.snp.width).multipliedBy(0.53)
    }
  }
  
  override func bind() {
    let input = MainViewModel.Input(
      addPetButtonTapped: emptyMainPetView.addPetButton.rx.tap.asSignal(),
      moveCommunityTapped: emptyStarCommunityView.moveCommunityTabButton.rx.tap.asSignal(),
      button2Tapped: button2.rx.tap.asSignal()
    )
    
    let output = viewModel.transform(input: input)
    output.hasMainPet
      .drive(onNext: { pet in
        print("pet")
        self.showViewBasedOnHasMain(pet)
      })
      .disposed(by: disposeBag)
  
    output.hasStarCommunity
      .drive(onNext: { star in
        print("community")
        self.showViewBasedOnHasCommunity(star)
      })
      .disposed(by: disposeBag)
  }
}

