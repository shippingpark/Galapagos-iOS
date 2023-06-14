//
//  IndecatorView.swift
//  Galapagos
//
//  Created by 조용인 on 2023/05/23.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit

open class IndicatorView {
  static let shared = IndicatorView()
  
  let containerView = UIView()
  let activityIndicator = UIActivityIndicatorView()
  
  open func show() {
    let window = UIWindow(frame: UIScreen.main.bounds)
    
    let scenes = UIApplication.shared.connectedScenes
    let windowScene = scenes.first as? UIWindowScene
    let firstWindow = windowScene?.windows.first
    
    self.containerView.frame = window.frame
    self.containerView.center = window.center
    self.containerView.backgroundColor = .clear
    
    self.containerView.addSubview(self.activityIndicator)
    firstWindow?.addSubview(self.containerView)
  }
  
  open func showIndicator() {
    DispatchQueue.main.async {
      self.containerView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
      
      self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
      self.activityIndicator.style = .large
      self.activityIndicator.color = UIColor(red: 128, green: 128, blue: 128, alpha: 1.0)
      self.activityIndicator.center = self.containerView.center
      self.activityIndicator.startAnimating()
    }
  }
  
  open func dismiss() {
    DispatchQueue.main.async {
      self.activityIndicator.stopAnimating()
      self.containerView.removeFromSuperview()
    }
  }
}
