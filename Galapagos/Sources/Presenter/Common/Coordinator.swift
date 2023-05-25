//
//  Coordinator.swift
//  Galapagos
//
//  Created by 조용인 on 2023/05/24.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit

protocol CoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)   /// navigator가 back될 때, childCoordinator들을 모두 지워주기 위함이다.
}

protocol Coordinator: AnyObject{
    
    var delegate: CoordinatorDelegate? {get set}
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
    func finish()
//    func pushViewController()
    func popViewController()
//    func present()
    func dismissViewController()
    
}

extension Coordinator{
    
    /// finish가 호출되면 -> delegate를 self로 할당하면서 didFinish를 정의한놈의 child를 모두 지워줌
    func finish() {
        childCoordinators.removeAll()
        delegate?.didFinish(childCoordinator: self)
    }
    
    /// coordinator로 push 하려고 만들기는 했는데, 어차피 coordinator에서 push 하는거라
    /// 굳이 만들어서 사용 안 해도 될 것 같긴 함,,,
    /// -> self.pushViewController(viewController) vs navigationController.pushViewController(vc, animated: true)
    /// 사실상 쓸데없는 코드만 더 늘어난 기분
    /// present도 마찬가지라서, 그냥 냅둠
//    func pushViewController(viewController vc: UIViewController ){
//        self.navigationController.pushViewController(vc, animated: true)
//    }
    
    func popViewController() {
        self.navigationController.popViewController(animated: true)
    }
    
    func dismissViewController() {
        navigationController.dismiss(animated: true)
    }
    
}
