//
//  CustomTabBarController.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/11.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    weak var coordinator: TabBarCoordinator?
    
    init(
        coordinator: TabBarCoordinator
    ) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = self
        self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setAttribute()
        self.setShadow()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setFrame()
        
    }
        
    // MARK: - Private Methods
    private func setFrame() {
        let tabBarHeightRatio: CGFloat = 0.11 // 탭 바 높이 비율 (0.0 ~ 1.0)
        var tabFrame = tabBar.frame
        tabFrame.size.height = view.frame.size.height * tabBarHeightRatio
        tabFrame.origin.y = view.frame.size.height - tabFrame.size.height
        tabBar.frame = tabFrame
        tabBar.setNeedsLayout()
        tabBar.layoutIfNeeded()
    }
    
    private func setUI() {
        tabBar.backgroundColor = .white
        tabBar.cornerRadius = 20
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.tintColor = GalapagosAsset.green.color
        tabBar.unselectedItemTintColor = GalapagosAsset.gray4SubText.color
    }
    
    private func setAttribute() {
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font: GalapagosFontFamily.Pretendard.semiBold.font(size: 12)]
        appearance.setTitleTextAttributes(attributes, for: .normal)
        appearance.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
    }
    
    private func setShadow() {
        tabBar.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -3)
        tabBar.layer.shadowOpacity = 1
        tabBar.layer.shadowRadius = 10
        tabBar.layer.masksToBounds = false
    }
}

extension CustomTabBarController: UITabBarControllerDelegate {
    //TabBar 권한 Coordinator에 위임
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) {
            self.coordinator?.userActionState.accept(TabBarCoordinatorFlow(rawValue: selectedIndex) ?? .main)
        }
        return false
    }
}
