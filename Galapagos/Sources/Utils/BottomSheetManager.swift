//
//  BottomSheetManager.swift
//  SiriUIKit
//
//  Created by 박혜운 on 2023/11/29.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import RxSwift
import UIKit

public final class BottomSheetManager {
  
  // MARK: - UI
  private var newBottomSheet: GalapagosBottomSheetViewController?
  
  private let backgroundView: UIView = {
    let view = UIView()
    view.backgroundColor = .black.withAlphaComponent(0.7)
    return view
  }()
  
  // MARK: - Properties
  
  public static let shared = BottomSheetManager()
  private let disposeBag: DisposeBag = DisposeBag()
  
  // MARK: - Initializer
  
  private init() {}
  
  public func showBottomSheet(title: String, content: Any, bottomButtonTitle: String) {
    newBottomSheet = GalapagosBottomSheetViewController(
      title: title,
      content: content,
      bottom: {
        let button = GalapagosButton(
          isRound: false,
          iconTitle: nil,
          type: .fill,
          title: bottomButtonTitle
        )
        
        button.rx.tap
          .subscribe(
            onNext: {
              self.closeBottomSheet()
            }
          )
          .disposed(by: self.disposeBag)
        
        return button
      }()
    )
    
    guard let newBottomSheet = newBottomSheet else { return }
    
    // 현재 활성화된 WindowScene을 가져옵니다.
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
      if newBottomSheet.parent != nil {
        newBottomSheet.willMove(toParent: nil)
        newBottomSheet.view.removeFromSuperview()
        newBottomSheet.removeFromParent()
      }
      if let window = windowScene.windows.first {
        window.addSubview(backgroundView)
        backgroundView.addSubview(newBottomSheet.view)
        newBottomSheet.didMove(toParent: window.rootViewController)
        
        backgroundView.frame = window.bounds
        backgroundView.snp.makeConstraints { make in
          make.edges.equalToSuperview()
        }
        
        newBottomSheet.view.snp.makeConstraints { make in
          make.top.equalToSuperview() // 뷰를 전체 당기고, 바텀시트 내부 실제 바텀시트가 모양을 구성하도록 생성 ⭐️
          make.bottom.equalToSuperview()
          make.leading.trailing.equalToSuperview()
        }
      }
    }
    
    backgroundView.alpha = 0.0
    newBottomSheet.view.isHidden = true
    
    backgroundView.fadeIn(
      completion: { _ in
        newBottomSheet.view.bottomToUp()
      }
    )
    
    newBottomSheet.exitButton.rx.tap
      .subscribe(
        onNext: { [weak self] _ in
          self?.closeBottomSheet()
        }
      )
      .disposed(by: disposeBag)
  }
  
  public func closeBottomSheet() {
    guard let newBottomSheet = newBottomSheet else { return }
    
    newBottomSheet.view.topToDown(
      completion: { [weak self] _ in
        self?.backgroundView.fadeOut(
          completion: { [weak self] _ in
            self?.backgroundView.removeFromSuperview()
            newBottomSheet.willMove(toParent: nil)
            newBottomSheet.view.removeFromSuperview()
            newBottomSheet.removeFromParent()
          }
        )
      }
    )
    self.newBottomSheet = nil
  }
}

extension UIView {
  fileprivate func fadeIn(duration: TimeInterval = 0.3, completion: ((Bool) -> Void)? = nil) {
    UIView.animate(
      withDuration: duration,
      animations: { self.alpha = 1.0 },
      completion: completion
    )
  }
  
  fileprivate func fadeOut(duration: TimeInterval = 0.3, completion: ((Bool) -> Void)? = nil) {
    UIView.animate(
      withDuration: duration,
      animations: { self.alpha = 0.0 },
      completion: completion
    )
  }
}

extension UIView {
  fileprivate func bottomToUp(duration: TimeInterval = 0.3) {
    self.isHidden = false
    self.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
    UIView.animate(withDuration: duration) {
      self.transform = CGAffineTransform.identity
    }
  }
  
  fileprivate func topToDown(duration: TimeInterval = 0.3, completion: ((Bool) -> Void)? = nil) {
    UIView.animate(withDuration: duration, animations: {
      self.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
    }, completion: completion)
  }
}
