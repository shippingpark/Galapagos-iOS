//
//  DiaryCoordinator.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/11.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import RxRelay
import RxSwift
import UIKit

class DiaryListCoordinator: CoordinatorType {
  
  enum DiaryListCoordinatorFlow {
    case addAnimal, diary
  }
	
	var childCoordinators: [CoordinatorType] = []
	var delegate: CoordinatorDelegate?
	var baseViewController: UIViewController?
	
	var navigationController: UINavigationController
	var parentsCoordinator: TabBarCoordinator
	var disposeBag: DisposeBag = DisposeBag()
	
	var destination = PublishRelay<DiaryListCoordinatorFlow>()
  
  init(
		navigationController: UINavigationController,
		parentsCoordinator: TabBarCoordinator
	) {
		self.parentsCoordinator = parentsCoordinator
    self.navigationController = navigationController
    self.setState()
  }
  
  func setState() {
		self.destination
			.withUnretained(self)
      .subscribe(onNext: { owner, state in
				guard let tabBarViewController = self.navigationController.tabBarController as? TabBarViewController else { return }
				tabBarViewController.hideCustomTabBar()
        switch state {
        case .addAnimal:
          owner.pushToAddAnimal()
        case .diary:
          owner.pushToDiary(animalIdx: "임시")
        }
      }).disposed(by: disposeBag)
  }
  
  func start() {
    let diaryListViewController = DiaryListViewController(
      viewModel: DiaryListViewModel(
        coordinator: self
      )
    )
    self.pushViewController(viewController: diaryListViewController, animated: false)
		self.baseViewController = diaryListViewController
  }
}


// MARK: Private Methods
extension DiaryListCoordinator {
	fileprivate func pushToAddAnimal() {
		let addAnimalCoordinator = AddAnimalCoordinator(
			navigationController: self.navigationController
		)
		addAnimalCoordinator.delegate = self
		addAnimalCoordinator.start()
		self.childCoordinators.append(addAnimalCoordinator)
	}
	
	fileprivate func pushToDiary(animalIdx: String) {
		let diaryCoordinator = DiaryCoordinator(
			animalIdx: animalIdx,
			navigationController: self.navigationController
		)
		diaryCoordinator.delegate = self
		diaryCoordinator.start()
		self.childCoordinators.append(diaryCoordinator)
	}
}

extension DiaryListCoordinator: CoordinatorDelegate {
  func didFinish(childCoordinator: CoordinatorType) {
		guard let tabBarViewController = self.navigationController.tabBarController as? TabBarViewController else { return }
		tabBarViewController.showCustomTabBar()
		self.popToRootViewController(animated: true)
  }
}
