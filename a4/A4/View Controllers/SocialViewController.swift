//
//  SocialViewController.swift
//  A4
//
//  Created by Aidan Joseph on 12/5/24.
//

import UIKit
import SDWebImage
import SnapKit
import SwiftUI

protocol SocialEventViewControllerDelegate: AnyObject {
    func passSocialInfo()
}

class SocialEventViewController: UIViewController {
    
    //MARK: Properties (View)
    private let foodImage = UIImageView()
    private let eventName = UILabel()
    private let author = UILabel()
    private let goingButton = UIButton()
    private let dayWord = UILabel()
    private let dayText = UILabel()
    private let durationWord = UILabel()
    private let durationText = UILabel()
    private let locationWord = UILabel()
    private let locationText = UILabel()
    private let mustBringWord = UILabel()
    private let mustBringText = UILabel()
    private let detailsWord = UILabel()
    private let detailsText = UILabel()
    private let organizersWord = UILabel()
    private let attendeesWord = UILabel()
    
    //MARK: - collection views for organizer/attendees
    private var organizerCollectionView: UICollectionView!
    private var attendeesCollectionView: UICollectionView!
    
    //MARK: Properties(scroll/contentview)
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let organizerContainerView = UIView()
    private let attendeesContainerView = UIView()
    
    //MARK: - Delegate Property
    weak var delegate: (SocialEventViewControllerDelegate)?
    
    //MARK: - Dummy data for users/organizers
    private var organizers: [User] = [
        User(id: 1, username: "adam", userImage: "profileImage"),
        User(id: 2, username: "jimmy", userImage: "profileImage")
    ]
    
    private var attendees: [User] = [
        User(id: 3, username: "elizabeth", userImage: "profileImage"),
        User(id: 4, username: "fred", userImage: "profileImage"),
        User(id: 5, username: "gram", userImage: "profileImage"),
        User(id: 6, username: "ham", userImage: "profileImage"),
        User(id: 7, username: "jam", userImage: "profileImage"),
        User(id: 8, username: "kam", userImage: "profileImage"),
        User(id: 9, username: "sam", userImage: "profileImage")
        
    ]
    
