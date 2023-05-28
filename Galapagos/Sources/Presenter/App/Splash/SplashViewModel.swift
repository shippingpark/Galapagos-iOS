//
//  SplashViewModel.swift
//  Galapagos
//
//  Created by 조용인 on 2023/05/25.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit
import RxSwift

class SplashViewModel: ViewModelType{
    
    struct Input {}
    
    struct Output {}
    
    var disposeBag: DisposeBag = DisposeBag()
    weak var coordinator: AppCoordinator?
    
    init(
        coordinator: AppCoordinator
    ) {
        self.coordinator = coordinator
    }
    
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
    func CheckAutoSignIn(){
        /// 자동로그인 판별하고, state값 변경해줌
        /// 당연히, 로직 자체는 UseCase에 존재
    }
    
}
