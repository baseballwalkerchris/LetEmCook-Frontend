//
//  RecipeViewController.swift
//  A4
//
//  Created by Christopher Cheng on 11/26/24.
//

import UIKit
import SDWebImage
import SnapKit

class RecipeViewController: UIViewController {
    
    // MARK: - Properties (view)
    //    private var collectionView: UICollectionView!
    private let recipeImageView = UIImageView()
    private let recipeTitleLabel = UILabel()
    private let authorLabel = UILabel()
    private let timeLabel = UILabel()
    private let servingsLabel = UILabel()
    private let ratingsLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let dividerView = UIView()
    private let ingredientsLabel = UILabel()
    private var ingredientsCollectionView: UICollectionView!
    
    // MARK: - Properties (data)
   
    private let ingredients = [
        "Milk", "Boba", "Black Tea", "Syrup", "Green Tea"
    ]
    private let ingredientImages = [
        UIImage(named: "milk"), UIImage(named: "boba"),
        UIImage(named: "black_tea"), UIImage(named: "syrup"),
        UIImage(named: "green_tea")
    ]
    
    
    // MARK: init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.a4.offWhite
        title = "Recipe"
        
        setupRecipeImageView()
        setupRecipeTitleLabel()
        setupAuthorLabel()
        setupTimeLabel()
        setupServingsLabel()
        setupRatingsLabel()
        setupDescriptionLabel()
        setupDividerView()
        setupIngredientsLabel()
        setupIngredientsCollectionView()
    }
    
    //MARK: - Set up views

    private func setupRecipeImageView() {
        recipeImageView.image = UIImage(named: "bubble_tea")
        
        view.addSubview(recipeImageView)
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
               recipeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
               recipeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               recipeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               recipeImageView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    private func setupRecipeTitleLabel() {
        recipeTitleLabel.text = "BUBBLE TEA"
        recipeTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        view.addSubview(recipeTitleLabel)
        recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeTitleLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 16),
            recipeTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupAuthorLabel() {
        authorLabel.text = "By Ava K"
        authorLabel.font = UIFont.systemFont(ofSize: 16)
        authorLabel.textColor = .gray
       
        view.addSubview(authorLabel)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: 4),
            authorLabel.leadingAnchor.constraint(equalTo: recipeTitleLabel.leadingAnchor),
        ])
    }
    
    private func setupTimeLabel() {
        timeLabel.text = "Time: 12 min"
        timeLabel.font = UIFont.systemFont(ofSize: 16)
        timeLabel.textColor = UIColor.a4.black
        
        view.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 16),
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
    }
    
    private func setupServingsLabel() {
        servingsLabel.text = "Makes: 20 serv"
        servingsLabel.font = UIFont.systemFont(ofSize: 16)
        servingsLabel.textColor = UIColor.a4.black
        
        view.addSubview(servingsLabel)
        servingsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            servingsLabel.topAnchor.constraint(equalTo: timeLabel.topAnchor),
            servingsLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 16),
        ])
    }
    
    private func setupRatingsLabel() {
        ratingsLabel.text = "Ratings: 8/10"
        ratingsLabel.font = UIFont.systemFont(ofSize: 16)
        ratingsLabel.textColor = UIColor.a4.black
        
        view.addSubview(ratingsLabel)
        ratingsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ratingsLabel.topAnchor.constraint(equalTo: timeLabel.topAnchor),
            ratingsLabel.leadingAnchor.constraint(equalTo: servingsLabel.trailingAnchor, constant: 16),
        ])
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.text = "Description: How to make creamy and not-too-sweet bubble tea using black tea, milk, and store-bought boba."
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupDividerView() {
        dividerView.backgroundColor = .darkGray
        
        view.addSubview(dividerView)
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupIngredientsLabel() {
        ingredientsLabel.text = "Ingredients"
        ingredientsLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        view.addSubview(ingredientsLabel)
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ingredientsLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 16),
            ingredientsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
    }
    
    private func setupIngredientsCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = .zero
        
        ingredientsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        ingredientsCollectionView.delegate = self
        ingredientsCollectionView.dataSource = self
        ingredientsCollectionView.register(IngredientViewCell.self, forCellWithReuseIdentifier: IngredientViewCell.reuse)
        ingredientsCollectionView.backgroundColor = UIColor.a4.offWhite
        
        view.addSubview(ingredientsCollectionView)
        ingredientsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ingredientsCollectionView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 8),
            ingredientsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ingredientsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ingredientsCollectionView.heightAnchor.constraint(equalToConstant: 150),
        ])

    }
}

// MARK: - UICollectionView DataSource

extension RecipeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredients.count
    }
     
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientViewCell.reuse, for: indexPath) as? IngredientViewCell else { return UICollectionViewCell() }
        let image = ingredientImages[indexPath.item]
        let text = ingredients[indexPath.item]
        cell.configure(with: image, text: text)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension RecipeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width / 3 - 16
        return CGSize(width: size, height: 120)
        
    }
    
}
