//
//  RoundTabCollectionViewCell.swift
//  SiriUIKit
//
//  Created by 박혜운 on 2023/10/14.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import SnapKit
import UIKit

final class RoundTabCollectionViewCell: UICollectionViewCell {
  
  // MARK: - UI
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.textColor = SiriUIKitAsset.green.color
    label.font = SiriUIKitFontFamily.Pretendard.semiBold.font(size: 14)
    return label
  }()
  
  // MARK: - Properties
  
  static let identifier = "RoundTabCell"
  override var isSelected: Bool {
    didSet {
      backgroundColor = isSelected ? SiriUIKitAsset.green.color :
      SiriUIKitAsset.lightGreen.color
      self.titleLabel.textColor = isSelected ? .white : SiriUIKitAsset.green.color
    }
  }
  
  // MARK: - Initializers
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }
  
  // MARK: - LifeCycle
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = frame.height / 2
  }
  
  // MARK: - Methods
  
  static func fittingSize(availableHeight: CGFloat, name: String?) -> CGSize {
    let cell = RoundTabCollectionViewCell()
    cell.configure(name: name)
    
    let targetSize = CGSize(
      width: UIView.layoutFittingCompressedSize.width,
      height: availableHeight
    )
    
    return cell.contentView.systemLayoutSizeFitting(
      targetSize,
      withHorizontalFittingPriority: .fittingSizeLevel,
      verticalFittingPriority: .required
    )
  }
  
  internal func configure(name: String?) {
    titleLabel.text = name
  }
  
  private func setupView() {
    contentView.addSubview(titleLabel)
    contentView.clipsToBounds = true
    backgroundColor = SiriUIKitAsset.lightGreen.color
    
    titleLabel.snp.makeConstraints { (make) in
      make.horizontalEdges.equalToSuperview().inset(14)
      make.verticalEdges.equalToSuperview().inset(8)
    }
  }
}
