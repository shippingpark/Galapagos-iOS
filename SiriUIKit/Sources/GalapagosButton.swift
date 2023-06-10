//
//  GalapagosButton.swift
//  Galapagos
//
//  Created by 조용인 on 2023/06/09.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit
import SnapKit
import Then

public final class GalapagosButton: UIButton{
    
    //MARK: - UI
    
    //MARK: - Properties
    private var buttonStyle: Style
    private var isCircle: Bool
    
    var active: Bool {
        get {return self.isEnabled }
        set {
            self.isEnabled = newValue
//            configureColorSet()
        }
    }
    
    var style: Style {
        get { return buttonStyle }
        set {
            self.buttonStyle = newValue
            configureColorSet()
        }
    }
    
    //MARK: - Initializers
    
    /// 버튼의 `style`과 `cornerRadius`와 `active` 을 선택할 수 있습니다.
    /// - Parameters:
    ///   - buttonStyle: 버튼의 타입을 설정합니다.
    ///   - isEnable: 버튼의 활성화 여부를 판별합니다.
    ///   - isCircle: `cornerRadius`와 관계 없이 버튼을 원으로 구성합니다.
    public init(buttonStyle: Style, isEnable: Bool = true, isCircle: Bool = false) {
        self.buttonStyle = buttonStyle
        self.isCircle = isCircle
        super.init(frame: .zero)
        
        self.active = isEnable
        self.layer.cornerRadius = 6.0   /// 기본은 6, 로그인만 8
        self.titleLabel?.font = GalapagosFontFamily.Pretendard.semiBold.font(size: 16)
        self.configureColorSet()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - LifeCycle
    
    //MARK: - Methods
    public override func layoutSubviews() {
        super.layoutSubviews()
        /// 레이아웃이 그려질 때, isCircle을 감지하여 변환
        if isCircle {
            let cornerRadius = self.frame.height / 2
            self.layer.cornerRadius = cornerRadius
        }
    }
}

// MARK: - Privates
private extension GalapagosButton {
    
    typealias ColorSet = (borderColor: UIColor, fillColor: UIColor, textColor: UIColor)
    
    var colorSet: ColorSet {
        switch self.buttonStyle {
        case .fill:
            return self.active ?
            (GalapagosAsset.green.color, GalapagosAsset.green.color, GalapagosAsset.white기본Text.color) :
            (GalapagosAsset.gray6DisableBtnBg.color, GalapagosAsset.gray6DisableBtnBg.color, GalapagosAsset.gray3DisableText1.color)
        case .outline:
            return (GalapagosAsset.gray5DisableText2.color, GalapagosAsset.white기본Text.color, GalapagosAsset.gray1본문.color)
        case .boldOutline:
            return (GalapagosAsset.gray1본문.color, GalapagosAsset.white기본Text.color, GalapagosAsset.gray1본문.color)
        }
    }
    
    func configureColorSet() {
        let colorSet = self.colorSet
        
        self.clipsToBounds = true
        self.layer.borderColor = colorSet.borderColor.cgColor
        self.layer.borderWidth = 1.0
        self.backgroundColor = colorSet.fillColor
        self.setTitleColor(colorSet.textColor, for: .normal)
        
    }
}

// MARK: - GalapagosButton.ButtonType
extension GalapagosButton {
    public enum Style {
        case fill
        case outline
        case boldOutline
    }
}
