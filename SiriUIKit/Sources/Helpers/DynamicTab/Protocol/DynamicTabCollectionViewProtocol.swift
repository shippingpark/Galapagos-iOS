//
//  DynamicTabCollectionViewProtocol.swift
//  SiriUIKit
//
//  Created by 박혜운 on 2023/10/14.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import RxCocoa
import UIKit

protocol DynamicTabCollectionViewProtocol: AnyObject {
  var rxPage: Driver<Int> { get }
  func selectedTap(at index: Int)
}
