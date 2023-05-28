//
//  SplashViewController.swift
//  Galapagos
//
//  Created by 조용인 on 2023/05/23.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit
import Then
import SnapKit

class SplashViewController: BaseViewController {
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "chevron_left.png")
        return imageView
    }()
    
    private let viewModel: SplashViewModel
    
    init(
        viewModel: SplashViewModel
    ) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.CheckAutoSignIn()
    }
    
    override func setConstraint() {
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.height.equalTo(140)
            make.horizontalEdges.equalToSuperview().inset(50)
        }
    }
    
    override func setAddSubView() {
        view.addSubview(logoImageView)
    }
}
