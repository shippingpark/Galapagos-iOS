//
//  GalapagosTextField.swift
//  SiriUIKit
//
//  Created by 조용인 on 2023/06/29.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import SnapKit

public final class GalapagosTextField_SelectEmail: UIView{
    
    // MARK: - UI
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = placeHolder
        textField.borderStyle = .none
        textField.keyboardType = keyboardType
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private lazy var errorMessagelabel: UILabel = {
        let label = UILabel()
        label.text = errorMessage
        label.textColor = SiriUIKitAsset.redErrorText.color
        label.semanticContentAttribute = .forceLeftToRight
        label.font = SiriUIKitFontFamily.Pretendard.regular.font(size: 12)
        return label
    }()
    
    private lazy var fullStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(errorMessagelabel)
        stackView.axis = .vertical
        stackView.spacing = 6
        return stackView
    }()
    
    // MARK: - Properties
    
    private var textFieldStyle: Style = .normal
    
    private var placeHolder: String
    private var keyboardType: UIKeyboardType
    private var errorMessage: String
    
    public var isEnable: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    
    public var style: Style {
      get { return textFieldStyle }
      set {
        self.textFieldStyle = newValue
        configureColorSet()
      }
    }
    
    // MARK: - Initializers
    public init(
        placeHolder: String,
        keyboardType: UIKeyboardType,
        errorMessage: String = ""
    ) {
        self.placeHolder = placeHolder
        self.keyboardType = keyboardType
        self.errorMessage = errorMessage
        super.init(frame: .zero)
        
        textField.delegate = self
        setAddSubView()
        setConstraint()
        self.configureColorSet()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - LifeCycle
    
    // MARK: - Methods
    
    private func setAddSubView() {
        self.addSubview(fullStackView)
    }
    
    private func setConstraint() {
        fullStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
    }
    
}

private extension GalapagosTextField_SelectEmail{
    typealias EmailSelectColorSet = (borderColor: UIColor, errorIsHidden: Bool, errorColor: UIColor, errorHidden: Bool)
    
    var colorSet: EmailSelectColorSet{
        switch self.textFieldStyle{
        case .normal:
            self.isEnable.accept(false)
            return (SiriUIKitAsset.gray6DisableBtnBg.color, true, SiriUIKitAsset.whiteDefaultText.color, true)
        case .enabled:
            self.isEnable.accept(false)
            return (SiriUIKitAsset.green.color, true, SiriUIKitAsset.whiteDefaultText.color, true)
        case .error:
            self.isEnable.accept(false)
            return (SiriUIKitAsset.redErrorText.color, false, SiriUIKitAsset.redErrorText.color, false)
        case .filled:
            self.isEnable.accept(true)
            return (SiriUIKitAsset.gray6DisableBtnBg.color, true, SiriUIKitAsset.green.color, true)
        }
    }
    
    func configureColorSet() {
        let colorSet = self.colorSet
        
        self.clipsToBounds = true
        self.layer.borderColor = colorSet.borderColor.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 8
        self.errorMessagelabel.textColor = colorSet.errorColor
        self.errorMessagelabel.isHidden = colorSet.errorHidden
    }
}

extension GalapagosTextField_SelectEmail{
    public enum Style {
        case normal     /// 입력 전, 입력 완료 후 상태
        case enabled    /// 필드에 포커스가 들어와있는 상태
        case error      /// error가 방출 된 상태
        case filled     /// 인증이 완료된 상태
    }
    
}

extension GalapagosTextField_SelectEmail: UITextFieldDelegate {
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.style = .enabled
        return true
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.style = .filled
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}
