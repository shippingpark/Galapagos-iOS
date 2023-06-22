//
//  shadowView.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/21.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
      self.backgroundColor = .white // 배경색 설정
      self.layer.cornerRadius = 8.0 // 곡률 설정
      self.layer.shadowColor = GalapagosAsset.blackHeading.color.withAlphaComponent(0.12).cgColor
      self.layer.shadowOffset = CGSize(width: 0, height: 3)
      self.layer.shadowRadius = 20.0 //Blur
      self.layer.shadowOpacity = 1.0
      self.layer.masksToBounds = false
    }
}
