//
//  SocialEventViewCell.swift
//  A4
//
//  Created by Aidan Joseph on 11/26/24.
//

import UIKit
import SnapKit
import SDWebImage

class SocialEventViewCell: UICollectionViewCell {
    
    // MARK: - Properties (view)
    private let foodImage = UIImageView()
    private let eventName = UILabel()
    private let author = UILabel()
    private let bookmarkButton = UIButton()
    //attendees/freidns going
    private let attendeesProfPic = UIImageView()
    private let attendeesGoing = UILabel()
    //people attending
    private let attendeesImage = UIImageView()
    private let attendeesLabel = UILabel()
    //time of event
    private let timeImage = UIImageView()
    ///need to figure out how to decode or foramt
    private let timeLabel = UILabel()
    //location of event
    private let locationImage = UIImageView()
    private let locationLabel = UILabel()
    //description of evemt
    private let descriptionTitle = UILabel()
    private let descriptionMessage = UILabel()
    
    static let reuse = "SocialEventViewCellReuse"
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.a4.offWhite
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        setUpFoodImage()
        setUpBookmarkButton()
        setUpEventName()
        setUpAuthorName()
        setUpAttendeesImage()
        setUpAttendeesLabel()
        setUpTimeImage()
        setUpTimeLabel()
        setUpLocationImage()
        setUpLocationLabel()
        setUpDescriptionTitle()
        setUpDescriptionMessage()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure, TO DO
    func socialConfigure(socialEvent: SocialEventPost){
        //setupimage
        let recipeImageUrl = URL(string: socialEvent.imageURL)
        foodImage.sd_setImage(with: recipeImageUrl)
        eventName.text = socialEvent.eventName
        author.text = socialEvent.author
        attendeesLabel.text = "\(socialEvent.maxCount) total"
        locationLabel.text = socialEvent.location
        timeLabel.text = socialEvent.date
        descriptionMessage.text = socialEvent.descriptionOfEvent
      
    }
    
    //MARK: Set up functions
    private func setUpFoodImage(){
        foodImage.clipsToBounds = true
        foodImage.contentMode = .scaleAspectFill
        contentView.addSubview(foodImage)
        
        
        foodImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(70)
        }
    }
    
    private func setUpBookmarkButton(){
        contentView.addSubview(bookmarkButton)
        
        bookmarkButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.trailing.equalToSuperview().inset(6)
        }
    }
    
    private func setUpEventName(){
        eventName.textColor = UIColor.a4.white
        eventName.font = .systemFont(ofSize: 24, weight: .bold).rounded
        contentView.addSubview(eventName)
        
        eventName.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(25)
            make.leading.equalToSuperview().inset(6)
        }
    }
    
    private func setUpAuthorName(){
        author.textColor = UIColor.a4.white
        author.font = .systemFont(ofSize: 12, weight: .semibold).rounded
        contentView.addSubview(author)
        
        author.snp.makeConstraints{ make in
            make.top.equalTo(eventName.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(8)
        }
    }
    
    private func setUpAttendeesImage(){
        attendeesImage.image = UIImage(named: "attendeeImage")
        contentView.addSubview(attendeesImage)
        
        attendeesImage.snp.makeConstraints{ make in
            make.width.equalTo(10)
            make.height.equalTo(10)
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(foodImage.snp.bottom).offset(4)
        }
    }
    
    private func setUpAttendeesLabel(){
        attendeesLabel.textColor = UIColor.a4.black
        attendeesLabel.font = .systemFont(ofSize: 10, weight: .semibold).rounded
        contentView.addSubview(attendeesLabel)

        attendeesLabel.snp.makeConstraints{ make in
            make.leading.equalTo(attendeesImage.snp.trailing).offset(4)
            make.top.equalTo(foodImage.snp.bottom).offset(4)
        }
    }
    
    private func setUpTimeImage(){
        timeImage.image = UIImage(named: "timeImage")
        contentView.addSubview(timeImage)
        
        timeImage.snp.makeConstraints{ make in
            make.width.equalTo(10)
            make.height.equalTo(10)
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(attendeesImage.snp.bottom).offset(4)
        }
    }
    
    private func setUpTimeLabel(){
        attendeesLabel.textColor = UIColor.a4.black
        attendeesLabel.font = .systemFont(ofSize: 10, weight: .semibold).rounded
        contentView.addSubview(timeLabel)

        timeLabel.snp.makeConstraints{ make in
            make.leading.equalTo(timeImage.snp.trailing).offset(4)
            make.top.equalTo(attendeesImage.snp.bottom).offset(4)
        }
    }
    
    private func setUpLocationImage(){
        locationImage.image = UIImage(named: "locationImage")
        contentView.addSubview(locationImage)
        
        locationImage.snp.makeConstraints{ make in
            make.width.equalTo(10)
            make.height.equalTo(10)
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(timeImage.snp.bottom).offset(4)
        }
    }
    
    private func setUpLocationLabel(){
        locationLabel.textColor = UIColor.a4.black
        locationLabel.font = .systemFont(ofSize: 10, weight: .semibold).rounded
        contentView.addSubview(locationLabel)

        locationLabel.snp.makeConstraints{ make in
            make.leading.equalTo(timeImage.snp.trailing).offset(4)
            make.top.equalTo(locationImage.snp.bottom).offset(4)
        }
    }
    
    private func setUpDescriptionTitle(){
        descriptionTitle.textColor = UIColor.a4.black
        descriptionTitle.font = .systemFont(ofSize: 14, weight: .bold).rounded
        contentView.addSubview(descriptionTitle)
        
        descriptionTitle.snp.makeConstraints{ make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(locationImage.snp.bottom).offset(4)
        }
    }
    
    private func setUpDescriptionMessage(){
        descriptionMessage.textColor = UIColor.a4.black
        descriptionMessage.font = .systemFont(ofSize: 14, weight: .semibold).rounded
        descriptionMessage.numberOfLines = 3
        contentView.addSubview(descriptionMessage)
        
        descriptionMessage.snp.makeConstraints{ make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(descriptionTitle.snp.bottom).offset(4)
        }
    }
    
}

