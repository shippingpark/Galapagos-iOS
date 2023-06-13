//
//  EmailSignUpViewController.swift
//  Galapagos
//
//  Created by 조용인 on 2023/06/07.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit
import SnapKit
import SiriUIKit

class EmailSignUpViewController: BaseViewController {

    //MARK: - UI
    private lazy var mockLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일 회원가입 페이지"
        label.textColor = GalapagosAsset.green.color
        label.font = GalapagosFontFamily.Pretendard.bold.font(size: 36)
        return label
    }()
    
    private lazy var navigationBar: GalapagosNavigationBarView = {
        let navigationBar = GalapagosNavigationBarView()
        navigationBar.setTitleText("")
        return navigationBar
    }()
    
    //MARK: - Properties
    private let viewModel: EmailSignUpViewModel
    
    //MARK: - Initializers
    init(
        viewModel: EmailSignUpViewModel
    ) {
        self.viewModel = viewModel
        super.init()
    }
    
    //MARK: - LifeCycle
    
    //MARK: - Methods
    
    override func setConstraint() {
        navigationBar.snp.makeConstraints{ navigationBar in
            navigationBar.top.equalTo(self.view.safeAreaLayoutGuide)
            navigationBar.leading.trailing.equalToSuperview()
            navigationBar.height.equalTo(50)
        }
        
        mockLabel.snp.makeConstraints{ mockLabel in
            mockLabel.centerX.equalToSuperview()
            mockLabel.centerY.equalToSuperview()
        }
    }
    
    override func setAddSubView() {
        self.view.addSubviews([
            navigationBar,
            mockLabel
        ])
    }

}
