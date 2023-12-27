//
//  AddPetViewController.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/06/20.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//


import RxCocoa
import RxSwift
import SiriUIKit
import SnapKit
import UIKit

final class AddPetViewController: BaseViewController {
  
  // MARK: - UI
  
  private lazy var navigationBar: GalapagosNavigationBarView = {
    let navigationBar = GalapagosNavigationBarView()
    navigationBar.setTitleText("반려동물 추가")
    return navigationBar
  }()
  
  private lazy var nameContainerView = AddPetContainerView(
    title: "이름*",
    checkButton: .use(title: "대표동물 설정"),
    contentView: self.nameTextField
  )
  private lazy var genderContainerView = AddPetContainerView(
    title: "성별*",
    checkButton: .unused,
    contentView: self.genderButtonStackView
  )
  private lazy var speciesContainerView = AddPetContainerView(
    title: "종 선택*",
    checkButton: .unused,
    contentView: self.speciesStackView
  )
  private lazy var adoptionDateContainerView = AddPetContainerView(
    title: "입양일*",
    checkButton: .unused,
    contentView: self.adoptionTextField
  )
  private lazy var birthDateContainerView = AddPetContainerView(
    title: "탄생일*",
    checkButton: .use(title: "탄생일을 모르겠어요"),
    contentView: self.birthDateTextField
  )
  