    //MARK: Override func
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.a4.offWhite
        setupScrollView()
        setUpFoodImage()
        setUpEventName()
        setUpAuthor()
        setUpGoingButton()
        setUpDayWord()
        setUpDayText()
        setUpDurationWord()
        setUpDurationText()
        setUpLocationWord()
        setUpLocationText()
        setUpMustBringWord()
        setUpMustBringText()
        setUpDetailsWord()
        setUpDetailsText()
        setUpOrganizersWord()
       // setUpOrganizerContainerView()
        setUpOrganizerCollectionView()
        setUpAttendeesWord()
        //setUpAttendeesContainerView()
        setUpAttendeesCollectionView()
    }
    
    // MARK: init
    
    init(socialPost: SocialEventPost) {
//        let eventName: String
//        let author: String
//        let maxCount: Int
//        let date: String
//        let location: String
//        let descriptionOfEvent: String
//        let currentAttendees: Int
//        let imageURL: String
        let recipeImageUrl = URL(string: socialPost.imageURL)
        foodImage.sd_setImage(with: recipeImageUrl)
        eventName.text = socialPost.eventName
        author.text = "By \(socialPost.author)"
        dayText.text = socialPost.date
        locationText.text = socialPost.location
        detailsText.text = socialPost.descriptionOfEvent
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Set up views functions
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
    
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
             contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
             contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
             contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
             contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
             contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor) // Critical for vertical scrolling
         ])
    }
    
    private func setUpFoodImage(){
        foodImage.contentMode = .scaleAspectFill
        foodImage.clipsToBounds = true
        contentView.addSubview(foodImage)
        
        foodImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
//            make.bottom.equalToSuperview().inset(30)
            make.height.equalTo(200)
        }
        
    }
    
    private func setUpEventName(){
        eventName.textColor = UIColor.a4.white
        eventName.font = .systemFont(ofSize: 30, weight: .bold).rounded
        contentView.addSubview(eventName)
        
        eventName.snp.makeConstraints{ make in
            make.bottom.equalTo(foodImage.snp.bottom).inset(30)
            make.leading.equalToSuperview().inset(6)
        }

    }
    
    private func setUpAuthor(){
        author.textColor = UIColor.a4.white
        author.font = .systemFont(ofSize: 20, weight: .bold).rounded
        contentView.addSubview(author)
        
        
        author.snp.makeConstraints{ make in
            make.top.equalTo(eventName.snp.bottom).offset(1)
            make.leading.equalToSuperview().inset(8)
        }
    }
    
    private func setUpGoingButton(){
        goingButton.setImage(UIImage(named: "going?Button"), for: .normal)
        contentView.addSubview(goingButton)
        
        goingButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(43)
            make.top.equalTo(foodImage.snp.bottom).offset(12)
        }
    }
    
    private func setUpDayWord(){
        dayWord.text = "Day:"
        dayWord.textColor = UIColor.a4.black
        dayWord.font = .systemFont(ofSize: 24, weight: .bold).rounded
        contentView.addSubview(dayWord)
        
        dayWord.snp.makeConstraints{ make in
            make.top.equalTo(goingButton.snp.bottom).offset(12)
            make.leading.equalTo(goingButton.snp.leading).inset(8)
            
        }
        
        
    }
    
    private func setUpDayText(){
        //dayText.text = "Day:"
        dayText.textColor = UIColor.a4.black
        dayText.font = .systemFont(ofSize: 24, weight: .light).rounded
        contentView.addSubview(dayText)
        
        dayText.snp.makeConstraints{ make in
            make.leading.equalTo(dayWord.snp.trailing).offset(4)
            make.centerY.equalTo(dayWord.snp.centerY)
        }
    }
    
    private func setUpDurationWord(){
        durationWord.text = "Duration:"
        durationWord.textColor = UIColor.a4.black
        durationWord.font = .systemFont(ofSize: 24, weight: .bold).rounded
        contentView.addSubview(durationWord)
        
        durationWord.snp.makeConstraints{ make in
            make.leading.equalTo(goingButton.snp.leading).inset(8)
            make.top.equalTo(dayWord.snp.bottom).offset(8)
        }
    }
    
    private func setUpDurationText(){
        //MARK: Dummy data
        durationText.text = "5pm to 9pm"
        durationText.textColor = UIColor.a4.black
        durationText.font = .systemFont(ofSize: 24, weight: .light).rounded
        contentView.addSubview(durationText)
        
        durationText.snp.makeConstraints{ make in
            make.leading.equalTo(durationWord.snp.trailing).offset(4)
            make.centerY.equalTo(durationWord.snp.centerY)
        }
    }
    
    private func setUpLocationWord(){
        locationWord.text = "Location:"
        locationWord.textColor = UIColor.a4.black
        locationWord.font = .systemFont(ofSize: 24, weight: .bold).rounded
        contentView.addSubview(locationWord)
        
        locationWord.snp.makeConstraints{ make in
            make.leading.equalTo(goingButton.snp.leading).inset(8)
            make.top.equalTo(durationWord.snp.bottom).offset(12)
        }
    }
    
    private func setUpLocationText(){
        locationText.textColor = UIColor.a4.black
        locationText.font = .systemFont(ofSize: 24, weight: .light).rounded
        contentView.addSubview(locationText)
        
        locationText.snp.makeConstraints{ make in
            make.leading.equalTo(locationWord.snp.trailing).offset(4)
            make.centerY.equalTo(locationWord.snp.centerY)
        }
    }
    
    private func setUpMustBringWord(){
        mustBringWord.text = "Must Bring:"
        mustBringWord.textColor = UIColor.a4.black
        mustBringWord.font = .systemFont(ofSize: 24, weight: .bold).rounded
        contentView.addSubview(mustBringWord)
        
        mustBringWord.snp.makeConstraints{ make in
            make.leading.equalTo(goingButton.snp.leading).inset(8)
            make.top.equalTo(locationWord.snp.bottom).offset(12)
        }
    }
    
    private func setUpMustBringText(){
        //MARK: Dummy data
        mustBringText.text = "any food item"
        mustBringText.textColor = UIColor.a4.black
        mustBringText.font = .systemFont(ofSize: 24, weight: .light).rounded
        contentView.addSubview(mustBringText)
        
        mustBringText.snp.makeConstraints{ make in
            make.leading.equalTo(mustBringWord.snp.trailing).offset(4)
            make.centerY.equalTo(mustBringWord.snp.centerY)
        }
    }
    
    private func setUpDetailsWord(){
        detailsWord.text = "Details:"
        detailsWord.textColor = UIColor.a4.black
        detailsWord.font = .systemFont(ofSize: 24, weight: .bold).rounded
        contentView.addSubview(detailsWord)
        
        detailsWord.snp.makeConstraints{ make in
            make.leading.equalTo(goingButton.snp.leading).inset(8)
            make.top.equalTo(mustBringWord.snp.bottom).offset(12)
        }
    }
    
    private func setUpDetailsText(){
        detailsText.textColor = UIColor.a4.black
        detailsText.font = .systemFont(ofSize: 20, weight: .light).rounded
        detailsText.numberOfLines = 0
        detailsText.lineBreakMode = .byWordWrapping
        contentView.addSubview(detailsText)
        
        detailsText.snp.makeConstraints{ make in
            make.leading.trailing.equalTo(goingButton).inset(8)
            make.top.equalTo(detailsWord.snp.bottom).offset(4)
           // make.bottom.equalToSuperview().inset(16) // Bottom inset for scrolling
        }
    }
    
    private func setUpOrganizersWord(){
        organizersWord.text = "Organizers:"
        organizersWord.textColor = UIColor.a4.black
        organizersWord.font = .systemFont(ofSize: 24, weight: .bold).rounded
        contentView.addSubview(organizersWord)
        
        organizersWord.snp.makeConstraints{ make in
            make.leading.equalTo(goingButton.snp.leading).inset(8)
            make.top.equalTo(detailsText.snp.bottom).offset(12)
        }
    }
    
