//
//  TextTabCollectionViewCell.swift
//  SiriUIKit
//
//  Created by 박혜운 on 2023/10/14.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit

final class TextTabCollectionViewCell: UICollectionViewCell {
  
  // MARK: - UI
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = SiriUIKitFontFamily.Pretendard.semiBold.font(size: 14)
    label.textColor = SiriUIKitAsset.black제목DisplayHeadingBody.color
    label.textAlignment = .center
    label.backgroundColor = .white
    return label
  }()
  
  // MARK: - Properties
  
  static let identifier = "TextTabCell"
  override var isSelected: Bool {
    didSet {
      titleLabel.textColor = isSelected ?
      SiriUIKitAsset.black제목DisplayHeadingBody.color :
      SiriUIKitAsset.gray1Outline.color
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
  }
  
  // MARK: - Methods
  
  static func fittingSize(
    availableHeight: CGFloat,
    name: String?
  ) -> CGSize {
    let cell = TextTabCollectionViewCell()
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
    
    titleLabel.snp.makeConstraints { make in
      make.horizontalEdges.equalToSuperview().inset(2)
      make.verticalEdges.equalToSuperview()
    }
  }
}
