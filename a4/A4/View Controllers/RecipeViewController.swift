//
//  RecipeViewController.swift
//  A4
//
//  Created by Christopher Cheng on 11/26/24.
//

import UIKit
import SDWebImage
import SnapKit
import SwiftUI

class RecipeViewController: UIViewController {
    
    // MARK: - Properties (view)
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let recipeImageView = UIImageView()
    private let recipeTitleLabel = UILabel()
    private let authorLabel = UILabel()
    private let timeLabel = UILabel()
    private let servingsLabel = UILabel()
    private let ratingsLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let dividerViewOne = UIView()
    private let ingredientsLabel = UILabel()
    private var ingredientsCollectionView: UICollectionView!
    private let dividerViewTwo = UIView()
    private let directionsLabel = UILabel()
    private var directionsCollectionView: UICollectionView!

    
    // MARK: - Properties (data)
   
    private let ingredients = [
        "Milk", "Boba", "Black Tea", "Syrup", "Green Tea"
    ]
    private let ingredientImages = [
        UIImage(named: "milk"), UIImage(named: "boba"),
        UIImage(named: "black_tea"), UIImage(named: "syrup"),
        UIImage(named: "green_tea")
    ]
    
    private var directions: [Direction] = [
        Direction(stepNumber: 1, title: "Add ingredients", description: "Add milk, boba, black tea, syrup, and green tea to a blender.", isCompleted: true),
        Direction(stepNumber: 2, title: "Blend", description: "Blend until smooth.", isCompleted: false),
        Direction(stepNumber: 3, title: "Strain", description: "Strain into a glass.", isCompleted: false),
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
        
        setupScrollView()
        setupRecipeImageView()
        setupRecipeTitleLabel()
        setupAuthorLabel()
        setupTimeLabel()
        setupServingsLabel()
        setupRatingsLabel()
        setupDescriptionLabel()
        setupDividerViewOne()
        setupIngredientsLabel()
        setupIngredientsCollectionView()
        setupDividerViewTwo()
        setupDirectionsLabel()
        setupDirectionsCollectionView()
        setupPanGesture()
    }
    
    //MARK: - Set up views

    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupRecipeImageView() {
        recipeImageView.image = UIImage(named: "bubble_tea")
        
        contentView.addSubview(recipeImageView)
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
               recipeImageView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    private func setupRecipeTitleLabel() {
        recipeTitleLabel.text = "BUBBLE TEA"
        recipeTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        contentView.addSubview(recipeTitleLabel)
        recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeTitleLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 16),
            recipeTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupAuthorLabel() {
        authorLabel.text = "By Ava K"
        authorLabel.font = UIFont.systemFont(ofSize: 16)
        authorLabel.textColor = .gray
       
        contentView.addSubview(authorLabel)
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
        
        contentView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 16),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        ])
    }
    
    private func setupServingsLabel() {
        servingsLabel.text = "Makes: 20 serv"
        servingsLabel.font = UIFont.systemFont(ofSize: 16)
        servingsLabel.textColor = UIColor.a4.black
        
        contentView.addSubview(servingsLabel)
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
        
        contentView.addSubview(ratingsLabel)
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
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupDividerViewOne() {
        dividerViewOne.backgroundColor = .darkGray
        
        contentView.addSubview(dividerViewOne)
        dividerViewOne.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dividerViewOne.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            dividerViewOne.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dividerViewOne.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dividerViewOne.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupIngredientsLabel() {
        ingredientsLabel.text = "Ingredients"
        ingredientsLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        contentView.addSubview(ingredientsLabel)
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ingredientsLabel.topAnchor.constraint(equalTo: dividerViewOne.bottomAnchor, constant: 16),
            ingredientsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
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
        
        contentView.addSubview(ingredientsCollectionView)
        ingredientsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ingredientsCollectionView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 8),
            ingredientsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ingredientsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            ingredientsCollectionView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    private func setupDividerViewTwo() {
        dividerViewTwo.backgroundColor = .darkGray
        
        contentView.addSubview(dividerViewTwo)
        dividerViewTwo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dividerViewTwo.topAnchor.constraint(equalTo: ingredientsCollectionView.bottomAnchor, constant: 20),
            dividerViewTwo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dividerViewTwo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dividerViewTwo.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupDirectionsLabel() {
        directionsLabel.text = "DIRECTIONS"
        directionsLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        contentView.addSubview(directionsLabel)
        directionsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            directionsLabel.topAnchor.constraint(equalTo: dividerViewTwo.bottomAnchor, constant: 4),
            directionsLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupDirectionsCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = .zero

        
        directionsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        directionsCollectionView.delegate = self
        directionsCollectionView.dataSource = self
        directionsCollectionView.register(DirectionViewCell.self, forCellWithReuseIdentifier: DirectionViewCell.reuse)
        directionsCollectionView.backgroundColor = UIColor.a4.offWhite
        directionsCollectionView.isScrollEnabled = true

        
        contentView.addSubview(directionsCollectionView)
        directionsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            directionsCollectionView.topAnchor.constraint(equalTo: directionsLabel.bottomAnchor, constant: 8),
            directionsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            directionsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            directionsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            directionsCollectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    
    
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        contentView.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let currentTransform = contentView.transform.ty
        let maxOverlayPosition = -recipeImageView.frame.height + 150 // Fully overlay the image
        let minOriginalPosition: CGFloat = 0 // Fully revealed image
        
        // Adjust the `contentView` position within allowed limits
        let newTransformY = max(maxOverlayPosition, min(minOriginalPosition, currentTransform + translation.y))
        contentView.transform = CGAffineTransform(translationX: 0, y: newTransformY)
        
        // Reset the translation to 0 for incremental adjustment
        gesture.setTranslation(.zero, in: view)

        if gesture.state == .ended {
            let velocity = gesture.velocity(in: view).y
            let threshold: CGFloat = 200 // Velocity threshold for snapping
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                if velocity < -threshold || newTransformY < maxOverlayPosition / 2 {
                    // Snap to fully overlay
                    self.contentView.transform = CGAffineTransform(translationX: 0, y: maxOverlayPosition)
                } else {
                    // Snap back to fully revealed
                    self.contentView.transform = .identity
                }
            })
        }
    }
}

// MARK: - UICollectionView DataSource

extension RecipeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == ingredientsCollectionView {
            return ingredients.count
        } else {
            return directions.count
        }
    }
     
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == ingredientsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientViewCell.reuse, for: indexPath) as? IngredientViewCell else { return UICollectionViewCell() }
            let image = ingredientImages[indexPath.item]
            let text = ingredients[indexPath.item]
            cell.configure(with: image, text: text)
            return cell
        } else {
            // TODO: hard code for now
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DirectionViewCell.reuse, for: indexPath) as? DirectionViewCell else { return UICollectionViewCell() }
            let direction = directions[indexPath.item]
            cell.configure(stepNumber: direction.stepNumber, title: direction.title, description: direction.description, isCompleted: direction.isCompleted)
            cell.buttonAction = { [weak self] in
                self?.directions[indexPath.item].isCompleted.toggle()
                collectionView.reloadItems(at: [indexPath])
            }
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension RecipeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == ingredientsCollectionView {
            let size = collectionView.frame.width / 3 - 16
            return CGSize(width: size, height: 120)
        } else {
            // TODO: hard code for now
            return CGSize(width: collectionView.frame.width, height: 100)
        }
    }
    
}




