//
//  File.swift
//  Galapagos
//
//  Created by 조용인 on 2023/07/01.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation

/// URLSession을 사용하여 HTTP통신을 진행하기 위한, 세팅을 진행하는 영역입니다.
/// 다형성을 위해, EndPoint의 protocol도 이 곳에서 만들어줍니다.
/// EndPoint에 들어가는 Parameters나 HTTPMethod등이 NetworkService와 직접적인 연관이 있다고 판단하여 이 영역에서 Protocol을 생성
/// -> extension들도 당연히 생성해줘야함
/// 요약하면, URLSession.shared.request() 정의해 준다고 생각하면 됨
