//
//  FridgeIngredientsCell.swift
//  A4
//
//  Created by Aidan Joseph on 12/6/24.
//
import UIKit
import SnapKit

protocol ItemCellDelegate: AnyObject {
    func addButtonTapped()
}


class ItemCell: UICollectionViewCell {
    
    static let reuse = "ItemCell"
    
    private var imageView = UIImageView()
    private let nameLabel = UILabel()
    private let removeButton = UIButton()
    private let addButton = UIButton()
    
    weak var delegate: ItemCellDelegate?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupNameLabel()
        setUpRemoveButton()
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
        nameLabel.font = .systemFont(ofSize: 12)
        nameLabel.textAlignment = .center
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
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
        setUpAddButton()
    }
    
    private func setUpAddButton() {
        addButton.contentMode = .scaleAspectFill
        addButton.clipsToBounds = true
        addButton.layer.cornerRadius = 8
        addButton.setImage(UIImage(named: "addIngredientButton"), for: .normal)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        contentView.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
    }
    
    @objc private func addButtonTapped() {
        delegate?.addButtonTapped() // Notify delegate when button is tapped
    }
}

