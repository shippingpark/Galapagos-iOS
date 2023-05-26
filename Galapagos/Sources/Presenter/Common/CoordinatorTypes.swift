//
//  CoordinatorTypes.swift
//  Galapagos
//
//  Created by 조용인 on 2023/05/26.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation

//MARK: - DEPTH 0 -
enum AppCoordinatorChild{
    case Auth, TabBar
}

//MARK: - DEPTH 1 -
enum AuthCoordinatorChild{
    case SignIn, SignUp
}

enum TabBarCoordinatorChild{
    case Main, Diary, Communicate, Mypage
}

//MARK: - DEPTH 2 -
