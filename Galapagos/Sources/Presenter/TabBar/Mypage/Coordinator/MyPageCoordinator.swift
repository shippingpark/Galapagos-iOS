//
//  MypageCoordinator.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/11.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import RxRelay
import RxSwift
import UIKit

class MyPageCoordinator: CoordinatorType {
  var disposeBag: DisposeBag
  
  var navigationController: UINavigationController
  
  var childCoordinators: [CoordinatorType] = []
  var delegate: CoordinatorDelegate?
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
    self.disposeBag = DisposeBag()
  }
  
  func setState() {
    
  }
  
  func start() {
    
  }
  
  
}
