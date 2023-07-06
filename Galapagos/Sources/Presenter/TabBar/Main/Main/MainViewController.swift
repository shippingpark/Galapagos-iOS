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
import RxCocoa

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
  private var mainPetView: MainPetView?
  
  private var moveMainPetDiaryTappedEvent = PublishRelay<Void>()
  
  private lazy var communityLabel: UILabel = {
    let label = UILabel()
    label.text = "즐겨찾는 게시판"
    label.textColor = GalapagosAsset.blackHeading.color
    label.font = GalapagosFontFamily.Pretendard.bold.font(size: 24)
    return label
  }()
  
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
  
  private func showViewBasedOnHasMain(_ hasMainPet: Bool) {
    if hasMainPet {
      mainPetView = MainPetView(name: "도랭이", days: String(111))//임시 입력 값
      guard let mainPetView = mainPetView else { return }
      petContainerView.addSubview(mainPetView)
      self.mainPetViewConstraint()
      mainPetView.mainPetDiaryButton.rx.tap
        .bind(to: moveMainPetDiaryTappedEvent)
        .disposed(by: disposeBag)
    } else {
      petContainerView.addSubview(emptyMainPetView)
      
      self.emptyPetViewConstraint()
    }
  }
  
  private func showViewBasedOnHasCommunity(_ hasStarCommunity: Bool) {
    if hasStarCommunity {
      
    } else {
      communityContainerView.addSubview(emptyStarCommunityView)
      self.emptyStarConmmnityViewConstraint()
    }
  }
  
  private func starCommnunityConstraint() {
    
    
  }
  
  private func emptyPetViewConstraint() {
    emptyMainPetView.snp.makeConstraints { make in
      make.top.equalTo(petContainerView.snp.top)
      make.center.equalToSuperview()
      make.height.width.equalTo(petContainerView.snp.width)
    }
  }
  
  private func mainPetViewConstraint() {
    guard let mainPetView = mainPetView else { return }
    mainPetView.snp.makeConstraints { make in
      make.top.equalTo(petContainerView.snp.top)
      make.horizontalEdges.equalToSuperview()
      make.bottom.equalToSuperview()
    }
  }
  
  private func emptyStarConmmnityViewConstraint() {
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
      moveMainPetDiaryTapped: moveMainPetDiaryTappedEvent.asSignal()
        //button2TappedEvent.asSignal()
    )
    
    let output = viewModel.transform(input: input)
    output.hasMainPet
      .drive(onNext: { pet in
        print("pet")
        //self.showViewBasedOnHasMain(pet)//실제 코드
        self.showViewBasedOnHasMain(true)//테스트용 강제
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

