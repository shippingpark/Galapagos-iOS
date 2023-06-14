//
//  EmailSignUpViewModel.swift
//  Galapagos
//
//  Created by 조용인 on 2023/06/07.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EmailSignUpViewModel: ViewModelType{
  
  struct Input {
    let backButtonTapped: Signal<Void>
  }
  
  struct Output {}
  
  var disposeBag: DisposeBag = DisposeBag()
  weak var coordinator: AuthCoordinator?
  
  init(
    coordinator: AuthCoordinator
  ) {
    self.coordinator = coordinator
  }
  
  
  func transform(input: Input) -> Output {
    
    input.backButtonTapped
      .emit(onNext: { [weak self] in
        guard let self = self else {return}
        self.coordinator?.userActionState.accept(.SignIn)
      })
      .disposed(by: disposeBag)
    
    
    return Output()
  }
  
  
}
