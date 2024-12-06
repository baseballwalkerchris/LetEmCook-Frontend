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

        timeLabel.font = .systemFont(ofSize: 14)
        timeLabel.textColor = .gray
        addSubview(timeLabel)

        locationLabel.font = .systemFont(ofSize: 14)
        locationLabel.textColor = .gray
        addSubview(locationLabel)

        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(16)
        }

        timeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }

        locationLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(timeLabel.snp.bottom).offset(4)
        }
    }

    func configure(with event: (title: String, time: String, location: String)) {
        titleLabel.text = event.title
        timeLabel.text = event.time
        locationLabel.text = event.location
    }
}
