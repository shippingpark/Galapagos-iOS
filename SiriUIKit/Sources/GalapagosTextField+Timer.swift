//
//  GalapagosTextField+Timer.swift
//  SiriUIKit
//
//  Created by 조용인 on 2023/07/04.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import SnapKit

public final class GalapagosTextField_Timer: UIView {
    // MARK: - UI
    
    private lazy var certifyInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일로 전송된 인증코드를 입력해주세요."
        label.textColor = SiriUIKitAsset.gray1Main.color
        label.font = SiriUIKitFontFamily.Pretendard.regular.font(size: 14)
        return label
    }()
    
    private lazy var galapagosTextField: GalapagosTextField = {
        let textField = GalapagosTextField(
            placeHolder: "인증코드 6자리 입력",
            keyboardType: .numberPad,
            clearMode: .whileEditing
        )
        return textField
    }()
    
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = startTime
        label.textColor = SiriUIKitAsset.green.color
        label.font = SiriUIKitFontFamily.Pretendard.medium.font(size: 16)
        return label
    }()
    
    private lazy var checkButton: GalapagosButton = {
        let button = GalapagosButton(buttonStyle: .fill, isEnable: false)
        button.setTitle("확인", for: .normal)
        button.titleLabel?.font = SiriUIKitFontFamily.Pretendard.semiBold.font(size: 16)
        return button
    }()
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private let timerSubject = PublishSubject<Int>()
    private let startTime: String
    
    private var timer: Disposable?
    private var MAX_TIME: Int
    
    
    // MARK: - Initializers
    
    public init(MAX_TIME: Int, startTime: String){
        self.MAX_TIME = MAX_TIME
        self.startTime = startTime
        super.init(frame: .zero)
        startTimer()
        addSubview()
        setConstraints()
        bind()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    
    }
    // MARK: - Methods
    
    private func addSubview(){
        addSubview(certifyInfoLabel)
        addSubview(galapagosTextField)
        addSubview(timerLabel)
        addSubview(checkButton)
    
    }
    
    private func setConstraints(){
        certifyInfoLabel.snp.makeConstraints {
            $0.top.leading.equalTo(self)
        }
        
        galapagosTextField.snp.makeConstraints {
            $0.top.equalTo(certifyInfoLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(self)
            $0.height.equalTo(68)
        }
        
        timerLabel.snp.makeConstraints {
            $0.centerY.equalTo(galapagosTextField)
            $0.trailing.equalTo(galapagosTextField).offset(-80)
            $0.width.equalTo(54)
        }
    
        checkButton.snp.makeConstraints {
            $0.centerY.equalTo(galapagosTextField)
            $0.leading.equalTo(timerLabel.snp.trailing).offset(10)
            $0.trailing.equalTo(galapagosTextField.snp.trailing).offset(-20)
            $0.height.equalTo(38)
        }
    }
    
    private func bind(){
        timerSubject
            .withUnretained(self)
            .subscribe(onNext: { owner, time in
                if time >= 0 {
                    let minutes = time / 60
                    let seconds = time % 60
                    let formattedTime = String(format: "%02d:%02d", minutes, seconds)
                    owner.timerLabel.text = formattedTime
                } else {
                    owner.timer?.dispose()
                    self.MAX_TIME = 10
                }
            })
            .disposed(by: disposeBag)
        
        galapagosTextField.textField.rx.controlEvent(.editingChanged)
            .observe(on: MainScheduler.asyncInstance)
            .withUnretained(self)
            .subscribe(onNext: {  owner, editting in
                let count = owner.galapagosTextField.textField.text?.count ?? 0
                if count == 6 {
                    owner.checkButton.active = true
                } else if count > 6 {
                    owner.galapagosTextField.textField.deleteBackward()
                } else {
                    owner.checkButton.active = false
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func startTimer() {
        timer = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .take(MAX_TIME + 1)
            .map { self.MAX_TIME - $0 }
            .withUnretained(self)
            .subscribe(onNext: { owner, time in
                owner.timerSubject.onNext(time)
            })
    }
}
