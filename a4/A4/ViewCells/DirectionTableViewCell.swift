//
//  DirectionStepCell.swift
//  A4
//
//  Created by Christopher Cheng on 12/1/24.
//

import UIKit

class DirectionTableViewCell: UITableViewCell {
    
    // MARK: - Properties (view)
    private let stepButton = UIButton()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    static let reuse = "DirectionTableCellViewReuse"
    
    // Closure for button action
    var buttonAction: (() -> Void)?
    
    // MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.a4.offWhite
        
        setupStepButton()
        setupDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure cell function
    func configure(stepNumber: Int, description: String, isCompleted: Bool) {
        stepButton.setTitle(isCompleted ? "✓" : "\(stepNumber)", for: .normal)
        stepButton.backgroundColor = isCompleted ? .systemGreen : .systemBlue
        descriptionLabel.text = description
    }
    
    //MARK: Set up functions

    private func setupStepButton() {
        stepButton.setTitleColor(.white, for: .normal)
        stepButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        stepButton.backgroundColor = .systemBlue
        stepButton.layer.cornerRadius = 20
        stepButton.layer.masksToBounds = true
        
        contentView.addSubview(stepButton)
        stepButton.translatesAutoresizingMaskIntoConstraints = false
        stepButton.addTarget(self, action: #selector(stepButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            stepButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stepButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stepButton.widthAnchor.constraint(equalToConstant: 40),
            stepButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    
    private func setupDescriptionLabel() {
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 4
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // Button tap action
    @objc private func stepButtonTapped() {
        buttonAction?()
    }
}

