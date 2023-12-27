//
//  TabBarViewController.swift
//  Galapagos
//
//  Created by Siri on 12/27/23.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import RxRelay
import RxSwift
import UIKit

final class TabBarViewController: UITabBarController {
	
	private lazy var customTabBar: CustomTabBar = {
		let tabBar = CustomTabBar()
		return tabBar
	}()
	
	// MARK: - Properties
	
	let tabBarItemSubject = BehaviorRelay<Int>(value: 0)
	private let disposeBag = DisposeBag()
	
	// MARK: - Initializers
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - LifeCycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setAddSubView()
		setConstraint()
		bind()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.showCustomTabBar()
	}
	
	private func setAddSubView() {
		self.view.addSubview(customTabBar)
	}
	
	private func setAttribute() {
		customTabBar.setShadow()
	}
	
	private func setConstraint() {
		customTabBar.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview()
			$0.bottom.equalToSuperview()
			$0.height.equalToSuperview().multipliedBy(0.11)
		}
	}
	
	// MARK: - Binding
	private func bind() {
		customTabBar.itemTappedSubject
			.distinctUntilChanged()
			.withUnretained(self)
			.subscribe(onNext: { owner, idx in
				owner.tabBarItemSubject.accept(idx)
				owner.customTabBar.changeImage(index: idx)
			})
			.disposed(by: disposeBag)
	}
}

// MARK: - Extension
extension TabBarViewController {
	func hideCustomTabBar() {
		self.tabBar.isHidden = true
		customTabBar.isHidden = true
	}
	
	func showCustomTabBar() {
		self.tabBar.isHidden = true
		customTabBar.isHidden = false
	}
}

// MARK: - Extension UITabBarControllerDelegate
extension TabBarViewController: UITabBarControllerDelegate {
	func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
		return false
	}
}
