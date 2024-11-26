//
//  IngredientViewCell.swift
//  A4
//
//  Created by Christopher Cheng on 11/26/24.
//

import UIKit
import SnapKit
import SDWebImage

class IngredientViewCell: UICollectionViewCell {
    // MARK: - Properties (view)
    
    static let reuse = "IngredientViewCellReuse"
    private let imageView = UIImageView()
    private let label = UILabel()
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.a4.offWhite
        
        setupImageView()
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure cell function
    func configure(with image: UIImage?, text: String) {
        imageView.image = image
        label.text = text
    }
    
    //MARK: Set up functions
    
    private func setupImageView() {
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
        ])
        
    }
    
    private func setupLabel() {
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}



