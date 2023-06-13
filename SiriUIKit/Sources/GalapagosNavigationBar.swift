//
//  GalapagosNavigationBar.swift
//  SiriUIKit
//
//  Created by 조용인 on 2023/06/13.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit
import SnapKit

public final class GalapagosNavigationBarView: BaseView {
    
    // MARK: - UI
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(SiriUIKitAsset.arrowL24x24.image, for: .normal)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = SiriUIKitFontFamily.Pretendard.bold.font(size: 18)
        label.textColor = SiriUIKitAsset.blackHeading.color
        return label
    }()
    
    private lazy var rightItemStack: UIStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .equalSpacing
        horizontalStackView.spacing = 8
        return horizontalStackView
    }()
    
    // MARK: - Properties
    
    // MARK: - Initializers
    
    // MARK: - Methods
    override func setAddSubView() {
        super.setAddSubView()
        self.addSubview(backButton)
        self.addSubview(rightItemStack)
    }
    
    override func setConstraint() {
        super.setConstraint()
        
        self.rightItemStack.snp.makeConstraints{ horizontalStack in
            horizontalStack.centerY.equalToSuperview()
            horizontalStack.trailing.equalToSuperview().offset(24)
        }
        
        self.backButton.snp.makeConstraints { backButton in
            backButton.centerY.equalToSuperview()
            backButton.leading.equalToSuperview().offset(24)
        }
    }
    
    public func setTitleText(_ text: String?) {
        self.addSubview(self.titleLabel)
        
        self.titleLabel.text = text
        self.titleLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
    }
    
    public func addRightButton(_ button: UIButton) {
        self.rightItemStack.addArrangedSubview(button)
    }
    
    public func setBackButton() {
        self.addSubview(self.backButton)
        
        backButton.snp.makeConstraints{ backButton in
            backButton.centerY.equalToSuperview()
            backButton.leading.equalToSuperview().offset(24)
            backButton.height.width.equalTo(24)
        }
    }
}
