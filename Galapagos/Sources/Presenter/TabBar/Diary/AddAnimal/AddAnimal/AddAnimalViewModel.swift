//
//  AddAnimalViewModel.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/20.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

class AddAnimalViewModel: ViewModelType {
  struct Input {
    let backButtonTapped: Signal<Void>
  }
  
  struct Output {}
  
  var disposeBag: DisposeBag = DisposeBag()
  weak var coordinator: AddAnimalCoordinator?
  
  init(coordinator: AddAnimalCoordinator) {
    self.coordinator = coordinator
  }
  
  func transform(input: Input) -> Output {
    input.backButtonTapped
      .emit(onNext: { [weak self] _ in
        self?.coordinator?.finish()
      })
      .disposed(by: disposeBag)
    return Output()
  }
}

