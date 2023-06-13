//
//  DiaryListViewModel.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/11.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation
import RxSwift

class DiaryListViewModel: ViewModelType {
  struct Input {}
  struct Output {}
  
  var disposeBag: DisposeBag = DisposeBag()
  weak var coordinator: DiaryCoordinator?
  
  init(coordinator: DiaryCoordinator) {
    self.coordinator = coordinator
  }
  
  func transform(input: Input) -> Output {
    return Output()
  }
}
