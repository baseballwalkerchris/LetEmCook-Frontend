//
//  FridgeIngredientsCell.swift
//  A4
//
//  Created by Aidan Joseph on 12/6/24.
//
import UIKit
import SnapKit

class ItemCell: UICollectionViewCell {
    
    static let reuse = "ItemCell"
    
    private var imageView = UIImageView()
    private let nameLabel = UILabel()
    private let removeButton = UIButton()
    private let checkmarkBox = UIButton()
    private let addButton = UIButton()
    
    //mark: data for checkmark
    private var didCheckmark: Bool
    
    override init(frame: CGRect) {
        self.didCheckmark = false
        super.init(frame: frame)
        
        
        
        
        setupImageView()
        setupNameLabel()
        setUpRemoveButton()
        setUpCheckmarkBox()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
    }
    
    private func setupNameLabel() {
        nameLabel.font = .systemFont(ofSize: 11)
        nameLabel.textAlignment = .center
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(1)
            make.leading.equalToSuperview().inset(12)
        }
    }
    
    private func setUpRemoveButton() {
        removeButton.setImage(UIImage(named: "removeButton"), for: .normal)
        removeButton.layer.cornerRadius = 30/2
        
        contentView.addSubview(removeButton)
        removeButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
            make.size.height.equalTo(15)
        }
    }
    
    func configure(with itemName: String, with imageName: String) {
        nameLabel.text = itemName
        imageView.image = UIImage(named: imageName) // Replace with actual image
    }
    
    func configureAddButton() {
        imageView.isHidden = true
        nameLabel.isHidden = true
        removeButton.isHidden = true
        checkmarkBox.isHidden = true
        setUpAddButton()
    }
    
    private func setUpAddButton() {
        addButton.contentMode = .scaleAspectFill
        addButton.clipsToBounds = true
        addButton.layer.cornerRadius = 8
        addButton.setImage(UIImage(named: "addIngredientButton"), for: .normal)
        
        contentView.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
    }
    
    private func setUpCheckmarkBox() {
        checkmarkBox.contentMode = .scaleAspectFill
        checkmarkBox.clipsToBounds = true
        checkmarkBox.setImage(UIImage(named: "uncheckedButton"), for: .normal)
        checkmarkBox.addTarget(self, action: #selector(checkmarkBoxTapped), for: .touchUpInside)
        
        contentView.addSubview(checkmarkBox)
        
        checkmarkBox.snp.makeConstraints{ make in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(10)
            make.height.width.equalTo(10)
        }
    }
    
    @objc private func checkmarkBoxTapped() {
        didCheckmark.toggle()
        if didCheckmark{
            checkmarkBox.setImage(UIImage(named: "checkmarkedButton"), for: .normal)
        } else{
            checkmarkBox.setImage(UIImage(named: "uncheckedButton"), for: .normal)
        }
        
    }
}
