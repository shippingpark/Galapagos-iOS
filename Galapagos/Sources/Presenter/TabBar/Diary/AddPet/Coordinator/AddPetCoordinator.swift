//
//  AddAnimalCoordinator.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/20.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import RxRelay
import RxSwift
import UIKit

class AddAnimalCoordinator: CoordinatorType {
	
	var childCoordinators: [CoordinatorType] = []
	var delegate: CoordinatorDelegate?
	var baseViewController: UIViewController?
	
	var navigationController: UINavigationController
	var disposeBag: DisposeBag = DisposeBag()
	

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func setState() {}

  func start() {
    pushToAddAnimal()
  }
  
  func pushToAddAnimal() {
    let addAnimalViewController = AddAnimalViewController(
      viewModel: AddAnimalViewModel(
        coordinator: self
      )
    )
    self.pushViewController(viewController: addAnimalViewController, animated: true)
  }
}
