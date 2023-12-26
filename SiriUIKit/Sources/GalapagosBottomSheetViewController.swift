//
//  GalapagosBottomSheetViewController.swift
//  SiriUIKit
//
//  Created by 박혜운 on 2023/11/01.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation
import UIKit

public class GalapagosBottomSheetViewController: UIViewController {
  
  // MARK: - UI
  
  private let sheetView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 20
    view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    view.clipsToBounds = true
    
    return view
  }()
  
  private var headerView: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    
    return view
  }()
  
  private var titleLabel: UILabel = {
    let label = UILabel()
    label.font = SiriUIKitFontFamily.Pretendard.semiBold.font(size: 22)
    label.textColor = SiriUIKitAsset.blackDisplayHeadingBody.color
    return label
  }()
  
  var exitButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .clear
    button.setImage(SiriUIKitAsset._24x24cancleDefault.image, for: .normal)
    
    return button
  }()
  
  private var contentView: Any
  private var bottomView: UIView

  
  // bottomSheet가 view의 상단에서 떨어진 거리
  private var bottomSheetViewTopConstraint: NSLayoutConstraint!
  private var bottomHeight: CGFloat = 0.0
  
  public init(
    title: String,
    content: Any,
    bottom: UIView
  ) {
    self.contentView = content
    self.bottomView = bottom
    self.titleLabel.text = title
    super.init(nibName: nil, bundle: nil)
    
    setAddSubView()
    setConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    bottomHeight = sheetView.frame.height
  }
  
  private func setAddSubView() {
    self.view.addSubview(sheetView)
    
    sheetView.addSubview(headerView)
    sheetView.addSubview(bottomView)
    
    headerView.addSubview(titleLabel)
    headerView.addSubview(exitButton)
    
    setView()
  }
  
  private func setView() {
    if let viewController = contentView as? UIViewController {
      addChild(viewController)
      self.sheetView.addSubview(viewController.view)
      viewController.didMove(toParent: self)
      viewController.view.snp.makeConstraints { make in
        make.horizontalEdges.equalToSuperview().inset(29.5)
        make.top.equalTo(headerView.snp.bottom)
        make.bottom.equalTo(bottomView.snp.top)
      }
    } else if let view = contentView as? UIView {
      self.sheetView.addSubview(view)
      view.snp.makeConstraints { make in
        make.horizontalEdges.equalToSuperview().inset(29.5)
        make.top.equalTo(headerView.snp.bottom)
        make.bottom.equalTo(bottomView.snp.top).inset(30)
      }
    }
  }
  
  private func setConstraint() {
    sheetView.snp.makeConstraints { make in
      make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
      make.top.equalTo(headerView)
      // make.bottom.equalTo(bottomView)
      make.bottom.equalToSuperview()
//      make.height.equalTo(200)
      // make.bottom.equalTo(view.safeAreaLayoutGuide)
    }
    
    bottomView.snp.makeConstraints { make in
      make.horizontalEdges.equalToSuperview().inset(24)
      make.bottom.equalToSuperview().inset(50)
      make.height.equalTo(56)
    }
    
    headerView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.height.equalTo(80)
      make.horizontalEdges.equalToSuperview()
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(18.5)
      make.leading.equalToSuperview().offset(30)
    }
    
    exitButton.snp.makeConstraints { make in
      make.trailing.equalToSuperview().inset(30)
      make.centerY.equalTo(titleLabel)
    }
  }
}
