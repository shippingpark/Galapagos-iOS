//
//  UnderHeaderTabCollectionView.swift
//  SiriUIKit
//
//  Created by 박혜운 on 2023/10/14.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import RxCocoa
import UIKit

final class UnderHeaderTabCollectionView: UICollectionView, DynamicTabCollectionViewProtocol {
  // MARK: - UI
  
  private let hightlightView: UIView = {
    let view = UIView()

    view.backgroundColor = .black
    view.clipsToBounds = true
    view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    view.layer.allowsEdgeAntialiasing = true // 잔상 해결
    view.layer.cornerRadius = 2
    return view
  }()
  
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
    flowLayout.minimumInteritemSpacing = 16
    flowLayout.scrollDirection = .horizontal
    flowLayout.sectionInset = .init(top: 0, left: 24, bottom: 0, right: 24)
    super.init(frame: .zero, collectionViewLayout: flowLayout)
    self.setAddSubView()
    self.setConstraint()
    self.setAttribute()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Methods
  
  public func selectedTap(at index: Int) { // 필요 시 활성화
    let indexPath = IndexPath(item: index, section: 0)
    self.selectItem(at: indexPath, animated: false, scrollPosition: .right)
    self.collectionView(self, didSelectItemAt: indexPath)
  }
  
  private func setAddSubView() {
    self.addSubview(self.hightlightView)
    self.addSubview(self.hightlightView)
  }
  
  private func setConstraint() {
    self.snp.makeConstraints { make in
      make.height.equalTo(49)
    }
  }
  
  private func setAttribute() {
    self.clipsToBounds = true
    self.decelerationRate = .fast
    self.showsHorizontalScrollIndicator = false
    self.delegate = self
    self.dataSource = self
    self.register(
      TextTabCollectionViewCell.self,
      forCellWithReuseIdentifier: TextTabCollectionViewCell.identifier
    )
  }
}


// MARK: - UICollectionViewDataSource

extension UnderHeaderTabCollectionView: UICollectionViewDataSource {
  public func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = self.dequeueReusableCell(
      withReuseIdentifier: TextTabCollectionViewCell.identifier,
      for: indexPath) as? TextTabCollectionViewCell
    
    cell?.configure(name: items[indexPath.item])
    
    return cell ?? TextTabCollectionViewCell()
  }
  
  public func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return items.count
  }
}

// MARK: - UICollectionViewDelegate

extension UnderHeaderTabCollectionView: UICollectionViewDelegate {
  public func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    guard let cell = self.cellForItem(at: indexPath) else { return }
    
    hightlightView.snp.remakeConstraints { make in
      make.bottom.equalTo(cell.snp.bottom) // 잔상처리
      make.height.equalTo(3)
      make.leading.equalTo(cell.snp.leading)
      make.trailing.equalTo(cell.snp.trailing)
    }
    
    UIView.animate(withDuration: 0.0) { [weak self] in
      self?.layoutIfNeeded()
    }
    selectedPage.accept(indexPath.item)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension UnderHeaderTabCollectionView: UICollectionViewDelegateFlowLayout {
  public func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return TextTabCollectionViewCell.fittingSize(
      availableHeight: 49,
      name: items[indexPath.item]
    )
  }
}
