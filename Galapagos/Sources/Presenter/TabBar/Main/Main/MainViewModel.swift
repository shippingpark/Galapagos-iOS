//
//  MainViewModel.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/11.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class MainViewModel: ViewModelType {
  struct Input {
    let addPetButtonTapped: Signal<Void>
    let moveCommunityTapped: Signal<Void>
    let moveMainPetDiaryTapped: Signal<Void>
  }
  
  struct Output {
    let hasMainPet: Driver<Bool> // 값을 가지고 오기 때문에 실제 적용 시 Bool 아닌 해당 Model 정보를 가져오는 게 좋을 듯 (isEmpty로 유무 판별)
    let hasStarCommunity: Driver<Bool> //
  }
  
  var disposeBag: DisposeBag = DisposeBag()
  weak var coordinator: MainCoordinator?
  
  init(coordinator: MainCoordinator) {
    self.coordinator = coordinator
  }
  
  func transform(input: Input) -> Output {
    input.addPetButtonTapped
      .emit(onNext: { [weak self] _ in
        self?.coordinator?.destination.accept(.addPet)
      })
      .disposed(by: disposeBag)
    
    input.moveCommunityTapped
      .emit(onNext: { [weak self] _ in
        self?.coordinator?.destination.accept(.moveCommunity)
      })
      .disposed(by: disposeBag)
    
    input.moveMainPetDiaryTapped
      .emit(onNext: { [weak self] _ in
        self?.coordinator?.destination.accept(.mainPetDiary)
      })
      .disposed(by: disposeBag)
    
    return Output(
      hasMainPet: Driver.just(false), // 강제 입력
      hasStarCommunity: Driver.just(false)
    )
  }
}
