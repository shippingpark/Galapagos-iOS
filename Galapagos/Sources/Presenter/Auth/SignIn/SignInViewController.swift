//
//  SignInViewController.swift
//  Galapagos
//
//  Created by 조용인 on 2023/06/07.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit

class SignInViewController: BaseViewController {

    private let viewModel: SignInViewModel
    
    init(
        viewModel: SignInViewModel
    ) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = GalapagosAsset.redText.color
    }
    
    override func setConstraint() {
        
    }
    
    override func setAddSubView() {
        
    }


}
