//
//  AddPetContainderView.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/10/17.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import RxCocoa
import RxSwift
import SiriUIKit
import UIKit


final class AddPetContainerView<T: UIView>: UIView {
  
  // MARK: - UI
  
  private let label: UILabel = {
    let label = UILabel()
    label.textColor = GalapagosAsset.gray2CaptionSmallPlaceholderText.color
    label.font = GalapagosFontFamily.Pretendard.medium.font(size: 16)
    return label
  }()
  
  fileprivate var button = {
    let button = UIButton()
    button.setImage(GalapagosAsset._20x20checkRoundDefault.image, for: .normal)
    button.setImage(GalapagosAsset._20x20checkRoundActive.image, for: .selected)
    button.contentMode = .scaleAspectFill
    return button
  }()
  
  private let buttonInfo = {
    let label = UILabel()
    label.text = "대표동물로 설정"
    label.textColor = GalapagosAsset.gray1Body.color
    label.font = GalapagosFontFamily.Pretendard.medium.font(size: 14)
    return label
  }()
  
  private let contentView: T
  
  
  // MARK: - Properties
  
  private var title: String = ""
  private let checkButtonType: CheckButton
  fileprivate let buttonSelectedSubject = PublishSubject<Bool>()
  private let disposeBag = DisposeBag()
  
  
  // MARK: - Initialize
  
  init(
    title: String,
    checkButton: CheckButton,
    contentView: T
  ) {
    self.title = title
    self.checkButtonType = checkButton
    self.contentView = contentView
    
    self.label.text = title
    if case let .use(title) = checkButton {
      self.buttonInfo.text = title
    }
    super.init(frame: .zero)
    
    setAddSubView()
    setConstraint()
    bind()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Methods
  
  private func setAddSubView() {
    self.addSubviews([
      label,
      button,
      buttonInfo,
      contentView
    ])
  }
  
  private func setConstraint() {
    label.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.equalToSuperview()
    }
    
    contentView.snp.makeConstraints { make in
      make.top.equalTo(label.snp.bottom).offset(12)
      make.horizontalEdges.equalToSuperview()
      make.bottom.equalToSuperview()
    }
    
    guard case .use = self.checkButtonType else { return }
    
    buttonInfo.snp.makeConstraints { make in
      make.centerY.equalTo(label.snp.centerY)
      make.trailing.equalToSuperview()
    }
    
    button.snp.makeConstraints { make in
      make.centerY.equalTo(label.snp.centerY)
      make.trailing.equalTo(buttonInfo.snp.leading).offset(-6)
    }
  }
  
  private func bind() {
    button.rx.tap
      .bind { [weak self] in
        self?.button.isSelected.toggle()
        self?.buttonSelectedSubject.onNext(self?.button.isSelected ?? false)
      }
      .disposed(by: disposeBag)
  }
}


extension AddPetContainerView {
  public enum CheckButton {
    case use(title: String)
    case unused
  }
}

extension Reactive where Base: 
AddPetContainerView<AddPetCalendarTextFieldView> {
  var isSelected: Observable<Bool> {
    return base.buttonSelectedSubject.asObservable()
  }
}

extension Reactive where Base:
AddPetContainerView<GalapagosTextField> {
  var isSelected: Observable<Bool> {
    return base.buttonSelectedSubject.asObservable()
  }
}
