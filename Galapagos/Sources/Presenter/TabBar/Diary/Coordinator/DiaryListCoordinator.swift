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
    case addPet, diary
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
    self.navigationController = navigationController
		self.parentsCoordinator = parentsCoordinator
    self.setState()
  }
  
  func setState() {
    self.destination
			.withUnretained(self)
      .subscribe(onNext: { owner, state in
        print("💗💗💗 DiaryListCoordinator: \(state) 💗💗💗")
				guard let tabBarViewController = owner.navigationController.tabBarController as? TabBarViewController else { return }
				tabBarViewController.hideCustomTabBar()
        switch state {
        case .addPet:
          self.pushToAddPet()
        case .diary:
          self.pushToDiary(petIdx: "임시")
        }
      }).disposed(by: disposeBag)
  }
  
  func start() {
    let diaryListViewController = DiaryListViewController(
      viewModel: DiaryListViewModel(
        coordinator: self
      )
    )
    self.pushViewController(viewController: diaryListViewController, animated: true)
  }
}

// MARK: - Private Methods
extension DiaryListCoordinator {
	
	fileprivate func pushToAddPet() {
		let addPetCoordinator = AddPetCoordinator(
			navigationController: self.navigationController
		)
		addPetCoordinator.delegate = self
		addPetCoordinator.start()
		self.childCoordinators.append(addPetCoordinator)
	}
	
	fileprivate func pushToDiary(petIdx: String) {
		let diaryCoordinator = DiaryCoordinator(
			petIdx: petIdx,
			navigationController: self.navigationController
		)
		diaryCoordinator.delegate = self
		diaryCoordinator.start()
		self.childCoordinators.append(diaryCoordinator)
	}
	
}

extension DiaryListCoordinator: CoordinatorDelegate {
	func didFinish(childCoordinator: CoordinatorType) { // 복귀 시 탭바 재생성
		guard let tabBarViewController = self.navigationController.tabBarController as? TabBarViewController else { return }
		tabBarViewController.showCustomTabBar()
		self.popToRootViewController(animated: true)
	}
}
