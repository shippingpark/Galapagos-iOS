//
//  MainViewController.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/11.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: BaseViewController {
    
    // MARK: - UI
    private lazy var button = UIButton()
    
    //MARK: - Properties
    private let viewModel: MainViewModel
    
    //MARK: - Initializers
    init(
        viewModel: MainViewModel
    ) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.backgroundColor = .blue
        button.setTitle("임시버튼, 다이어리 이동", for: .normal)
    }
    
    override func setAddSubView() {
        self.view.addSubview(button)
    }
    
    override func setConstraint() {
        button.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.center.equalToSuperview()
        }
    }
    
    override func bind() {
        let input = MainViewModel.Input(
            buttonTapped: button.rx.tap.asSignal()
        )
        
        let output = viewModel.transform(input: input)
        
    }
}
