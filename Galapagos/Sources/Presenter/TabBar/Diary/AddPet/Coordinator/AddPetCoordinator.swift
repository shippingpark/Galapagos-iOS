//
//  AddPetCoordinator.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/20.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import RxRelay
import RxSwift
import UIKit

class AddPetCoordinator: CoordinatorType {
	
	var childCoordinators: [CoordinatorType] = []
	var delegate: CoordinatorDelegate?
	var baseViewController: UIViewController?
	
	var navigationController: UINavigationController
	var disposeBag: DisposeBag = DisposeBag()

  init(
		navigationController: UINavigationController
	) {
    self.navigationController = navigationController
  }
  
  func setState() {}

  func start() {
		let addPetViewController = AddPetViewController(
			viewModel: AddPetViewModel(
				coordinator: self
			)
		)
		self.pushViewController(viewController: addPetViewController, animated: true)
  }
 
}
