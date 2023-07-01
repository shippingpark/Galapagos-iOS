//
//  TestModels.swift
//  Galapagos
//
//  Created by 조용인 on 2023/07/01.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation

/// ViewModel에서 실제로 사용하게 될 Entity 형태입니다.
/// 음.. Repository에서 받아온 값이 내가 원하는 타입과 일치하면 Entity로 바로 써도 괜찮고,
/// 예를 들면, Data -> String으로 바꾸는 변환이 필요하면, DTO를 통해서 변환한 Entity를 사용해도 됩니다.
/// 요약하자면, UseCase에서 사용하기 위한 Entity라고 보세요~~
