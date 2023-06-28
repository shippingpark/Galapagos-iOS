//
//  CustomTabBar.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/28.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxGesture

final class CustomTabBar: BaseView {
    
  var itemTapped: Observable<Int> { itemTappedSubject.asObservable() }
  private lazy var customItemViews: [CustomItemView] = [mainItem, diaryItem, communityItem, myPageItem]
    
  private let itemStackView = {
    var stackView = UIStackView()
    stackView.distribution = .fillEqually
    stackView.alignment = .top
    stackView.backgroundColor = .clear //삭제?
    return stackView
  }()
  private let mainItem = CustomItemView(with: .main)
  private let diaryItem = CustomItemView(with: .diary)
  private let communityItem = CustomItemView(with: .community)
  private let myPageItem = CustomItemView(with: .mypage)
    
  private let itemTappedSubject = PublishSubject<Int>()
    
  init() {
    super.init(frame: .zero)
    setShadow()
    selectItem(index: 0)
  }
    
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    
    updateSubviewTopConstraint()
  }
  
  private func updateSubviewTopConstraint() {
    let stackViewHeight = itemStackView.frame.height
    let constant = stackViewHeight * 0.12
        
    customItemViews.forEach { subview in
      subview.topAnchor.constraint(equalTo: self.topAnchor, constant: constant).isActive = true
    }
  }
  
  override func setAddSubView() {
    self.addSubview(itemStackView)
    
    customItemViews.forEach { subview in
    itemStackView.addArrangedSubview(subview) }
  }
  
  override func setAttribute() { //보강 필요
    self.layer.cornerRadius = 20
    self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
  }
    
  private func selectItem(index: Int) {
    itemStackView.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.edges.equalToSuperview()
    }
    
    customItemViews.forEach { $0.isSelected = $0.item.rawValue == index }
      itemTappedSubject.onNext(index)
  }
  
  func setShadow() {
    self.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
    self.layer.shadowOffset = CGSize(width: 0, height: -3)
    self.layer.shadowOpacity = 1
    self.layer.shadowRadius = 10
    self.layer.masksToBounds = false
  }
    
    //MARK: - Bindings
    
  override func bind() {
    mainItem.rx.tapGesture()
      .when(.recognized)
      .bind { [weak self] _ in
          guard let self = self else { return }
        self.mainItem.animateClick {
          self.selectItem(index: self.mainItem.item.rawValue)
        }
      }
      .disposed(by: disposeBag)
      
    diaryItem.rx.tapGesture()
      .when(.recognized)
      .bind { [weak self] _ in
        guard let self = self else { return }
        self.diaryItem.animateClick {
          self.selectItem(index: self.diaryItem.item.rawValue)
        }
      }
      .disposed(by: disposeBag)
        
    communityItem.rx.tapGesture()
      .when(.recognized)
      .bind { [weak self] _ in
        guard let self = self else { return }
        self.communityItem.animateClick {
          self.selectItem(index: self.communityItem.item.rawValue)
        }
      }
      .disposed(by: disposeBag)

    myPageItem.rx.tapGesture()
      .when(.recognized)
      .bind { [weak self] _ in
        guard let self = self else { return }
        self.myPageItem.animateClick {
          self.selectItem(index: self.myPageItem.item.rawValue)
        }
      }
      .disposed(by: disposeBag)
  }
}
