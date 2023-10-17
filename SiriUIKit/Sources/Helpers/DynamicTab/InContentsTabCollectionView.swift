//
//  InContentsTabCollectionView.swift
//  SiriUIKit
//
//  Created by 박혜운 on 2023/10/14.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import RxCocoa
import UIKit

final class InContentsTabCollectionView: UICollectionView, DynamicTabCollectionViewProtocol {
  
  // MARK: - public Properties
  
  public var rxPage: Driver<Int> {
    return self.selectedPage.asDriver()
  }
  
  // MARK: - private Properties
  
  private var selectedPage = BehaviorRelay<Int>(value: 0)
  private let items: [String]
  
  // MARK: - Initializers
  
  init(items: [String]) {
    self.items = items
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.minimumLineSpacing = .zero
    flowLayout.minimumInteritemSpacing = 8
    flowLayout.scrollDirection = .horizontal
    flowLayout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
    super.init(frame: .zero, collectionViewLayout: flowLayout)
    self.setConstraint()
    self.setAttribute()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Methods
  
  public func selectedTap(at index: Int) { // 필요 시 활성화
    let indexPath = IndexPath(item: index, section: 0)
    self.selectItem(
      at: indexPath,
      animated: false,
      scrollPosition: .right
    )
    self.collectionView(self, didSelectItemAt: indexPath)
  }
  
  private func setConstraint() {
    self.snp.makeConstraints { make in
      make.height.equalTo(37)
    }
  }
  
  private func setAttribute() {
    self.allowsMultipleSelection = false
    self.decelerationRate = .fast
    self.showsHorizontalScrollIndicator = false
    self.delegate = self
    self.dataSource = self
    self.register(
      RoundTabCollectionViewCell.self,
      forCellWithReuseIdentifier: RoundTabCollectionViewCell.identifier
    )
  }
}

// MARK: - UICollectionViewDataSource

extension InContentsTabCollectionView: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = self.dequeueReusableCell(
      withReuseIdentifier: RoundTabCollectionViewCell.identifier,
      for: indexPath
    ) as? RoundTabCollectionViewCell
    cell?.configure(name: items[indexPath.item])
    
    return cell ?? RoundTabCollectionViewCell()
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return items.count
  }
}

// MARK: - UICollectionViewDelegate

extension InContentsTabCollectionView: UICollectionViewDelegate {
  public func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    self.scrollToItem(
      at: indexPath,
      at: .centeredHorizontally,
      animated: true
    )
    selectedPage.accept(indexPath.item)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension InContentsTabCollectionView: UICollectionViewDelegateFlowLayout {
  public func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return RoundTabCollectionViewCell.fittingSize(
      availableHeight: 37,
      name: items[indexPath.item]
    )
  }
}
