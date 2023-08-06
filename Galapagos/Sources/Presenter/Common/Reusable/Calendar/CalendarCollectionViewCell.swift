//
//  CalendarCollectionViewCell.swift
//  Galapagos
//
//  Created by 박혜운 on 2023/08/06.
//  Copyright © 2023 com.busyModernPeople. All rights reserved.
//

import UIKit

final class CalendarCollectionViewCell: UICollectionViewCell {
  
  //MARK: - UI
  private var isCurrentDay: Bool = false
  private var myDate: Date?
  private let eventDot: UIView = {
    let dotView = UIView()
    dotView.backgroundColor = .red
    dotView.translatesAutoresizingMaskIntoConstraints = false
    dotView.isHidden = true
    return dotView
  }()
  
  private let dayLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
    
  //MARK: - Properties
  static let identifier = "CalendarCollectionViewCell"
  var day: String = "" //외부 접근 (임시)
  
  //MARK: - Initializers
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.configure()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.configure()
  }
  
  //MARK: - LifeCycle
  override func layoutSubviews() {
    super.layoutSubviews()
    self.contentView.layer.cornerRadius = bounds.width / 2
  }
  
  //MARK: - Methods
  private func configure() {
    self.contentView.addSubview(self.dayLabel)
    self.contentView.addSubview(eventDot)
      self.dayLabel.font = .boldSystemFont(ofSize: 12)
      self.dayLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        eventDot.topAnchor.constraint(equalTo: topAnchor, constant: 2),
        eventDot.centerXAnchor.constraint(equalTo: centerXAnchor),
        eventDot.widthAnchor.constraint(equalToConstant: 6),
        eventDot.heightAnchor.constraint(equalTo: eventDot.widthAnchor),
        
        dayLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        dayLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
      ])
  }
  
  override var isSelected: Bool {
    willSet{
      super.isSelected = newValue
      if newValue {
        self.contentView.backgroundColor = .blue
        self.dayLabel.textColor = .white
      } else {
        self.contentView.backgroundColor = .clear
        self.dayLabel.textColor = isCurrentDay ? .green : .black
      }
    }
  }

  func configure(day: String, hasEvent: Bool, isToday: Bool) { // cell Setting
    self.day = day
    self.isCurrentDay = isToday
    self.isSelected = self.isSelected
    dayLabel.text = day
    eventDot.isHidden = !hasEvent
  }
}
