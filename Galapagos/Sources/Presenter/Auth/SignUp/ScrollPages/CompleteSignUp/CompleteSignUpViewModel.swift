//
//  CompleteSignUpViewModel.swift
//  Galapagos
//
//  Created by Siri on 2023/10/08.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift

import UIKit

final class CompleteSignUpViewModel: ViewModelType {
	struct Input {
		let registerPetBtnTapped: Observable<Void>
		let lookAroundBtnTapped: Observable<Void>
	}
	
	struct Output {
		let registerTap: Observable<Void>
		let lookAroundTap: Observable<Void>
	}
	
	var disposeBag: DisposeBag = DisposeBag()
	
	func transform(input: Input) -> Output {
		
		return Output(
			registerTap: input.registerPetBtnTapped,
			lookAroundTap: input.lookAroundBtnTapped
		)
	}
}
