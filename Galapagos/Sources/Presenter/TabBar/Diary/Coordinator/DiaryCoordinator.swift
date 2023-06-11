//
//  DiaryCoordinator.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/11.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

class DiaryCoordinator: Coordinator {
    var disposeBag: DisposeBag
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    var delegate: CoordinatorDelegate?
    
    init(
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
        self.disposeBag = DisposeBag()
    }
    
    func setState() {
        
    }
    
    func start() {
        
    }
    
    
}
