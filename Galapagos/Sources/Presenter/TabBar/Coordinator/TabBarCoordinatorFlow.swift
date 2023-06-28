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
        image: GalapagosAsset.naviHomeOff.image,
        selectedImage: GalapagosAsset.naviHomeOn.image
      )
    case .diary:
      return UITabBarItem(
        title: "다이어리",
        image: GalapagosAsset.naviaviDiaryOff.image,
        selectedImage: GalapagosAsset.naviaviDiaryOn.image
      )
    case .community:
      return UITabBarItem(
        title: "커뮤니티",
        image: GalapagosAsset.naviCommunityOff.image,
        selectedImage: GalapagosAsset.naviCommunityOn.image
      )
    case .mypage:
      return UITabBarItem(
        title: "마이페이지",
        image: GalapagosAsset.naviMypageOff.image,
        selectedImage: GalapagosAsset.naviMypageOn.image
      )
    }
  }
}
