//
//  MainViewModel.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/11.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewModel: ViewModelType {
    struct Input {
        let buttonTapped: Signal<Void>
    }
    struct Output {}
    
    var disposeBag: DisposeBag = DisposeBag()
    weak var coordinator: MainCoordinator?
    
    init(
        coordinator: MainCoordinator
    ) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        input.buttonTapped
            .emit(onNext: { [weak self] _ in
                self?.coordinator?.userActionState.accept(.detailDiary)
            })
            .disposed(by: disposeBag)
        
        return Output()
    }
}
