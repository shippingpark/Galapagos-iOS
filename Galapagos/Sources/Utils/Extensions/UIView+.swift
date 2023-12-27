//
//  UIView+.swift
//  Galapagos
//
//  Created by 조용인 on 2023/05/23.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxGesture

@IBDesignable
extension UIView {
	
	var navigationBarToContentsOffset: CGFloat {
		return 40 // 세로도 화면 비율로 가져가는 게 좋을지
	}
	
	var contentsToContentsOffset: CGFloat {
		return 60 // 세로도 화면 비율로 가져가는 게 좋을지
	}
	
	var galpagosHorizontalOffset: CGFloat {
		return UIScreen.main.bounds.width / 16.25 // 좌우 간격
	}
	
	func addSubviews(_ subviews: [UIView]) {
		subviews.forEach(self.addSubview)
	}
	
	func animateClick(completion: @escaping () -> Void) {
		UIView.animate(withDuration: 0.03) {
			self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
		} completion: { _ in
			UIView.animate(withDuration: 0.03) {
				self.transform = CGAffineTransform.identity
			} completion: { _ in
				completion()
			}
		}
	}
}

extension Reactive where Base: UIView {
	public func tapped() -> ControlEvent<Void> {
		let source = self.base.rx.tapGesture().when(.recognized).map { _ in }
		return ControlEvent(events: source)
	}
}
