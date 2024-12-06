//
//  UserCell.swift
//  A4
//
//  Created by Aidan Joseph on 12/5/24.
//

import UIKit
import SnapKit
import SDWebImage

class UserCell: UICollectionViewCell {
    //MARK: Properties - Views
    private let userImage = UIImageView()
    private let username = UILabel()
    
    
    static let reuse = "SocialEventViewCellReuse"
    
    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.a4.offWhite
        setUpUserImage()
        setUpUsername()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(user: User) {
        userImage.image = UIImage(named: user.userImage)
        username.text = user.username
    }
    
    
    private func setUpUserImage(){
        userImage.contentMode = .scaleAspectFill
        userImage.clipsToBounds = true
        userImage.layer.cornerRadius = 30
        
        contentView.addSubview(userImage)
        userImage.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(15)
        }
    }
    
    private func setUpUsername(){
        username.textColor = UIColor.a4.white
        username.font = .systemFont(ofSize: 10, weight: .light).rounded
        contentView.addSubview(username)
        
        username.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userImage.snp.bottom).offset(4)
        }
    }
   
}
