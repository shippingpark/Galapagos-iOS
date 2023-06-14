//
//  ViewModelType.swift
//  Galapagos
//
//  Created by 조용인 on 2023/05/25.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import RxSwift

protocol ViewModelType: AnyObject{
  associatedtype Input
  associatedtype Output
  
  
  // MARK: - Properties
  var disposeBag: DisposeBag { get }
  
  // MARK: - Methods
  func transform(input: Input) -> Output
}
