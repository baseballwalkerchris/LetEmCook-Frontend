//
//  EventsAttendingcell.swift
//  A4
//
//  Created by Aidan Joseph on 12/6/24.
//
import UIKit
import SnapKit

class EventItemCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    private let timeLabel = UILabel()
    private let locationLabel = UILabel()
    private let peopleGoing = UILabel()
    private let eventImage = UIImageView()
    
    private let attendeesImage = UIImageView()
    private let locationImage = UIImageView()
    private let dateImage = UIImageView()
    
    static let reuse = "EventItemCellReuse"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 8

        titleLabel.font = .boldSystemFont(ofSize: 16)
        addSubview(titleLabel)
        
        peopleGoing.font = .boldSystemFont(ofSize: 16)
        addSubview(peopleGoing)

        timeLabel.font = .systemFont(ofSize: 14)
        timeLabel.textColor = .gray
        addSubview(timeLabel)

        locationLabel.font = .systemFont(ofSize: 14)
        locationLabel.textColor = .gray
        addSubview(locationLabel)
        
        attendeesImage.image = UIImage(named: "attendeeImage")
        addSubview(attendeesImage)
        
        dateImage.image = UIImage(named: "timeImage")
        addSubview(dateImage)
        
        locationImage.image = UIImage(named: "locationImage")
        addSubview(locationImage)
        
        addSubview(eventImage)
        


        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(8)
        }
        
        attendeesImage.snp.makeConstraints{ make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
        }
        
        dateImage.snp.makeConstraints{ make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(attendeesImage.snp.bottom).offset(2)
        }
        
        locationImage.snp.makeConstraints{ make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(dateImage.snp.bottom).offset(2)
        }
        
        peopleGoing.snp.makeConstraints{ make in
            make.leading.equalTo(attendeesImage.snp.trailing).offset(4)
            make.centerY.equalTo(attendeesImage.snp.centerY)
        }

        timeLabel.snp.makeConstraints { make in
            make.leading.equalTo(dateImage.snp.trailing).offset(4)
            make.centerY.equalTo(dateImage.snp.centerY)
        }

        locationLabel.snp.makeConstraints { make in
            make.leading.equalTo(locationImage.snp.trailing).offset(4)
            make.centerY.equalTo(locationImage.snp.centerY)
        }
    }

    func configure(with event: (title: String, time: String, location: String)) {
           titleLabel.text = event.title
           timeLabel.text = event.time
           locationLabel.text = event.location
       }
}
