//
//  CustomHeaderView.swift
//  A4
//
//  Created by Christopher Cheng on 12/6/24.
//

import UIKit

class CustomHeaderView: UIView {
    
    // MARK: - Properties
    private let logoImageView = UIImageView()
    let titleLabel = UILabel()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    private func setupView() {
        backgroundColor = UIColor.systemBlue.withAlphaComponent(0.4)
        // Configure logo
        logoImageView.image = UIImage(named: "logo") // Replace "logo" with your asset name
        logoImageView.contentMode = .scaleAspectFit
        addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure title
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints
        NSLayoutConstraint.activate([
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20),
            logoImageView.widthAnchor.constraint(equalToConstant: 50),
            logoImageView.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 25)
        ])
    }
}
