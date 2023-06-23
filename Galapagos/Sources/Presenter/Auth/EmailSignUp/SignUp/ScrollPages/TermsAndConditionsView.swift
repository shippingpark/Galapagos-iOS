//
//  TermsAndConditionsView.swift
//  Galapagos
//
//  Created by 조용인 on 2023/06/23.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit
import SiriUIKit

import SnapKit

final class TermsAndConditionsView: BaseView {
    // MARK: - UI
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "약관동의"
        label.font = GalapagosFontFamily.Pretendard.bold.font(size: 28)
        label.textColor = GalapagosAsset.blackHeading.color
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "서비스 이용 약관에 동의해주세요"
        label.font = GalapagosFontFamily.Pretendard.regular.font(size: 16)
        label.textColor = GalapagosAsset.gray2Annotation.color
        return label
    }()
    
    
    // MARK: - Properties
    
    // MARK: - Initializers
    
    // MARK: - LifeCycle
    
    // MARK: - Methods
}
