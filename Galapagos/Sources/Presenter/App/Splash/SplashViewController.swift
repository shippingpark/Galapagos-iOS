//
//  SplashViewController.swift
//  Galapagos
//
//  Created by 조용인 on 2023/05/23.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit
import Then

class SplashViewController: BaseViewController {

    private lazy var logoImage = UIImageView().then{ logoImage in
        logoImage.contentMode = .scaleAspectFit
        logoImage.image = UIImage()
    }
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
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
    }
    
    override func setAttribute() {
        <#code#>
    }
    
    override func setConstraint() {
        <#code#>
    }
    
    override func setAddSubView() {
        <#code#>
    }
}
