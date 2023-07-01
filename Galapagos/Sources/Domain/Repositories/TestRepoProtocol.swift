//
//  TestRepoProtocol.swift
//  Galapagos
//
//  Created by 조용인 on 2023/07/01.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation

/// 여기는, Domain과 Data의 의존성 주입을 위한 Repositories의 Protocol 구현부 입니다.
/// Domain의 영역에서는 이 Protocol을 통해서만 Data Layer에 접근하면 됩니다~
/// -> Domain은 여기 함수 꺼내쓰면서, 만약 이상하다 싶으면 Data에서 뜯어고치면 댐
