//
//  AddAnimalCalendarTextFieldView.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/10/17.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class AddAnimalCalendarTextFieldView: UIView {
  
  // MARK: - UI
  
  private let roundedView: UIView = {
    let view = UIView()
    view.layer.borderWidth = 1.0
    view.layer.borderColor = GalapagosAsset.gray1Outline.color.cgColor
    view.layer.cornerRadius = 6.0
    return view
  }()
  
  private let calendarButton: UIButton = {
    let button = UIButton()
    button.setImage(GalapagosAsset._24x24calendarDefault.image, for: .normal)
    return button
  }()
  
  fileprivate var label: UILabel = {
    let label = UILabel()
    label.textColor = GalapagosAsset.gray2CaptionSmallPlaceholderText.color
    label.font = GalapagosFontFamily.Pretendard.medium.font(size: 18)
    return label
  }()
  
  // MARK: - Properties
  
  var rxDate = BehaviorRelay<String>(value: "")
  private let placeHolder: String
  private let disposeBag = DisposeBag()
  
  // MARK: - Initialize
  
  init(placeHolder: String) {
    self.placeHolder = placeHolder
    
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
      roundedView
    ])
    
    self.roundedView.addSubviews([
      calendarButton,
      label
    ])
  }
  
  private func setConstraint() {
    roundedView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    label.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalToSuperview().offset(20)
    }
    
    calendarButton.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.trailing.equalToSuperview().inset(20)
    }
  }

  private func bind() {
    rxDate
      .distinctUntilChanged()
      .asDriver(onErrorJustReturn: "")
      .drive(onNext: { [weak self] date in
        guard let self = self else { return }
        
        if date.isEmpty {
          self.label.text = placeHolder
          self.label.textColor = GalapagosAsset.gray2CaptionSmallPlaceholderText.color
        } else {
          self.label.text = date
          self.label.textColor = GalapagosAsset.gray1Body.color
        }
      })
      .disposed(by: disposeBag)
  }
}

extension Reactive where Base: AddAnimalCalendarTextFieldView {
  var tap: ControlEvent<Void> {
    let source: Observable<Void> = self.base.rx.tapGesture()
      .when(.recognized)
      .map { _ in () }
    return ControlEvent(events: source)
  }
}
