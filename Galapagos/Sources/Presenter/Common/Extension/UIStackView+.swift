//
//  UIStackView+.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/10/17.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit

extension UIStackView {
  func addArrangedSubviews(_ subviews: [UIView]) {
    subviews.forEach(self.addArrangedSubview)
  }
}
