//
//  RecipeViewCell.swift
//  A4
//
//  Created by Aidan Joseph on 11/25/24.
//

import UIKit
import SnapKit
import SDWebImage

class ReceipeViewCell: UICollectionViewCell {
    
    // MARK: - Properties (view)
    private let username = UILabel()
    private let caption = UILabel()
    private let foodImage = UIImageView()
    private let bookmarkButton = UIButton()
    private let timePassedSincePosted = UILabel()
    var onImageTapped: (() -> Void)?
    
    static let reuse = "RecipeViewCellReuse"
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        setUpFoodImage()
        setUpUsername()
        setUpCaption()
        setUpBookmarkButton()
        setUpTimeSincePosted()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure cell function
    func recipeConfigure(recipePost: RecipePost){
        //setupimage
        let recipeImageUrl = URL(string: recipePost.imageURL)
        foodImage.sd_setImage(with: recipeImageUrl)
        //foodImage.image = UIImage(named: recipePost.imageURL)
        username.text = recipePost.username
        //caption.text = recipePost.caption
        timePassedSincePosted.text = recipePost.time.convertToAgo()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = CGFloat(recipePost.username.count * 8)
        paragraphStyle.headIndent = 0// First line stays aligned with the username// Indentation for subsequent lines
        
        let attributedCaption = NSAttributedString(
            string: recipePost.caption,
            attributes: [
                .font: UIFont.systemFont(ofSize: 14, weight: .light).rounded,
                .foregroundColor: UIColor.a4.black,
                .paragraphStyle: paragraphStyle
            ]
        )
        caption.attributedText = attributedCaption
    
        
    }
    
    //MARK: Set up functions
    private func setUpFoodImage(){
        foodImage.contentMode = .scaleAspectFill
        foodImage.clipsToBounds = true
        foodImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        foodImage.addGestureRecognizer(tapGesture)
       
        contentView.addSubview(foodImage)
        
        foodImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(30)
            make.height.equalTo(contentView.snp.width).multipliedBy(0.75)
        }
    }
    
    private func setUpUsername(){
        username.textColor = UIColor.a4.black
        username.font = .systemFont(ofSize: 14, weight: .semibold).rounded
        //username.numberOfLines = 1
        
        contentView.addSubview(username)
        username.snp.makeConstraints { make in
            make.top.equalTo(foodImage.snp.bottom).offset(6)
            make.leading.equalToSuperview().inset(8)
        }
    }
    
    private func setUpCaption(){
        caption.textColor = UIColor.a4.black
        caption.font = .systemFont(ofSize: 10, weight: .light).rounded
        caption.numberOfLines = 0
        caption.lineBreakMode = .byWordWrapping
        //caption.firstBaselineAnchor.constraint(equalTo: username.lastBaselineAnchor).isActive = true

        
        contentView.addSubview(caption)
      
        caption.snp.makeConstraints { make in
            make.top.equalTo(foodImage.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(8)
           // make.top.equalTo(username.snp.top) // Align first line with username's top
            make.trailing.equalToSuperview().offset(12)
            
        }
    }
    
    private func setUpBookmarkButton(){
        bookmarkButton.setImage(UIImage(named: "notBookmarked"), for: .normal)
        bookmarkButton.tintColor = .darkGray
        contentView.addSubview(bookmarkButton)
        
        bookmarkButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(20)
            make.width.equalTo(14)
        }
        
    }
    
    private func setUpTimeSincePosted(){
        timePassedSincePosted.textColor = UIColor.a4.silver
        timePassedSincePosted.font = .systemFont(ofSize: 8, weight: .light).rounded
        timePassedSincePosted.numberOfLines = 1
        
        contentView.addSubview(timePassedSincePosted)
        timePassedSincePosted.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(4)
        }
    }
    
    @objc private func imageTapped() {
        onImageTapped?()
    }
    
}


