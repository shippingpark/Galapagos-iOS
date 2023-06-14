//
//  EmailSignUpViewModel.swift
//  Galapagos
//
//  Created by 조용인 on 2023/06/07.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit
import RxSwift

class EmailSignUpViewModel: ViewModelType{
  
  struct Input {}
  
  struct Output {}
  
  var disposeBag: DisposeBag = DisposeBag()
  weak var coordinator: AuthCoordinator?
  
  init(
    coordinator: AuthCoordinator
  ) {
    self.coordinator = coordinator
  }
  
  
  func transform(input: Input) -> Output {
    return Output()
  }
  
  
}
