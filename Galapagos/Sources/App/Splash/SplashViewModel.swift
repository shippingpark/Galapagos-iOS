//
//  SplashViewModel.swift
//  Galapagos
//
//  Created by 조용인 on 2023/05/25.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

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
  
  func checkAutoSignIn(){
		if let _: String = UserDefaultManager.shared.load(for: .jwt) {
			self.coordinator?.destination.accept(.tabBar)
		} else {
			self.coordinator?.destination.accept(.auth)
		}
		
  }
}
