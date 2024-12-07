//
//  SavedItemViewCell.swift
//  A4
//
//  Created by Aidan Joseph on 12/6/24.
//
import UIKit
import SnapKit

class SavedItemCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let bookmarkImage = UIImageView()
    private let trashButton = UIButton()
    private let textBelow = UILabel()
    static let reuse = "SavedItemCellReuse"

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
        layer.cornerRadius = 0

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        //imageView.contentMode = .scaleAspectFit
        addSubview(imageView)

        titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        addSubview(titleLabel)
        
        bookmarkImage.image = UIImage(named: "bookmarked")
        addSubview(bookmarkImage)
        
        trashButton.setImage(UIImage(named: "trash"), for: .normal)
        addSubview(trashButton)
        
        textBelow.textColor = UIColor.a4.black
        textBelow.font = .systemFont(ofSize: 14)
        addSubview(textBelow)

        imageView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.leading).inset(8)
            make.top.equalToSuperview().inset(5)
        }
        
        textBelow.snp.makeConstraints{ make in
            make.leading.equalTo(imageView.snp.leading).inset(8)
            make.bottom.equalToSuperview().inset(4)
        }
        
        bookmarkImage.snp.makeConstraints{ make in
            make.height.equalTo(20)
            make.width.equalTo(15)
            make.trailing.top.equalToSuperview().inset(8)
        }
        
        trashButton.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(15)
            make.trailing.bottom.equalToSuperview().inset(8)
        }
    }

    func configure(with item: String, imagename: String) {
            titleLabel.text = item
            imageView.image = UIImage(named: imagename)
            if titleLabel.text == "Post" {
                titleLabel.textColor = UIColor.systemIndigo
                textBelow.text = "interesting..."
            } else if titleLabel.text == "Recipe" {
                titleLabel.textColor = UIColor.systemPurple
                textBelow.text = "Burger"
            } else if titleLabel.text == "Event" {
                titleLabel.textColor = UIColor.a4.yellowOrange
                textBelow.textColor = UIColor.a4.white
                textBelow.text = "Party!!"
            }
        }
    }