//    private func setUpOrganizerContainerView(){
//        organizerContainerView.backgroundColor = UIColor.a4.offWhite // Or your preferred color
//        organizerContainerView.layer.masksToBounds = true // Ensures content is clipped to bounds
//        organizerContainerView.layer.borderWidth = 0 // Optional: For a border
//        
//        contentView.addSubview(organizerContainerView)
//        organizerContainerView.snp.makeConstraints{ make in
//            make.top.equalTo(organizersWord.snp.bottom).offset(2)
//            make.leading.trailing.equalToSuperview().inset(16)
//            make.height.equalTo(100) // Adjust height as needed
//        }
//    }
    
    private func setUpOrganizerCollectionView(){
        let organizerLayout = UICollectionViewFlowLayout()
        organizerLayout.scrollDirection = .horizontal
        organizerLayout.minimumInteritemSpacing = 8
        organizerLayout.itemSize = CGSize(width: 60, height: 60)

        organizerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: organizerLayout)
        organizerCollectionView.backgroundColor = .clear
        organizerCollectionView.dataSource = self
        organizerCollectionView.delegate = self
        organizerCollectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reuse)

        contentView.addSubview(organizerCollectionView)
        organizerCollectionView.snp.makeConstraints { make in
            make.top.equalTo(organizersWord.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(150)
        }
        
    }
    
    private func setUpAttendeesWord(){
        attendeesWord.text = "Attendees:"
        attendeesWord.textColor = UIColor.a4.black
        attendeesWord.font = .systemFont(ofSize: 24, weight: .bold).rounded
        contentView.addSubview(attendeesWord)
        
        attendeesWord.snp.makeConstraints{ make in
            make.leading.equalTo(goingButton.snp.leading).inset(8)
            make.top.equalTo(organizerCollectionView.snp.bottom).offset(5)
        }
    }
    
//    private func setUpAttendeesContainerView(){
//        attendeesContainerView.backgroundColor = UIColor.a4.offWhite // Or your preferred color
//        attendeesContainerView.layer.masksToBounds = true // Ensures content is clipped to bounds
//        attendeesContainerView.layer.borderWidth = 0 // Optional: For a border
//        
//        contentView.addSubview(attendeesContainerView)
//        attendeesContainerView.snp.makeConstraints{ make in
//            make.top.equalTo(attendeesWord.snp.bottom).offset(16)
//            make.leading.trailing.equalToSuperview()
//            make.height.equalTo(120) // Adjust height for proper scrolling
//            make.bottom.equalToSuperview()
//        }
//    }
    
    private func setUpAttendeesCollectionView(){
        let attendeesLayout = UICollectionViewFlowLayout()
        //attendeesLayout.scrollDirection = .vertical
        attendeesLayout.minimumLineSpacing = 8
        attendeesLayout.itemSize = CGSize(width: 60, height: 80)

        attendeesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: attendeesLayout)
        attendeesCollectionView.backgroundColor = .clear
        attendeesCollectionView.dataSource = self
        attendeesCollectionView.delegate = self
        attendeesCollectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reuse)

        contentView.addSubview(attendeesCollectionView)
        attendeesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(attendeesWord.snp.bottom).offset(-2)
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(300) // Adjust height for proper scrolling
            make.bottom.equalToSuperview()
        }
    }
}

extension SocialEventViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // One section for "Create Post" and the other for posts
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == organizerCollectionView {
               return organizers.count
        } else {
               return attendees.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        if indexPath.section == 0 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCell.reuse, for: indexPath) as! UserCell
//            cell.configure(user: organizers[indexPath.item])
//            return cell
//        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCell.reuse, for: indexPath) as! UserCell
//            cell.configure(user: attendees[indexPath.item])
//            return cell
//        }
        if collectionView == organizerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCell.reuse, for: indexPath) as! UserCell
            cell.configure(user: organizers[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCell.reuse, for: indexPath) as! UserCell
            cell.configure(user: attendees[indexPath.item])
            return cell
        }
    }

}
    //MARK: UICollectionViewDelegate
    extension SocialEventViewController: UICollectionViewDelegate {
        
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout [PART II]

extension SocialEventViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 40, left: 0, bottom: 40, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat = 16
        let availableWidth = collectionView.frame.width - padding * 3
        let cellWidth = availableWidth / 4
        return CGSize(width: cellWidth, height: 100)
    }
}
