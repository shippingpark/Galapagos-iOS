//
//  DiaryListViewController.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/11.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit

class DiaryListViewController: BaseViewController {
    
  // MARK: - Properties
  
  private let viewModel: DiaryListViewModel
  
  // MARK: - Initializers

  init(viewModel: DiaryListViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

}
