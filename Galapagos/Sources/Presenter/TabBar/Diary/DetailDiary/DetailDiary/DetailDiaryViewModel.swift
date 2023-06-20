//
//  DiaryDetailViewModel.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/17.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

class DetailDiaryViewModel: ViewModelType {
  struct Input {
    let backButtonTapped: Signal<Void>
    let buttonTapped: Signal<Void>
  }
  
  struct Output {}
  
  var disposeBag: DisposeBag = DisposeBag()
  weak var coordinator: DetailDiaryCoordinator?
  
  init(coordinator: DetailDiaryCoordinator) {
    self.coordinator = coordinator
  }
  
  func transform(input: Input) -> Output {
    input.backButtonTapped
      .emit(onNext: { [weak self] _ in
        self?.coordinator?.finish()
      })
      .disposed(by: disposeBag)
    input.buttonTapped
      .emit(onNext: { [weak self] _ in
        self?.coordinator?.userActionState.accept(.addDiary)
      })
      .disposed(by: disposeBag)
    return Output()
  }
}
