//
//  SignInViewController.swift
//  Galapagos
//
//  Created by 조용인 on 2023/06/07.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit
import SnapKit
import Then
import SiriUIKit


class SignInViewController: BaseViewController {

    //MARK: - UI
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = GalapagosAsset.check24x24.image
        return imageView
    }()
    
    private lazy var appleSignInButton = GalapagosButton(buttonStyle: .fill, isCircle: true).then{
        $0.titleLabel?.font = GalapagosFontFamily.Pretendard.bold.font(size: 14)
    }
    
    //MARK: - Properties
    private let viewModel: SignInViewModel
    
    //MARK: - Initializers
    init(
        viewModel: SignInViewModel
    ) {
        self.viewModel = viewModel
        super.init()
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Methods
    override func setConstraint() {
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.height.equalTo(140)
            make.horizontalEdges.equalToSuperview().inset(50)
        }
        
        appleSignInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(48)
            make.height.equalTo(48)
            make.top.equalTo(logoImageView.snp.centerY).multipliedBy(1.9)
        }
    }
    
    override func setAddSubView() {
        self.view.addSubviews([
            logoImageView,
            appleSignInButton
        ])
    }


}
