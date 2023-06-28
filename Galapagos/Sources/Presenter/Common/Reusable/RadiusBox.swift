//
//  shadowView.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/21.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit


class RadiusBoxView: UIView {
  private var radius: RadiusSize
  private var style: BoxStyle
  
  public enum radiusSize {
    case small
    case large
  }
  
  public init(radius: RadiusSize, style: BoxStyle) {
    self.radius = radius
    self.style = style
    super.init(frame: .zero)
    
    self.configureRadiusSet()
    self.configureStyleSet()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Methods
  
  private func configureRadiusSet() {
    self.backgroundColor = .white // 배경색 설정
    self.layer.cornerRadius = CGFloat(self.radius.rawValue) // 곡률 설정
  }
  
  private func configureStyleSet() {
    switch style {
    case .line:
      self.layer.borderWidth = 1.0
      self.layer.borderColor = GalapagosAsset.gray5OutLine.color.cgColor
      self.layer.shadowColor = GalapagosAsset.whiteDefaultText.color.cgColor
    case .shadow:
      self.layer.shadowColor = GalapagosAsset.blackHeading.color.withAlphaComponent(0.12).cgColor
      self.layer.shadowOffset = CGSize(width: 0, height: 3)
      self.layer.shadowRadius = 20.0 //Blur
      self.layer.shadowOpacity = 1.0
    }
    self.layer.masksToBounds = false
  }
}
    

// MARK: - RadiusBoxView.StyleType
extension RadiusBoxView {
  public enum RadiusSize: Int {
    case numberBox = 5
    case defaultSmall = 8
    case defaultLarge = 12
  }
  
  public enum BoxStyle {
    case shadow
    case line
  }
}
