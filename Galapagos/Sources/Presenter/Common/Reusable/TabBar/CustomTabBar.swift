//
//  CustomTabBar.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/28.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import RxCocoa
import RxGesture
import RxSwift
import UIKit

final class CustomTabBar: BaseView {
  
  private let itemStackView = {
    var stackView = UIStackView()
    stackView.distribution = .fillEqually
    stackView.alignment = .top
    return stackView
  }()
	
	private lazy var customItemViews: [CustomItemView] = {
		var views = [CustomItemView]()
		views.append(CustomItemView(with: .main))
		views.append(CustomItemView(with: .diaryList))
		views.append(CustomItemView(with: .community))
		views.append(CustomItemView(with: .mypage))
		return views
	}()
  
  let itemTappedSubject = BehaviorRelay<Int>(value: 0)
  
  init() {
    super.init(frame: .zero)
    setShadow()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setAddSubView() {
    self.addSubview(itemStackView)
    
    customItemViews.forEach { subview in
      itemStackView.addArrangedSubview(subview)
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
  
  override func setAttribute() { // 보강 필요
    self.layer.cornerRadius = 20
    self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    
    itemStackView.snp.makeConstraints { make in
      make.top.equalTo(self.snp.top).offset(10) // 유동적으로 바뀌게 만들어주기, 보류
      make.horizontalEdges.equalToSuperview()
    }
  }
	
  func changeImage(index: Int) {
    customItemViews.forEach { $0.isSelected = $0.item.rawValue == index }
  }
  
  func setShadow() {
    self.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
    self.layer.shadowOffset = CGSize(width: 0, height: -3)
    self.layer.shadowOpacity = 1
    self.layer.shadowRadius = 10
    self.layer.masksToBounds = false
  }
  
  // MARK: - Bindings
  
  override func bind() {
		
		customItemViews.forEach { tapBarItem in
			tapBarItem.rx.tapped()
				.withUnretained(self)
				.subscribe(onNext: { owner, _ in
					tapBarItem.animateClick {
						owner.itemTappedSubject.accept(tapBarItem.item.rawValue)
					}
				})
				.disposed(by: disposeBag)
		}
		
  }
}
