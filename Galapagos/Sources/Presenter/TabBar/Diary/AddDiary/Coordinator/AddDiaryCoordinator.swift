//
//  AddDiaryCoordinator.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/20.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import RxRelay
import RxSwift
import UIKit

class AddDiaryCoordinator: CoordinatorType {
  var navigationController: UINavigationController

  var delegate: CoordinatorDelegate?
  var childCoordinators: [CoordinatorType] = []
  var disposeBag: DisposeBag = DisposeBag()

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func setState() {}

  func start() {
    pushToAddAnimal()
  }
  
  func pushToAddAnimal() {
    let addDiaryViewController = AddDiaryViewController(
      viewModel: AddDiaryViewModel(
        coordinator: self
      )
    )
    self.pushViewController(viewController: addDiaryViewController)
  }
}
