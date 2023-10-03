//
//  AddAnimalViewTextLabel.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/07/07.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit

class AddAnimalViewTextLabel: UILabel {
  let title: String
  
  init(title: String) {
    self.title = title
    super.init(frame: .zero)
    setAttribute()
  }
      
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
      
  private func setAttribute() {
    self.text = title
    self.textColor = GalapagosAsset.gray2주석CaptionSmall힌트PlaceholderText.color
    self.font = GalapagosFontFamily.Pretendard.medium.font(size: 16)
  }
}