  private lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.showsVerticalScrollIndicator = false
    return scrollView
  }()
  
  private lazy var contentStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = 32
    return stackView
  }()
  private lazy var genderButtonStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fillEqually
    stackView.spacing = 6
    return stackView
  }()
  private lazy var speciesStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = 0 // 칩 추가 시 12로 변경
    return stackView
  }()
  
  private lazy var contentView: UIView = {
    let contentView = UIView()
    return contentView
  }()
  private lazy var profileContainerView = UIView()
  private lazy var circleShadowCameraView: UIView = {
    let radiusBoxView = RadiusBoxView(radius: 16, style: .shadow)
    radiusBoxView.layer.shadowColor = GalapagosAsset.blackDisplayHeadingBody.color.withAlphaComponent(0.25).cgColor
    radiusBoxView.layer.shadowOffset = CGSize(width: 0, height: 4)
    radiusBoxView.layer.shadowRadius = 4.0 // Blur
    radiusBoxView.layer.shadowOpacity = 1
    return radiusBoxView
  }()
  private lazy var speciesChipView = UIView()
  
  private lazy var profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = GalapagosAsset.gray3DisableButtonBg.color
    imageView.layer.cornerRadius = 12
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  private let cameraImageView: UIImageView = UIImageView(
    image: GalapagosAsset._16x16CameraDefault.image
  )
  
  private lazy var nameTextField: GalapagosTextField = {
    let textField = GalapagosTextField(
      placeHolder: "이름을 입력해주세요",
      maxCount: 8
    )
    return textField
  }()
  private lazy var adoptionTextField = AddPetCalendarTextFieldView(
    placeHolder: "입양일을 선택해주세요"
  )
  private lazy var birthDateTextField = AddPetCalendarTextFieldView(
    placeHolder: "탄생일을 선택해주세요"
  )
  
  private lazy var undifferentiatedGenderButton: GalapagosButton = {
    let button = GalapagosButton(
      isRound: false,
      iconTitle: nil,
      type: .usage(.disabled),
      title: "미구분"
    )
    return button
  }()
  private lazy var maleGenderButton: GalapagosButton = {
    let button = GalapagosButton(
      isRound: false,
      iconTitle: nil,
      type: .usage(.disabled),
      title: "수컷"
    )
    return button
  }()
  private lazy var femaleGenderButton: GalapagosButton = {
    let button = GalapagosButton(
      isRound: false,
      iconTitle: nil,
      type: .usage(.disabled),
      title: "암컷"
    )
    return button
  }()
  private lazy var speciesSelectButton: GalapagosButton = {
    let button = GalapagosButton(
      isRound: false,
      iconTitle: nil,
      type: .usage(.whiteDisabled),
      title: "선택하기"
    )
    return button
  }()
  private lazy var completeAddPetButton: GalapagosButton = {
    let button = GalapagosButton(
      isRound: false,
      iconTitle: nil,
      type: .usage(.disabled),
      title: "완료"
    )
    return button
  }()
  
  
  // MARK: - Properties
  private let viewModel: AddPetViewModel
  
  // MARK: - Initializers
  
  init(
    viewModel: AddPetViewModel
  ) {
    self.viewModel = viewModel
    super.init()
  }
  
  // MARK: - LifeCycle
  
  // MARK: - Methods
  
  override func setAddSubView() {
    view.addSubviews([
      navigationBar,
      scrollView
    ])
    
    scrollView.addSubviews([
      contentView
    ])
    
    contentView.addSubviews([
      profileContainerView,
      contentStackView,
      completeAddPetButton
    ])
    
    contentStackView.addArrangedSubviews([
      nameContainerView,
      genderContainerView,
      speciesContainerView,
      adoptionDateContainerView,
      birthDateContainerView
    ])
    
    profileContainerView.addSubview(profileImageView)
    profileImageView.addSubview(circleShadowCameraView)
    circleShadowCameraView.addSubview(cameraImageView)
    
    genderContainerView.addSubviews([
      genderButtonStackView
    ])
    
    genderButtonStackView.addArrangedSubviews([
      undifferentiatedGenderButton,
      maleGenderButton,
      femaleGenderButton
    ])
    
    speciesStackView.addArrangedSubviews([
      speciesSelectButton
    ])
  }
  
  override func setConstraint() {
    setBlockView()
    setContainerConstraint()
    setProfileContainerConstraint()
    setNameContainerConstraint()
    setGenderContainerConstraint()
    setSpeciesContainerConstraint()
    setAdoptionDateContainerConstraint()
    setBirthDateContainerConstraint()
  }
  
  private func setBlockView() {
    navigationBar.snp.makeConstraints{ navigationBar in
      navigationBar.top.equalTo(self.view.safeAreaLayoutGuide)
      navigationBar.leading.trailing.equalToSuperview()
      navigationBar.height.equalTo(50)
    }
    
    scrollView.snp.makeConstraints { make in
      make.top.equalTo(navigationBar.snp.bottom)
      make.leading.trailing.bottom.equalToSuperview()
    }
    
    contentView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
      make.width.equalToSuperview()
    }
  }
  
  private func setContainerConstraint() {
    profileContainerView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(38)
      make.centerX.equalToSuperview()
      make.leading.equalTo(profileImageView)
      make.trailing.equalTo(profileImageView.snp.trailing).offset(6)
      make.bottom.equalTo(circleShadowCameraView)
    }
    
    contentStackView.snp.makeConstraints { make in
      make.top.equalTo(profileContainerView.snp.bottom).offset(56)
      make.horizontalEdges.equalTo(view.snp.horizontalEdges)
    }
    
    completeAddPetButton.snp.makeConstraints { make in
      make.top.equalTo(contentStackView.snp.bottom).offset(40)
      make.horizontalEdges.equalToSuperview().inset(galpagosHorizontalOffset)
      make.height.equalTo(56)
      make.bottom.equalToSuperview()
    }
  }
  
  private func setProfileContainerConstraint() {
    profileImageView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.equalToSuperview()
      make.size.equalTo(110)
    }
    
    circleShadowCameraView.snp.makeConstraints { make in
      make.size.equalTo(32)
      make.trailing.equalToSuperview().offset(6)
      make.bottom.equalToSuperview().offset(6)
    }
    
    cameraImageView.snp.makeConstraints { make in
      make.center.equalTo(circleShadowCameraView.snp.center)
    }
  }
  
  private func setNameContainerConstraint() {
    nameContainerView.snp.makeConstraints { make in
      make.horizontalEdges.equalToSuperview().inset(galpagosHorizontalOffset)
    }
    
    nameTextField.snp.makeConstraints { make in
      make.height.equalTo(56)
    }
  }
  
  private func setGenderContainerConstraint() {
    genderContainerView.snp.makeConstraints { make in
      make.horizontalEdges.equalToSuperview().inset(galpagosHorizontalOffset)
    }
    
    genderButtonStackView.snp.makeConstraints { make in
      make.horizontalEdges.equalToSuperview()
      make.height.equalTo(56)
    }
    
    undifferentiatedGenderButton.snp.makeConstraints { make in
      make.height.equalTo(56)
    }
    
    maleGenderButton.snp.makeConstraints { make in
      make.height.equalTo(56)
    }
    
    femaleGenderButton.snp.makeConstraints { make in
      make.height.equalTo(56)
    }
  }
  
  private func setSpeciesContainerConstraint() {
    speciesContainerView.snp.makeConstraints { make in
      make.horizontalEdges.equalToSuperview().inset(galpagosHorizontalOffset)
    }
    
    speciesStackView.snp.makeConstraints { make in
      make.horizontalEdges.equalToSuperview()
      make.height.greaterThanOrEqualTo(56)
    }
    
    speciesSelectButton.snp.makeConstraints { make in
      make.horizontalEdges.equalToSuperview()
      make.height.equalTo(56)
    }
  }
  
  private func setAdoptionDateContainerConstraint() {
    adoptionDateContainerView.snp.makeConstraints { make in
      make.horizontalEdges.equalToSuperview().inset(galpagosHorizontalOffset)
    }
    adoptionTextField.snp.makeConstraints { make in
      make.height.equalTo(56)
    }
  }
  
  private func setBirthDateContainerConstraint() {
    birthDateContainerView.snp.makeConstraints { make in
      make.horizontalEdges.equalToSuperview().inset(galpagosHorizontalOffset)
    }
    
    birthDateTextField.snp.makeConstraints { make in
      make.height.equalTo(56)
    }
  }
  
  override func bind() {
    let input = AddPetViewModel.Input(
      backButtonTapped: navigationBar.backButton.rx.tap.asSignal(),
      profileTapped: profileContainerView.rx.tapGesture()
        .when(.recognized)
        .map { _ in
          let calendarVC = CalendarViewController(events: ["2023-08-09"])

          BottomSheetManager.shared.showBottomSheet(
            title: "입양일",
            content: calendarVC,
            bottomButtonTitle: "완료"
          )
        }
        .asSignal(onErrorJustReturn: ())
    )
    
    _ = viewModel.transform(input: input)
    
    // MARK: - 동작 확인 (삭제 예정)
    
    nameTextField.rx.text.orEmpty
      .asDriver()
      .debounce(.milliseconds(300))
      .drive(
        onNext: { text in
          print("\(text)")
        }
      )
      .disposed(by: disposeBag)
    
    nameContainerView.rx.isSelected
      .asDriver(onErrorJustReturn: false)
      .drive{ check in
        print("\(check)")
      }
      .disposed(by: disposeBag)
    
    adoptionTextField.rxDate
      .accept("넣어지나 확인")
    
    adoptionTextField.rx.tap
      .asDriver(onErrorDriveWith: .empty())
      .drive(onNext: {
        //        guard let self = self else { return }
        print("눌림")
      })
      .disposed(by: disposeBag)
  }
}
