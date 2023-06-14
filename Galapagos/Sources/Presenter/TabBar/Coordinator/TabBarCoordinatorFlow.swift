//
//  TabBarCoordinatorFlow.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/11.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit

enum TabBarCoordinatorFlow: Int, CaseIterable {
  
  // MARK: - Coordinator DEPTH 1 -
  
  case main, diary, community, mypage
  
  // 공식 이미지 확정 안 난 듯 해서 임시 이미지
  var tabBarItem: UITabBarItem {
    switch self {
    case .main:
      return UITabBarItem(
        title: "홈",
        image: UIImage(systemName: "plus.circle"),
        selectedImage: UIImage(systemName: "plus.circle.fill")
      )
    case .diary:
      return UITabBarItem(
        title: "다이어리",
        image: UIImage(systemName: "plus.square"),
        selectedImage: UIImage(systemName: "plus.square.fill")
      )
    case .community:
      return UITabBarItem(
        title: "커뮤니티",
        image: UIImage(systemName: "minus.circle"),
        selectedImage: UIImage(systemName: "minus.circle.fill")
      )
    case .mypage:
      return UITabBarItem(
        title: "마이페이지",
        image: UIImage(systemName: "minus.square"),
        selectedImage: UIImage(systemName: "minus.square.fill")
      )
    }
  }
}
