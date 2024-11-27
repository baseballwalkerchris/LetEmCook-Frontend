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
        contentView.backgroundColor = UIColor.a4.offWhite
        
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
    func configure(recipePost: RecipePost){
        //setupimage
//        let recipeImageUrl = URL(string: recipePost.imageURL)
//        foodImage.sd_setImage(with: recipeImageUrl)
        foodImage.image = UIImage(named: recipePost.imageURL)
        username.text = recipePost.username
        caption.text = recipePost.caption
        timePassedSincePosted.text = recipePost.time.convertToAgo()
        
        
    }
    
    //MARK: Set up functions
    private func setUpFoodImage(){
        foodImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        foodImage.addGestureRecognizer(tapGesture)
        foodImage.clipsToBounds = true
        foodImage.layer.cornerRadius = 10
        contentView.addSubview(foodImage)
        
        foodImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(30)
        }
    }
    
    private func setUpUsername(){
        username.textColor = UIColor.a4.black
        username.font = .systemFont(ofSize: 16, weight: .bold).rounded
        username.numberOfLines = 1
        
        contentView.addSubview(username)
        username.snp.makeConstraints { make in
            make.top.equalTo(foodImage.snp.bottom).offset(6)
            make.leading.equalToSuperview().inset(4)
        }
    }
    
    private func setUpCaption(){
        caption.textColor = UIColor.a4.black
        caption.font = .systemFont(ofSize: 16, weight: .bold).rounded
        caption.numberOfLines = 2
        
        contentView.addSubview(caption)
        caption.snp.makeConstraints { make in
            make.top.equalTo(foodImage.snp.bottom).offset(6)
            make.leading.equalTo(username.snp.trailing).offset(2)
        }
    }
    
    private func setUpBookmarkButton(){
        
        contentView.addSubview(bookmarkButton)
        bookmarkButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.trailing.equalToSuperview().inset(6)
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

