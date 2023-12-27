//
//  DiaryCoordinator.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/17.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import RxRelay
import RxSwift
import UIKit

class DiaryCoordinator: CoordinatorType {

  enum DiaryCoordinatorFlow {
    case addDiary // 초기화면 삭제
  }
  
  private var petIdx: String?
	
	var childCoordinators: [CoordinatorType] = []
	var delegate: CoordinatorDelegate?
	var baseViewController: UIViewController?
	
	var navigationController: UINavigationController
	var disposeBag: DisposeBag = DisposeBag()
	
	var destination = PublishRelay<DiaryCoordinatorFlow>()
	

  init(
		petIdx: String,
		navigationController: UINavigationController
	) {
    self.petIdx = petIdx
    self.navigationController = navigationController
    self.setState()
  }

  func setState() {
    self.destination
			.withUnretained(self)
      .subscribe(onNext: { owner, state in
        print("🌱🌱🌱 DiaryCoordinator: \(state) 🌱🌱🌱")
				guard let tabBarViewController = owner.navigationController.tabBarController as? TabBarViewController else { return }
				tabBarViewController.hideCustomTabBar()
        switch state {
        case .addDiary:
          owner.pushToAddDiary(petIdx: "임시")
        }
      }).disposed(by: disposeBag)
  }

  func start() {
//    guard let PetIdx else { return } // 아직 안 사용
    let diaryViewController = DiaryViewController(
      viewModel: DiaryViewModel(
        coordinator: self
      )
    )
    self.pushViewController(viewController: diaryViewController, animated: true)
  }
}

extension DiaryCoordinator: AddDiaryCoordinating {
  func pushToAddDiary(petIdx: String) {
    let addDiaryCoordinator = AddDiaryCoordinator(
      navigationController: self.navigationController
    )
    addDiaryCoordinator.delegate = self
    addDiaryCoordinator.start()
    self.childCoordinators.append(addDiaryCoordinator)
    
  }
}

extension DiaryCoordinator: CoordinatorDelegate {
  func didFinish(childCoordinator: CoordinatorType) {
    self.popViewController(animated: true)
  }
}
