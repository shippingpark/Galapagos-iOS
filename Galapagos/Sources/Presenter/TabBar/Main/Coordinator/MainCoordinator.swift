//
//  MainCoordinator.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/11.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit

import RxRelay
import RxSwift


final class MainCoordinator: Coordinator {
  
  // MARK: - Coordinator DEPTH 2 -
  
  enum MainCoordinatorFlow {
    case addPet, detailDiary, moveCommunity, detailPost //초기화면 삭제
  }
  
  var navigationController: UINavigationController
  var parentsCoordinator: TabBarCoordinator
  
  // MARK: - Don't Need To Initializing
  
  var userActionState: PublishRelay<MainCoordinatorFlow> = PublishRelay()
  var childCoordinators: [Coordinator] = []
  var disposeBag: DisposeBag = DisposeBag()
  var delegate: CoordinatorDelegate?
  
  init(navigationController: UINavigationController,
       parentsCoordinator: TabBarCoordinator
  ) {
    self.navigationController = navigationController
    self.parentsCoordinator = parentsCoordinator
    self.setState()
  }
  
  func setState(){
    self.userActionState
      .debug()
      .subscribe(onNext: { [weak self] state in
        print("💗💗💗 MainCoordinator: \(state) 💗💗💗")
        guard let self = self else { return }
        switch state {
        case .addPet:
          self.pushToAddPet()

        case .detailDiary:
          self.pushToDetailDiary(petIdx: "임시") //Idx 가져 올 방법 고민 (enum 유력)
          
        case .moveCommunity:
          
          self.moveToCommunityTab()
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
    self.pushViewController(viewController: mainViewController)
  }
}

extension MainCoordinator: AddPetCoordinating {
  func pushToAddPet() {
    if let tabBarViewController = self.navigationController.tabBarController as? CustomTabBarController {
      tabBarViewController.hideCustomTabBar()
    }
    let addPetCoordinator = AddPetCoordinator(
      navigationController: self.navigationController
    )
    addPetCoordinator.delegate = self
    addPetCoordinator.start()
    self.childCoordinators.append(addPetCoordinator)
  }
}

extension MainCoordinator: DetailDiaryCoordinating {
  func pushToDetailDiary(petIdx: String) { //TabBar 거쳐야 하는 이례적인 상황
    self.parentsCoordinator.detailDiary()
  }
}

extension MainCoordinator { //TabBar는 이례적으로 Coordinating X
  func moveToCommunityTab() {
    self.parentsCoordinator.userActionState.accept(.community)
  }
}

extension MainCoordinator: DetailPostCoordinating {
  func pushToDetailPost(postIdx: String) {
    //
  }
}

extension MainCoordinator: CoordinatorDelegate {
  func didFinish(childCoordinator: Coordinator) {
    if let tabBarViewController = self.navigationController.tabBarController as? CustomTabBarController {
      tabBarViewController.showCustomTabBar()
    }
    self.popViewController()
  }
}
