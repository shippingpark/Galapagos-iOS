//
//  DynamicTabType.swift
//  SiriUIKit
//
//  Created by 박혜운 on 2023/10/14.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation

public enum DynamicTabType {
  /// 헤더 바로 아래 들어가는 2depth 탭입니다. 각 탭 아이템 아래 밑줄이 존재합니다.
  case underHeader
  ///컨텐츠 안에 들어가는 탭입니다.
  case inContents
}
