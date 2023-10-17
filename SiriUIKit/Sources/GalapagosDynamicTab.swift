//
//  GalapagosDynamicTab.swift
//  SiriUIKit
//
//  Created by 박혜운 on 2023/10/14.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

public final class GalapagosDynamicTabView: UIView {
  
  // MARK: - UI
  
  private let collectionView: DynamicTabCollectionViewProtocol
  
  // MARK: - public Properties
  fileprivate var _changedPage: Driver<Int> {
    return self.collectionView.rxPage
      .distinctUntilChanged()
  }
  
  // MARK: - private Properties
  
  private let type: DynamicTabType
  private var titles: [String]
  private var didSetupLayout = false
  private var disposeBag = DisposeBag()
  
  
  // MARK: - Initializers
  
  /// DynamicTab의 `type`, `titles`를 설정합니다.
  /// - Parameters:
  ///   - type : 탭 아래 밑줄 .underHeader, 컨텐츠 안에 들어가는 둥근 탭 .inContents
  ///   - titles : 탭 타이틀 배열
  public init(
    type: DynamicTabType,
    titles: [String]
  ) {
    self.type = type
    self.titles = titles
    
    switch type {
    case .underHeader:
      self.collectionView = UnderHeaderTabCollectionView(
        items: titles
      )
      
    case .inContents:
      self.collectionView = InContentsTabCollectionView(
        items: titles
      )
    }
    
    super.init(frame: .zero)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - LifeCycle
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    if !didSetupLayout {
      self.setupCollectionView()
      didSetupLayout = true
    }
    
    // 생명주기 관련 문제 발생 시 (원하지 않는 시점에 인덱스 0으로 이동)
    // TabView 자체를 View 아닌 ViewController로 수정할 것
    // 당장은 편의를 위해 UIView를 우선순위로 두고 작업하였음
    DispatchQueue.main.async {
      UIView.performWithoutAnimation {
        self.collectionView.selectedTap(at: 0)
      }
    }
  }
  
  // MARK: - public Methods
  
  public func updateAllTitles(to newTitles: [String]) {
    // 필요 시 정의
  }
  
  // MARK: - private Methods
  
  private func setupCollectionView() {
    let collectionView = self.collectionView as? UICollectionView ?? UICollectionView()
    self.setAddSubView(collectionView)
    self.setConstraint(collectionView)
  }
  
  private func setAddSubView(_ collectionView: UICollectionView) {
    self.addSubview(collectionView)
  }
  
  private func setConstraint(_ collectionView: UICollectionView) {
    collectionView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.leading.trailing.equalToSuperview()
    }
  }
}

extension Reactive where Base: GalapagosDynamicTabView {
  // changedPage라는 이름으로 이벤트를 외부에 노출
  public var changedPage: Driver<Int> {
    return base._changedPage
  }
}
