//
//  CertifyEmailViewModel.swift
//  Galapagos
//
//  Created by Siri on 2023/10/02.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation
import UIKit

import RxSwift

final class CertifyEmailViewModel: ViewModelType {
    
    struct Input { 
        let certifyBtnTapped: Observable<Void>
    }
    
    struct Output { }
    
    var disposeBag: DisposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        
        
        return Output()
    }

}
