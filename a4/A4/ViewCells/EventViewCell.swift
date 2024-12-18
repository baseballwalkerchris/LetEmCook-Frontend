//
//  SocialEventViewCell.swift
//  A4
//
//  Created by Aidan Joseph on 11/26/24.
//

import UIKit
import SnapKit
import SDWebImage

class EventViewCell: UICollectionViewCell {
    
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
    
    private let gradientLayer = CAGradientLayer()
    
    static let reuse = "EventViewCellReuse"


    
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
    
    //MARK: - Configure
    func configure(event: Event) {
        // Set up the food image
        if let recipeImageUrl = URL(string: event.imageUrl) {
            foodImage.sd_setImage(with: recipeImageUrl)
        }
        
        // Assign title and user details
        eventName.text = event.title
        eventName.textColor = .black
        author.text = "From cdc236"
        
        // Set attendees' capacity
        attendeesLabel.text = "\(event.numberGoing) attendees"

        // Assign location
        locationLabel.text = event.location

        // Format and assign the event date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy h:mm a" // Example: Dec 12, 2024 5:30 PM
        timeLabel.text = dateFormatter.string(from: event.createdAt)

        // Assign event description
        descriptionMessage.text = event.caption
    }
    
    //MARK: Set up functions
    private func setUpFoodImage(){
        //foodImage.clipsToBounds = true
        foodImage.contentMode = .scaleAspectFill
        foodImage.layer.shadowColor = UIColor.black.cgColor
        foodImage.layer.shadowOpacity = 1.0 // Adjust transparency
        foodImage.layer.shadowRadius = 15 // Soften the shadow
        foodImage.layer.shadowOffset = CGSize(width: -15, height: -15) // Position the shadow
        foodImage.clipsToBounds = false // Make sure the shadow is not clipped
        contentView.addSubview(foodImage)
        
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            foodImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            foodImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            foodImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            foodImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6) // Adjust the height ratio
        ])
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
    
    private func setUpEventName(){
        eventName.textColor = UIColor.a4.white
        eventName.font = .systemFont(ofSize: 18, weight: .bold).rounded
        foodImage.addSubview(eventName)
        
        eventName.snp.makeConstraints{ make in
            make.bottom.equalTo(foodImage.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(6)
        }
    }
    
    private func setUpAuthorName(){
        author.textColor = UIColor.a4.white
        author.font = .systemFont(ofSize: 10, weight: .light).rounded
        foodImage.addSubview(author)
        
        
        author.snp.makeConstraints{ make in
            make.top.equalTo(eventName.snp.bottom).offset(1)
            make.leading.equalToSuperview().inset(8)
        }
    }
    
    private func setUpAttendeesImage(){
        attendeesImage.image = UIImage(named: "attendeeImage")
        contentView.addSubview(attendeesImage)
        
        attendeesImage.snp.makeConstraints{ make in
            make.width.equalTo(9.23)
            make.height.equalTo(10)
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(foodImage.snp.bottom).offset(22)
        }
    }
    
    private func setUpAttendeesLabel(){
        attendeesLabel.textColor = UIColor.a4.black
        attendeesLabel.font = .systemFont(ofSize: 10, weight: .light).rounded
        contentView.addSubview(attendeesLabel)

        attendeesLabel.snp.makeConstraints{ make in
            make.leading.equalTo(attendeesImage.snp.trailing).offset(4)
            make.centerY.equalTo(attendeesImage.snp.centerY)
        }
    }
    
    private func setUpTimeImage(){
        timeImage.image = UIImage(named: "timeImage")
        contentView.addSubview(timeImage)
        
        timeImage.snp.makeConstraints{ make in
            make.width.equalTo(8)
            make.height.equalTo(8)
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(attendeesImage.snp.bottom).offset(8)
        }
    }
    
    private func setUpTimeLabel(){
        timeLabel.textColor = UIColor.a4.black
        timeLabel.font = .systemFont(ofSize: 10, weight: .light).rounded
        contentView.addSubview(timeLabel)

        timeLabel.snp.makeConstraints{ make in
            make.leading.equalTo(timeImage.snp.trailing).offset(4)
           // make.top.equalTo(attendeesImage.snp.bottom).offset(8)
            make.centerY.equalTo(timeImage.snp.centerY)
        }
    }
    
    private func setUpLocationImage(){
        locationImage.image = UIImage(named: "locationImage")
        contentView.addSubview(locationImage)
        
        locationImage.snp.makeConstraints{ make in
            make.width.equalTo(7.68)
            make.height.equalTo(12.43)
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(timeImage.snp.bottom).offset(8)
        }
    }
    
    private func setUpLocationLabel(){
        locationLabel.textColor = UIColor.a4.black
        locationLabel.font = .systemFont(ofSize: 10, weight: .light).rounded
        contentView.addSubview(locationLabel)

        locationLabel.snp.makeConstraints{ make in
            make.leading.equalTo(locationImage.snp.trailing).offset(4)
            make.top.equalTo(timeImage.snp.bottom).offset(8)
        }
    }
    
    private func setUpDescriptionTitle(){
        descriptionTitle.text = "DESCRIPTION"
        descriptionTitle.textColor = UIColor.a4.black
        descriptionTitle.font = .systemFont(ofSize: 12, weight: .semibold).rounded
        contentView.addSubview(descriptionTitle)
        
        descriptionTitle.snp.makeConstraints{ make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(locationImage.snp.bottom).offset(8)
        }
    }
    
    private func setUpDescriptionMessage(){
        descriptionMessage.textColor = UIColor.a4.black
        descriptionMessage.font = .systemFont(ofSize: 10, weight: .light).rounded
        descriptionMessage.numberOfLines = 0
        descriptionMessage.lineBreakMode = .byWordWrapping
        contentView.addSubview(descriptionMessage)
        
        descriptionMessage.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(descriptionTitle.snp.bottom).offset(2)
        }
    }
    
    
    private func setUpGradientLayer() {
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0.8).cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0.0, 1.0] // Dark at bottom, transparent at top
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.frame = CGRect(x: 0, y: foodImage.frame.height - 100, width: foodImage.frame.width, height: 100)
        foodImage.layer.addSublayer(gradientLayer)
        
        
    }
    
}


