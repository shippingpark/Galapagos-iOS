//
//  SignUpViewController.swift
//  Galapagos
//
//  Created by 조용인 on 2023/06/07.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController {

    private let viewModel: SignUpViewModel
    
    init(
        viewModel: SignUpViewModel
    ) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        label.text = "SignUp"
        self.view.addSubview(label)
    }
    
    override func setConstraint() {
        
    }
    
    override func setAddSubView() {
        
    }

}
