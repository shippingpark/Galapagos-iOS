//
//  MainCoordinator.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/11.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import RxRelay
import RxSwift
import UIKit


final class MainCoordinator: CoordinatorType {
  
  // MARK: - Coordinator DEPTH 2 -
  
  enum MainCoordinatorFlow {
    case addAnimal
    case mainAnimalDiary
    case moveCommunity
    case detailPost // 초기화면 삭제
  }
  
  var childCoordinators: [CoordinatorType] = []
	var delegate: CoordinatorDelegate?
	var baseViewController: UIViewController?
	
	var navigationController: UINavigationController
	var parentsCoordinator: TabBarCoordinator
  var disposeBag: DisposeBag = DisposeBag()
	
	var destination = PublishRelay<MainCoordinatorFlow>()
  
  init(
    navigationController: UINavigationController,
    parentsCoordinator: TabBarCoordinator
  ) {
    self.navigationController = navigationController
    self.parentsCoordinator = parentsCoordinator
    self.setState()
  }
  
  func setState(){
    self.destination
			.withUnretained(self)
      .subscribe(onNext: { owner, state in
				guard let tabBarViewController = owner.navigationController.tabBarController as? TabBarViewController else { return }
				tabBarViewController.hideCustomTabBar()
        switch state {
        case .addAnimal:
					owner.pushToAddAnimal()
        case .mainAnimalDiary:
					owner.pushToMainAnimalDiary(animalIdx: "임시")
        case .moveCommunity:
					owner.pushToMoveCommunity()
        case .detailPost:
          break
        }
      }).disposed(by: disposeBag)
  }
  
  func start() {
    let mainViewController = MainViewController(
      viewModel: MainViewModel(
        coordinator: self
      )
    )
    self.pushViewController(viewController: mainViewController, animated: false)
		self.baseViewController = mainViewController
  }
}

// MARK: Private Methods
extension MainCoordinator {
	fileprivate func pushToAddAnimal() {
		let addAnimalCoordinator = AddAnimalCoordinator(
			navigationController: self.navigationController
		)
		addAnimalCoordinator.delegate = self
		addAnimalCoordinator.start()
		self.childCoordinators.append(addAnimalCoordinator)
	}
	
	fileprivate func pushToMainAnimalDiary(animalIdx: String) {
		let diaryCoordinator = DiaryCoordinator(
			animalIdx: animalIdx,
			navigationController: self.navigationController
		)
		diaryCoordinator.delegate = self
		diaryCoordinator.start()
		self.childCoordinators.append(diaryCoordinator)
	}
	
	fileprivate func pushToMoveCommunity() {
		self.parentsCoordinator.destination.accept(.community)
	}
}

extension MainCoordinator: CoordinatorDelegate {
  func didFinish(childCoordinator: CoordinatorType) { // 복귀 시 탭바 재생성
		guard let tabBarViewController = self.navigationController.tabBarController as? TabBarViewController else { return }     
		tabBarViewController.showCustomTabBar()
		self.popToRootViewController(animated: true)
  }
}
