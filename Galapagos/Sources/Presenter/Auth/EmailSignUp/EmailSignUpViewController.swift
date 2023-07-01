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
import RxSwift
import RxCocoa

class EmailSignUpViewController: BaseViewController {
    
    //MARK: - UI
    
    private lazy var navigationBar: GalapagosNavigationBarView = {
        let navigationBar = GalapagosNavigationBarView()
        navigationBar.setTitleText("")
        return navigationBar
    }()
    
    private lazy var termsAndConditionsView: TermsAndConditionsView = {
        let view = TermsAndConditionsView(frame: .zero, viewModel: viewModel)
        return view
    }()
    
    private lazy var emailCheckView: EmailCheckView = {
       let view = EmailCheckView(frame: .zero, viewModel: viewModel)
        return view
    }()
    
    private lazy var galapagosPager: GalapagosProgressPager = {
        
        
        let page3 = UIView()
        page3.backgroundColor = UIColor.yellow
        
        let page4 = UIView()
        page4.backgroundColor = UIColor.blue
        
        let page5 = UIView()
        page5.backgroundColor = UIColor.white
        
        let progressPager = GalapagosProgressPager(pages: [
            termsAndConditionsView, emailCheckView, page3, page4, page5
        ])
        return progressPager
    }()
    
    private lazy var nextButton: GalapagosButton = {
        let button = GalapagosButton(buttonStyle: .fill, isEnable: false)
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = GalapagosFontFamily.Pretendard.bold.font(size: 16)
        return button
    }()
    
    //MARK: - Properties
    private let viewModel: EmailSignUpViewModel
    
    //MARK: - Initializers
    init(
        viewModel: EmailSignUpViewModel
    ) {
        self.viewModel = viewModel
        super.init()

        setBind()
    }
    
    //MARK: - LifeCycle
    
    //MARK: - Methods
    
    override func setConstraint() {
        navigationBar.snp.makeConstraints{ navigationBar in
            navigationBar.top.equalTo(self.view.safeAreaLayoutGuide)
            navigationBar.leading.trailing.equalToSuperview()
            navigationBar.height.equalTo(50)
        }
        
        galapagosPager.snp.makeConstraints{ galapagosPager in
            galapagosPager.top.equalTo(navigationBar.snp.bottom).offset(10)
            galapagosPager.leading.trailing.equalToSuperview()
            galapagosPager.bottom.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints{ nextButton in
            nextButton.centerX.equalToSuperview()
            nextButton.width.equalToSuperview().multipliedBy(0.9)
            nextButton.bottom.equalToSuperview().inset(50)
            nextButton.height.equalTo(56)
        
        }
    
    }
    
    override func setAddSubView() {
        self.view.addSubviews([
            navigationBar,
            galapagosPager,
            nextButton
        ])
    }
    
    private func setBind() {
        let input = EmailSignUpViewModel.Input(
            backButtonTapped: navigationBar.backButton.rx.tap.asSignal(),
            nextButtonTapped: nextButton.rx.tap.asSignal()
        )
        
        let output = viewModel.transform(input: input)
        
        output.scrollTo
            .withUnretained(self)
            .take(galapagosPager.pagesCount - 1)
            .subscribe(onNext: { owner, next in
                owner.galapagosPager.nextPage(animated: true, next: CGFloat(next))
            })
            .disposed(by: disposeBag)
        
        output.readyForNextButton
            .drive(nextButton.rx.isActive)
            .disposed(by: disposeBag)
    }
}
