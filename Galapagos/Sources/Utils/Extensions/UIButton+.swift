//
//  UIButton+.swift
//  Galapagos
//
//  Created by 조용인 on 2023/05/23.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit

extension UIButton {
	
	func setUnderlineTitle(
		_ title: String,
		withUnderlineStyle underlineStyle: NSUnderlineStyle = .single,
		baselineOffset: NSNumber = 3,
		font: UIFont,
		color: UIColor
	) {
		let attributes: [NSAttributedString.Key: Any] = [
			.underlineStyle: underlineStyle.rawValue,
			.baselineOffset : baselineOffset,
			.font: font,
			.foregroundColor: color
		]
		let attributedString = NSMutableAttributedString(string: title)
		attributedString.addAttributes(attributes, range: NSRange(location: 0, length: title.count))
		self.setAttributedTitle(attributedString, for: .normal)
	}
}
