//
//  StoryViewCell.swift
//  A4
//
//  Created by Christopher Cheng on 12/5/24.
//

import UIKit
import SnapKit
import SDWebImage

class StoryViewCell: UICollectionViewCell {
    
    // MARK: - Properties (views)
    private let storyImageView = UIImageView()
    private let captionLabel = UILabel()
    private let usernameLabel = UILabel()
    private let timeLabel = UILabel()
    private let bookmarkButton = UIButton()
    
    static let reuse = "StoryViewCellReuse"
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        setupStoryImageView()
        setupBookmarkButton()
        setupUsernameLabel()
        setupCaptionLabel()
        setupTimeLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure Cell
    func configure(story: Story) {
        if let imageUrl = URL(string: story.imageUrl) {
            storyImageView.sd_setImage(with: imageUrl)
        }
        usernameLabel.text = story.title
        captionLabel.text = story.caption
        timeLabel.text = story.createdAt.convertToAgo()
    }
    
    // MARK: - UI Setup
    private func setupStoryImageView() {
        storyImageView.contentMode = .scaleAspectFill
        storyImageView.clipsToBounds = true
        contentView.addSubview(storyImageView)
        
        storyImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(contentView.snp.width).multipliedBy(0.75)
        }
    }
    
    private func setupBookmarkButton() {
        bookmarkButton.setImage(UIImage(named: "bookmark"), for: .normal)
        bookmarkButton.tintColor = .white
        contentView.addSubview(bookmarkButton)
        
        bookmarkButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(12)
            make.width.height.equalTo(24)
        }
    }
    
    private func setupCaptionLabel() {
        captionLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        captionLabel.textColor = .darkGray
        captionLabel.numberOfLines = 3
        captionLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(captionLabel)
        
        captionLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(1)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func setupUsernameLabel() {
        usernameLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        usernameLabel.textColor = .black
        contentView.addSubview(usernameLabel)
        
        usernameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(storyImageView.snp.bottom).offset(4)
        }
    }
    
    private func setupTimeLabel() {
        timeLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
        timeLabel.textColor = .lightGray
        contentView.addSubview(timeLabel)
        
        timeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(captionLabel.snp.bottom).offset(4)
        }
    }
}
