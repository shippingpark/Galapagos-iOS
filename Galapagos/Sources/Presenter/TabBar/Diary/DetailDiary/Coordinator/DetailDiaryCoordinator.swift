//
//  DiaryDetailCoordinator.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/17.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit

import RxSwift
import RxRelay

class DetailDiaryCoordinator: Coordinator {

  enum DetailDiaryCoordinatorFlow {
    case addDiary //초기화면 삭제
  }
  
  private var petIdx: String?
  
  var userActionState: PublishRelay<DetailDiaryCoordinatorFlow> = PublishRelay()
  var delegate: CoordinatorDelegate?

  var navigationController: UINavigationController
  var childCoordinators: [Coordinator] = []
  var disposeBag: DisposeBag = DisposeBag()

  init(petIdx: String, navigationController: UINavigationController) {
    self.petIdx = petIdx
    self.navigationController = navigationController
    self.setState()
  }

  func setState() {
    self.userActionState
      .debug()
      .subscribe(onNext: { [weak self] state in
        print("🌱🌱🌱 DiaryDetailCoordinator: \(state) 🌱🌱🌱")
        guard let self = self else { return }
        switch state {
        case .addDiary:
          self.pushToAddDiary(petIdx: "임시")
        }
      }).disposed(by: disposeBag)
  }

  func start() {
    guard let petIdx else { return } //아직 안 사용
    let diaryDetailViewController = DetailDiaryViewController(
      viewModel: DetailDiaryViewModel(
        coordinator: self
      )
    )
    self.pushViewController(viewController: diaryDetailViewController)
  }
}

extension DetailDiaryCoordinator: AddDiaryCoordinating {
  func pushToAddDiary(petIdx: String) {
    let addDiaryCoordinator = AddDiaryCoordinator(
      navigationController: self.navigationController
    )
    addDiaryCoordinator.delegate = self
    addDiaryCoordinator.start()
    self.childCoordinators.append(addDiaryCoordinator)
    
  }
}

extension DetailDiaryCoordinator: CoordinatorDelegate {
  func didFinish(childCoordinator: Coordinator) {
    self.popViewController()
  }
}
