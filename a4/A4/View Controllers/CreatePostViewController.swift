//
//  CreatePostViewController.swift
//  A4
//
//  Created by Christopher Cheng on 12/3/24.
//

import UIKit

class CreatePostViewController: UIViewController, UIPickerViewDelegate {
    
    // MARK: - Properties (view)
    let customHeaderView = CustomHeaderView()
    let segmentedControl = UISegmentedControl(items: ["Story", "Recipe", "Event"])
    
    // Properties for stories
    let storyScrollView = UIScrollView()
    let storyContentView = UIView()
    let storyUploadImageLabel = UILabel()
    let storyUploadImageView = UIView()
    let storyUploadImageButton = UIButton()
    let storySelectedImageView = UIImageView()
    let captionLabel = UILabel()
    let captionTextView = UITextView()
    let publishButton = UIButton()
    
    // Properties for recipes
    let recipeScrollView = UIScrollView()
    let recipeContentView = UIView()
    let recipeTitleLabel = UILabel()
    let recipeTitleTextView = UITextView()
    let recipeUploadImageLabel = UILabel()
    let recipeUploadImageView = UIView()
    let recipeUploadImageButton = UIButton()
    let recipeSelectedImageView = UIImageView()
    let pickersStackView = UIStackView()
    let timePicker = UIPickerView()
    let servingsPicker = UIPickerView()
    let ratingPicker = UIPickerView()
    let recipeDescriptionLabel = UILabel()
    let recipeDescriptionTextView = UITextView()
    let ingredientsLabel = UILabel()
    var ingredientsCollectionView: UICollectionView!
    let addIngredientButton = UIButton()
    let directionsLabel = UILabel()
    let directionsStackView = UIStackView()
    let addDirectionButton = UIButton()
    let recipePublishButton = UIButton()

    // Properties for events
    let eventScrollView = UIScrollView()
    let eventContentView = UIView()
    let eventTitleLabel = UILabel()
    let eventTitleTextView = UITextView()
    let eventUploadImageLabel = UILabel()
    let eventUploadImageView = UIView()
    let eventUploadImageButton = UIButton()
    let eventSelectedImageView = UIImageView()
    let eventDescriptionLabel = UILabel()
    let eventDescriptionTextView = UITextView()
    let eventLocationLabel = UILabel()
    let eventLocationTextView = UITextView()
    let numberOfAttendeesLabel = UILabel()
    let numberOfAttendeesTextView = UITextView()
    let chooseADateLabel = UILabel()
    let datePicker = UIDatePicker()
    let selectedDateLabel = UILabel()
    let eventPublishButton = UIButton()
    
    // MARK: properties (data)
    // Data for pickers
    let timeOptions = ["5 min", "10 min", "15 min", "30 min", "1 hour", "2 hours"]
    let servingsOptions = ["1", "2", "4", "6", "8+"]
    let ratingOptions = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    // TODO: fetch all the ingredients from fridge
    var ingredients: [Ingredient] = [
//        Ingredient(id: 0, name: "Tomato", quantity: "5 of them", imageUrl: "tomato"),
//        Ingredient(id: 1, name: "Cucumber", quantity: "6 long ones", imageUrl: "cucumber")
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.a4.offWhite
        
        setupCustomHeaderView()
        setupSegmentedControl()
        
        // Story views
        setupStoryScrollView()
        setupStoryContentView()
        setupStoryUploadImageLabel()
        setupStoryUploadImageView()
        setupStoryUploadImageButton()
        setupStorySelectedImageView()
        setupCaptionLabel()
        setupCaptionTextView()
        setupPublishButton()
        
        // Recipe views
        setupRecipeScrollView()
        setupRecipeContentView()
        setupRecipeTitleLabel()
        setupRecipeTitleTextView()
        setupRecipeUploadImageLabel()
        setupRecipeUploadImageView()
        setupRecipeUploadImageButton()
        setupRecipeSelectedImageView()
        setupPickersStackView()
        setupTimePicker()
        setupServingsPicker()
        setupRatingsPicker()
        setupRecipeDescriptionLabel()
        setupRecipeDescriptionTextView()
        setupIngredientsLabel()
        setupIngredientsCollectionView()
        setupAddIngredientButton()
        setupDirectionsLabel()
        setupDirectionsSection()
        setupRecipePublishButton()

        // Event views
        setupEventScrollView()
        setupEventContentView()
        setupEventTitleLabel()
        setupEventTitleTextView()
        setupEventUploadImageLabel()
        setupEventUploadImageView()
        setupEventUploadImageButton()
        setupEventSelectedImageView()
        setupEventDescriptionLabel()
        setupEventDescriptionTextView()
        setupEventLocationLabel()
        setupEventLocationTextView()
        setupNumberOfAttendeesLabel()
        setupNumberOfAttendeesTextView()
        setupChooseADateLabel()
        setupDatePicker()
        setupSelectedDateLabel()
        setupEventPublishButton()
        
        
        segmentChanged(segmentedControl) // Show initial view
    }
    
    // MARK: - Setup Views
    
    private func setupCustomHeaderView() {
        view.addSubview(customHeaderView)

        customHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customHeaderView.topAnchor.constraint(equalTo: view.topAnchor),
            customHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customHeaderView.heightAnchor.constraint(equalToConstant: 130) // Adjust height as needed
        ])
    }

    
    private func setupSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0 // Default to "Story"
        segmentedControl.backgroundColor = .white
        segmentedControl.selectedSegmentTintColor = UIColor.systemBlue.withAlphaComponent(0.4)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.systemBlue], for: .normal)
        
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
    

    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        storyScrollView.isHidden = sender.selectedSegmentIndex != 0
        recipeScrollView.isHidden = sender.selectedSegmentIndex != 1
        eventScrollView.isHidden = sender.selectedSegmentIndex != 2

        switch sender.selectedSegmentIndex {
        case 0:
            customHeaderView.titleLabel.text = "New Story"
        case 1:
            customHeaderView.titleLabel.text = "New Recipe"
        case 2:
            customHeaderView.titleLabel.text = "New Event"

        default:
            customHeaderView.titleLabel.text = "New Post"
        }
    }
    
    
    // MARK: Post ScrollView
    
    private func setupStoryScrollView() {
        storyScrollView.isHidden = false
        view.addSubview(storyScrollView)
        storyScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            storyScrollView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            storyScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            storyScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            storyScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupStoryContentView() {
        storyScrollView.addSubview(storyContentView)
        storyContentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            storyContentView.topAnchor.constraint(equalTo: storyScrollView.topAnchor),
            storyContentView.leadingAnchor.constraint(equalTo: storyScrollView.leadingAnchor),
            storyContentView.trailingAnchor.constraint(equalTo: storyScrollView.trailingAnchor),
            storyContentView.bottomAnchor.constraint(equalTo: storyScrollView.bottomAnchor),
            storyContentView.widthAnchor.constraint(equalTo: storyScrollView.widthAnchor)
        ])
    }
    
    private func setupStoryUploadImageLabel() {
        storyUploadImageLabel.text = "Shows us what your food looks like!"
        storyUploadImageLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        storyContentView.addSubview(storyUploadImageLabel)
        storyUploadImageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            storyUploadImageLabel.topAnchor.constraint(equalTo: storyContentView.topAnchor, constant: 10),
            storyUploadImageLabel.leadingAnchor.constraint(equalTo: storyContentView.leadingAnchor, constant: 20),
            storyUploadImageLabel.trailingAnchor.constraint(equalTo: storyContentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupStoryUploadImageView() {
        storyUploadImageView.layer.borderWidth = 1
        storyUploadImageView.layer.borderColor = UIColor.systemGray.cgColor
        storyUploadImageView.layer.cornerRadius = 10
        storyUploadImageView.layer.masksToBounds = true
        storyUploadImageView.backgroundColor = .systemGray6
        
        storyContentView.addSubview(storyUploadImageView)
        storyUploadImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            storyUploadImageView.topAnchor.constraint(equalTo: storyContentView.topAnchor, constant: 50),
            storyUploadImageView.leadingAnchor.constraint(equalTo: storyContentView.leadingAnchor, constant: 20),
            storyUploadImageView.trailingAnchor.constraint(equalTo: storyContentView.trailingAnchor, constant: -20),
            storyUploadImageView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    private func setupStorySelectedImageView() {
        storySelectedImageView.contentMode = .scaleAspectFit
        storySelectedImageView.clipsToBounds = true
        
        storyUploadImageView.addSubview(storySelectedImageView)
        storySelectedImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            storySelectedImageView.topAnchor.constraint(equalTo: storyUploadImageView.topAnchor, constant: 10),
            storySelectedImageView.leadingAnchor.constraint(equalTo: storyUploadImageView.leadingAnchor, constant: 10),
            storySelectedImageView.trailingAnchor.constraint(equalTo: storyUploadImageView.trailingAnchor, constant: -10),
            storySelectedImageView.bottomAnchor.constraint(equalTo: storyUploadImageButton.topAnchor, constant: -10),
        ])
    }
    
    private func setupStoryUploadImageButton() {
        storyUploadImageButton.setTitle("Upload Image", for: .normal)
        storyUploadImageButton.setTitleColor(.systemBlue, for: .normal)
        storyUploadImageButton.addTarget(self, action: #selector(uploadImageTapped), for: .touchUpInside)
        
        storyUploadImageView.addSubview(storyUploadImageButton)
        storyUploadImageButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            storyUploadImageButton.bottomAnchor.constraint(equalTo: storyUploadImageView.bottomAnchor, constant: -10),
            storyUploadImageButton.centerXAnchor.constraint(equalTo: storyUploadImageView.centerXAnchor)
        ])
        
    }
    
    private func setupCaptionLabel() {
        captionLabel.text = "Tell us about your food!"
        captionLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        storyContentView.addSubview(captionLabel)
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            captionLabel.topAnchor.constraint(equalTo: storyUploadImageView.bottomAnchor, constant: 40),
            captionLabel.leadingAnchor.constraint(equalTo: storyUploadImageView.leadingAnchor)
        ])
    }
    
    private func setupCaptionTextView() {
        captionTextView.layer.borderWidth = 1
        captionTextView.layer.borderColor = UIColor.systemGray.cgColor
        captionTextView.layer.cornerRadius = 10
        captionTextView.font = .systemFont(ofSize: 16)
        captionTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        storyContentView.addSubview(captionTextView)
        captionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            captionTextView.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 10),
            captionTextView.leadingAnchor.constraint(equalTo: storyContentView.leadingAnchor, constant: 20),
            captionTextView.trailingAnchor.constraint(equalTo: storyContentView.trailingAnchor, constant: -20),
            captionTextView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    private func setupPublishButton() {
        publishButton.layer.cornerRadius = 20
        publishButton.backgroundColor = .systemBlue
        publishButton.setTitle("Publish", for: .normal)
        publishButton.setTitleColor(.white, for: .normal)
        publishButton.setTitleColor(.systemGreen, for: .highlighted)
        publishButton.titleLabel?.font = .systemFont(ofSize: 16)
        publishButton.addTarget(self, action: #selector(createStory), for: .touchUpInside)
        
        publishButton.translatesAutoresizingMaskIntoConstraints = false
        storyContentView.addSubview(publishButton)
        
            NSLayoutConstraint.activate([
                publishButton.topAnchor.constraint(equalTo: captionTextView.bottomAnchor, constant: 40),
                publishButton.leadingAnchor.constraint(equalTo: storyContentView.leadingAnchor, constant: 20),
                publishButton.trailingAnchor.constraint(equalTo: storyContentView.trailingAnchor, constant: -20),
                publishButton.heightAnchor.constraint(equalToConstant: 50),
                publishButton.bottomAnchor.constraint(equalTo: storyContentView.bottomAnchor, constant: -20)
            ])

    }
    
    // MARK: createStory
    
    @objc private func createStory() {
        let userId = "cdc236"
        let caption = captionTextView.text ?? ""
        
        // TODO: upload image to backend server, then get back URL
        let imageUrl = "placeholder"
        
        NetworkManager.shared.createStory(userId: userId, caption: caption, imageUrl: imageUrl) {
            post in
            // Do something
        }
        
    }
    
    // MARK: Recipe ScrollView
    
    private func setupRecipeScrollView() {
        recipeScrollView.isHidden = true
        view.addSubview(recipeScrollView)
        recipeScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeScrollView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            recipeScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            recipeScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            recipeScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupRecipeContentView() {
        recipeScrollView.addSubview(recipeContentView)
        recipeContentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeContentView.topAnchor.constraint(equalTo: recipeScrollView.topAnchor),
            recipeContentView.leadingAnchor.constraint(equalTo: recipeScrollView.leadingAnchor),
            recipeContentView.trailingAnchor.constraint(equalTo: recipeScrollView.trailingAnchor),
            recipeContentView.bottomAnchor.constraint(equalTo: recipeScrollView.bottomAnchor),
            recipeContentView.widthAnchor.constraint(equalTo: recipeScrollView.widthAnchor)
        ])
    }
    
    private func setupRecipeTitleLabel() {
        recipeTitleLabel.text = "Title"
        recipeTitleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        recipeContentView.addSubview(recipeTitleLabel)
        recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeTitleLabel.topAnchor.constraint(equalTo: recipeContentView.topAnchor, constant: 10),
            recipeTitleLabel.leadingAnchor.constraint(equalTo: recipeContentView.leadingAnchor, constant: 20),
            recipeTitleLabel.trailingAnchor.constraint(equalTo: recipeContentView.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupRecipeTitleTextView() {
        recipeTitleTextView.layer.borderWidth = 1
        recipeTitleTextView.layer.borderColor = UIColor.systemGray.cgColor
        recipeTitleTextView.layer.cornerRadius = 10
        recipeTitleTextView.font = .systemFont(ofSize: 16)
        recipeTitleTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        recipeContentView.addSubview(recipeTitleTextView)
        recipeTitleTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeTitleTextView.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: 10),
            recipeTitleTextView.leadingAnchor.constraint(equalTo: recipeContentView.leadingAnchor, constant: 20),
            recipeTitleTextView.trailingAnchor.constraint(equalTo: recipeContentView.trailingAnchor, constant: -20),
            recipeTitleTextView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setupRecipeUploadImageLabel() {
        recipeUploadImageLabel.text = "Show us what your recipe looks like!"
        recipeUploadImageLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        recipeContentView.addSubview(recipeUploadImageLabel)
        recipeUploadImageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeUploadImageLabel.topAnchor.constraint(equalTo: recipeTitleTextView.bottomAnchor, constant: 20),
            recipeUploadImageLabel.leadingAnchor.constraint(equalTo: recipeContentView.leadingAnchor, constant: 20),
            recipeUploadImageLabel.trailingAnchor.constraint(equalTo: recipeContentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupRecipeUploadImageView() {
        recipeUploadImageView.layer.borderWidth = 1
        recipeUploadImageView.layer.borderColor = UIColor.systemGray.cgColor
        recipeUploadImageView.layer.cornerRadius = 10
        recipeUploadImageView.layer.masksToBounds = true
        recipeUploadImageView.backgroundColor = .systemGray6
        
        recipeContentView.addSubview(recipeUploadImageView)
        recipeUploadImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeUploadImageView.topAnchor.constraint(equalTo: recipeUploadImageLabel.bottomAnchor, constant: 10),
            recipeUploadImageView.leadingAnchor.constraint(equalTo: recipeContentView.leadingAnchor, constant: 20),
            recipeUploadImageView.trailingAnchor.constraint(equalTo: recipeContentView.trailingAnchor, constant: -20),
            recipeUploadImageView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    private func setupRecipeUploadImageButton() {
        recipeUploadImageButton.setTitle("Upload Image", for: .normal)
        recipeUploadImageButton.setTitleColor(.systemBlue, for: .normal)
        recipeUploadImageButton.addTarget(self, action: #selector(uploadImageTapped), for: .touchUpInside)
        
        recipeUploadImageView.addSubview(recipeUploadImageButton)
        recipeUploadImageButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeUploadImageButton.bottomAnchor.constraint(equalTo: recipeUploadImageView.bottomAnchor, constant: -10),
            recipeUploadImageButton.centerXAnchor.constraint(equalTo: recipeUploadImageView.centerXAnchor)
        ])

    }
    
    private func setupRecipeSelectedImageView() {
        recipeSelectedImageView.contentMode = .scaleAspectFit
        recipeSelectedImageView.clipsToBounds = true
        
        recipeUploadImageView.addSubview(recipeSelectedImageView)
        recipeSelectedImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeSelectedImageView.topAnchor.constraint(equalTo: recipeUploadImageView.topAnchor, constant: 10),
            recipeSelectedImageView.leadingAnchor.constraint(equalTo: recipeUploadImageView.leadingAnchor, constant: 10),
            recipeSelectedImageView.trailingAnchor.constraint(equalTo: recipeUploadImageView.trailingAnchor, constant: -10),
            recipeSelectedImageView.bottomAnchor.constraint(equalTo: recipeUploadImageButton.topAnchor, constant: -10),
        ])
    }
    
    private func setupPickersStackView() {
        pickersStackView.axis = .horizontal
        pickersStackView.distribution = .fillEqually
        pickersStackView.spacing = 10
        
        recipeContentView.addSubview(pickersStackView)
        pickersStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pickersStackView.topAnchor.constraint(equalTo: recipeUploadImageView.bottomAnchor, constant: 20),
            pickersStackView.leadingAnchor.constraint(equalTo: recipeContentView.leadingAnchor, constant: 20),
            pickersStackView.trailingAnchor.constraint(equalTo: recipeContentView.trailingAnchor, constant: -20),
            pickersStackView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupTimePicker() {
        // Create stack for time picker
        let timePickerStack = UIStackView()
        timePickerStack.axis = .vertical
        timePickerStack.spacing = 4
        timePickerStack.alignment = .fill

        // Label for time picker
        let timePickerLabel = UILabel()
        timePickerLabel.text = "Time"
        timePickerLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        timePickerLabel.textAlignment = .center

        // Configure time picker
        timePicker.layer.borderWidth = 0.5
        timePicker.layer.cornerRadius = 8
        timePicker.backgroundColor = .white
        timePicker.delegate = self
        timePicker.dataSource = self

        // Add label and picker to stack
        timePickerStack.addArrangedSubview(timePickerLabel)
        timePickerStack.addArrangedSubview(timePicker)

        // Add to main pickers stack view
        pickersStackView.addArrangedSubview(timePickerStack)
    }

    private func setupServingsPicker() {
        // Create stack for servings picker
        let servingsPickerStack = UIStackView()
        servingsPickerStack.axis = .vertical
        servingsPickerStack.spacing = 4
        servingsPickerStack.alignment = .fill

        // Label for servings picker
        let servingsPickerLabel = UILabel()
        servingsPickerLabel.text = "Servings"
        servingsPickerLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        servingsPickerLabel.textAlignment = .center

        // Configure servings picker
        servingsPicker.layer.borderWidth = 0.5
        servingsPicker.layer.cornerRadius = 8
        servingsPicker.backgroundColor = .white
        servingsPicker.delegate = self
        servingsPicker.dataSource = self

        // Add label and picker to stack
        servingsPickerStack.addArrangedSubview(servingsPickerLabel)
        servingsPickerStack.addArrangedSubview(servingsPicker)

        // Add to main pickers stack view
        pickersStackView.addArrangedSubview(servingsPickerStack)
    }

    private func setupRatingsPicker() {
        // Create stack for ratings picker
        let ratingPickerStack = UIStackView()
        ratingPickerStack.axis = .vertical
        ratingPickerStack.spacing = 4
        ratingPickerStack.alignment = .fill

        // Label for ratings picker
        let ratingPickerLabel = UILabel()
        ratingPickerLabel.text = "Rating"
        ratingPickerLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        ratingPickerLabel.textAlignment = .center

        // Configure ratings picker
        ratingPicker.layer.borderWidth = 0.5
        ratingPicker.layer.cornerRadius = 8
        ratingPicker.backgroundColor = .white
        ratingPicker.delegate = self
        ratingPicker.dataSource = self

        // Add label and picker to stack
        ratingPickerStack.addArrangedSubview(ratingPickerLabel)
        ratingPickerStack.addArrangedSubview(ratingPicker)

        // Add to main pickers stack view
        pickersStackView.addArrangedSubview(ratingPickerStack)
    }
    
    private func setupRecipeDescriptionLabel() {
        recipeDescriptionLabel.text = "Tell us about your recipe!"
        recipeDescriptionLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        recipeContentView.addSubview(recipeDescriptionLabel)
        recipeDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeDescriptionLabel.topAnchor.constraint(equalTo: pickersStackView.bottomAnchor, constant: 20),
            recipeDescriptionLabel.leadingAnchor.constraint(equalTo: recipeContentView.leadingAnchor, constant: 20),
            recipeDescriptionLabel.trailingAnchor.constraint(equalTo: recipeContentView.trailingAnchor, constant: -20),
            
        ])

    }
    
    private func setupRecipeDescriptionTextView() {
        recipeDescriptionTextView.layer.borderWidth = 1
        recipeDescriptionTextView.layer.borderColor = UIColor.systemGray.cgColor
        recipeDescriptionTextView.layer.cornerRadius = 10
        recipeDescriptionTextView.font = .systemFont(ofSize: 16)
        recipeDescriptionTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        recipeContentView.addSubview(recipeDescriptionTextView)
        recipeDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeDescriptionTextView.topAnchor.constraint(equalTo: recipeDescriptionLabel.bottomAnchor, constant: 10),
            recipeDescriptionTextView.leadingAnchor.constraint(equalTo: recipeContentView.leadingAnchor, constant: 20),
            recipeDescriptionTextView.trailingAnchor.constraint(equalTo: recipeContentView.trailingAnchor, constant: -20),
            recipeDescriptionTextView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private func setupIngredientsLabel() {
        ingredientsLabel.text = "Ingredients"
        ingredientsLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        recipeContentView.addSubview(ingredientsLabel)
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ingredientsLabel.topAnchor.constraint(equalTo: recipeDescriptionTextView.bottomAnchor, constant: 20),
            ingredientsLabel.leadingAnchor.constraint(equalTo: recipeContentView.leadingAnchor, constant: 20),
            ingredientsLabel.trailingAnchor.constraint(equalTo: recipeContentView.trailingAnchor, constant: -20),
            
        ])
    }
    
    private func setupAddIngredientButton() {
        addIngredientButton.setTitle("+", for: .normal)
        addIngredientButton.setTitleColor(.white, for: .normal)
        addIngredientButton.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        addIngredientButton.layer.cornerRadius = 25
        addIngredientButton.layer.borderWidth = 1
        addIngredientButton.layer.borderColor = UIColor.systemBlue.cgColor
        addIngredientButton.backgroundColor = UIColor.systemBlue
        
        // Add target action
        addIngredientButton.addTarget(self, action: #selector(addIngredientTapped), for: .touchUpInside)
        
        // Add button to recipeContentView
        recipeContentView.addSubview(addIngredientButton)
        addIngredientButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints for the button
        NSLayoutConstraint.activate([
            addIngredientButton.widthAnchor.constraint(equalToConstant: 50),
            addIngredientButton.heightAnchor.constraint(equalToConstant: 50),
            addIngredientButton.leadingAnchor.constraint(equalTo: recipeContentView.leadingAnchor, constant: 20),
            addIngredientButton.centerYAnchor.constraint(equalTo: ingredientsCollectionView.centerYAnchor, constant: -5)
        ])
    }
    
    @objc private func addIngredientTapped() {
        let dimmedBackgroundVC = UIViewController()
        dimmedBackgroundVC.modalPresentationStyle = .overFullScreen
        dimmedBackgroundVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let ingredientsPopup = IngredientsPopupViewController()
        ingredientsPopup.onIngredientSelected = { [weak self] selectedIngredient in
            guard let self = self else { return }
            self.ingredients.append(selectedIngredient)
            self.ingredientsCollectionView.reloadData()
            dimmedBackgroundVC.dismiss(animated: true)
        }
        
        dimmedBackgroundVC.addChild(ingredientsPopup)
        dimmedBackgroundVC.view.addSubview(ingredientsPopup.view)
        ingredientsPopup.view.translatesAutoresizingMaskIntoConstraints = false
        ingredientsPopup.view.layer.cornerRadius = 20 // Rounded corners
        ingredientsPopup.view.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            ingredientsPopup.view.centerXAnchor.constraint(equalTo: dimmedBackgroundVC.view.centerXAnchor),
            ingredientsPopup.view.centerYAnchor.constraint(equalTo: dimmedBackgroundVC.view.centerYAnchor),
            ingredientsPopup.view.widthAnchor.constraint(equalToConstant: 400),
            ingredientsPopup.view.heightAnchor.constraint(equalToConstant: 500)
        ])
        
        present(dimmedBackgroundVC, animated: true)
    }
    
    private func setupIngredientsCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 100, height: 120) // Adjust size as needed
        ingredientsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        ingredientsCollectionView.backgroundColor = .clear
        
        recipeContentView.addSubview(ingredientsCollectionView)
        ingredientsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // Register custom cell
        ingredientsCollectionView.register(IngredientViewCell.self, forCellWithReuseIdentifier: IngredientViewCell.reuse)
        
        // Set delegate and dataSource
        ingredientsCollectionView.delegate = self
        ingredientsCollectionView.dataSource = self
        
        // Constraints
        NSLayoutConstraint.activate([
            ingredientsCollectionView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 10),
            ingredientsCollectionView.leadingAnchor.constraint(equalTo: recipeContentView.leadingAnchor, constant: 90),
            ingredientsCollectionView.trailingAnchor.constraint(equalTo: recipeContentView.trailingAnchor, constant: -20),
            ingredientsCollectionView.heightAnchor.constraint(equalToConstant: 120),
        ])
    }
    
    private func setupDirectionsLabel() {
        directionsLabel.text = "Directions"
        directionsLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        recipeContentView.addSubview(directionsLabel)
        directionsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            directionsLabel.topAnchor.constraint(equalTo: ingredientsCollectionView.bottomAnchor, constant: 20),
            directionsLabel.leadingAnchor.constraint(equalTo: recipeContentView.leadingAnchor, constant: 20),
            directionsLabel.trailingAnchor.constraint(equalTo: recipeContentView.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupDirectionsSection() {
        // Configure directions stack view
        directionsStackView.axis = .vertical
        directionsStackView.spacing = 20
        directionsStackView.alignment = .fill
        directionsStackView.distribution = .fillEqually
        recipeContentView.addSubview(directionsStackView)
        directionsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add an initial direction
        addDirectionField()
        addDirectionField()
        
        // Add to recipeContentView
        recipeContentView.addSubview(directionsStackView)
        
        NSLayoutConstraint.activate([
            directionsStackView.topAnchor.constraint(equalTo: directionsLabel.bottomAnchor, constant: 20),
            directionsStackView.leadingAnchor.constraint(equalTo: recipeContentView.leadingAnchor, constant: 20),
            directionsStackView.trailingAnchor.constraint(equalTo: recipeContentView.trailingAnchor, constant: -20)
        ])
        
        // Configure Add Direction button
        addDirectionButton.setTitle("+", for: .normal)
        addDirectionButton.setTitleColor(.white, for: .normal)
        addDirectionButton.backgroundColor = UIColor.systemGreen
        addDirectionButton.layer.cornerRadius = 10
        addDirectionButton.addTarget(self, action: #selector(addDirectionTapped), for: .touchUpInside)
        recipeContentView.addSubview(addDirectionButton)
        addDirectionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addDirectionButton.topAnchor.constraint(equalTo: directionsStackView.bottomAnchor, constant: 10),
            addDirectionButton.leadingAnchor.constraint(equalTo: recipeContentView.leadingAnchor, constant: 20),
            addDirectionButton.trailingAnchor.constraint(equalTo: recipeContentView.trailingAnchor, constant: -20),
            addDirectionButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    // Add a new direction field to the stack view
    @objc private func addDirectionTapped() {
        addDirectionField()
    }

    private func addDirectionField() {
        let directionIndex = directionsStackView.arrangedSubviews.count + 1
        
        // Create a container view for numbering and text field
        let containerView = UIStackView()
        containerView.axis = .horizontal
        containerView.alignment = .center
        containerView.spacing = 8
        
        // Create and configure the label for the direction number
        let numberLabel = UILabel()
        numberLabel.text = "\(directionIndex)."
        numberLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        containerView.addArrangedSubview(numberLabel)
        
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
        ])
        
        // Create and configure the text field for the direction
        let directionTextView = UITextView()
        directionTextView.layer.cornerRadius = 10
        directionTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        directionTextView.font = UIFont.systemFont(ofSize: 16)
        containerView.addArrangedSubview(directionTextView)
        
        NSLayoutConstraint.activate([
            directionTextView.topAnchor.constraint(equalTo: numberLabel.topAnchor),
            directionTextView.heightAnchor.constraint(equalToConstant: 100)
        ])
                
        // Add the container view to the directions stack view
        directionsStackView.addArrangedSubview(containerView)
    }
    
    private func setupRecipePublishButton() {
        recipePublishButton.layer.cornerRadius = 20
        recipePublishButton.backgroundColor = .systemBlue
        recipePublishButton.setTitle("Publish", for: .normal)
        recipePublishButton.setTitleColor(.white, for: .normal)
        recipePublishButton.setTitleColor(.systemGreen, for: .highlighted)
        recipePublishButton.titleLabel?.font = .systemFont(ofSize: 16)
        recipePublishButton.addTarget(self, action: #selector(createRecipe), for: .touchUpInside)
        
        recipePublishButton.translatesAutoresizingMaskIntoConstraints = false
        recipeContentView.addSubview(recipePublishButton)
        
        NSLayoutConstraint.activate([
            recipePublishButton.topAnchor.constraint(equalTo: addDirectionButton.bottomAnchor, constant: 20),
            recipePublishButton.leadingAnchor.constraint(equalTo: recipeContentView.leadingAnchor, constant: 20),
            recipePublishButton.trailingAnchor.constraint(equalTo: recipeContentView.trailingAnchor, constant: -20),
            recipePublishButton.heightAnchor.constraint(equalToConstant: 50),
            recipePublishButton.bottomAnchor.constraint(equalTo: recipeContentView.bottomAnchor, constant: -20)
        ])

    }
    
    // MARK: Create Recipe
    
    @objc private func createRecipe() {
        let userId = "cdc236"
        let title = recipeTitleTextView.text ?? ""
        let imageUrl = "placeholder"
        let time = String(timePicker.selectedRow(inComponent: 0))
        let servings = String(servingsPicker.selectedRow(inComponent: 0))
        let ratings = String(ratingPicker.selectedRow(inComponent: 0))
        let description = recipeDescriptionTextView.text ?? ""
        let ingredients = ingredients
        let directions = collectDirections()
        
        // TODO: upload image to backend server, then get back URL
        
        NetworkManager.shared.createRecipe(userId: userId, title: title, imageUrl: imageUrl, time: time, servings: servings,
                                          ratings: ratings, description: description, ingredients: ingredients, directions: directions) {
            post in
            // Do something
        }
        
    }
    
    private func collectDirections() -> [Direction] {
        var directions: [Direction] = []
        
        for (index, view) in directionsStackView.arrangedSubviews.enumerated() {
            if let containerView = view as? UIStackView {
                if let textField = containerView.arrangedSubviews.compactMap({ $0 as? UITextField }).first,
                   let directionText = textField.text, !directionText.isEmpty {
                    let direction = Direction(
                        stepNumber: index + 1,
                        description: directionText,
                        isCompleted: false // Default to false
                    )
                    directions.append(direction)
                }
            }
        }
        
        return directions
    }
    
    @objc private func uploadImageTapped() {
          let actionSheet = UIAlertController(title: "Select Image", message: "Choose an image from the library or take a new photo", preferredStyle: .actionSheet)
          
          actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
              self.presentImagePicker(sourceType: .photoLibrary)
          }))
          
          actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
              self.presentImagePicker(sourceType: .camera)
          }))
          
          actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
          
          present(actionSheet, animated: true)
    }

    
    // MARK: Event ScrollView
    
    private func setupEventScrollView() {
        eventScrollView.isHidden = true
        view.addSubview(eventScrollView)
        eventScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventScrollView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            eventScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            eventScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            eventScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    private func setupEventContentView() {
        eventScrollView.addSubview(eventContentView)
        eventContentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventContentView.topAnchor.constraint(equalTo: eventScrollView.topAnchor),
            eventContentView.leadingAnchor.constraint(equalTo: eventScrollView.leadingAnchor),
            eventContentView.trailingAnchor.constraint(equalTo: eventScrollView.trailingAnchor),
            eventContentView.bottomAnchor.constraint(equalTo: eventScrollView.bottomAnchor),
            eventContentView.widthAnchor.constraint(equalTo: eventScrollView.widthAnchor)
        ])
    }
    
    private func setupEventTitleLabel() {
        eventTitleLabel.text = "Title"
        eventTitleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        eventContentView.addSubview(eventTitleLabel)
        eventTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventTitleLabel.topAnchor.constraint(equalTo: eventContentView.topAnchor, constant: 10),
            eventTitleLabel.leadingAnchor.constraint(equalTo: eventContentView.leadingAnchor, constant: 20),
            eventTitleLabel.trailingAnchor.constraint(equalTo: eventContentView.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupEventTitleTextView() {
        eventTitleTextView.layer.borderWidth = 1
        eventTitleTextView.layer.borderColor = UIColor.systemGray.cgColor
        eventTitleTextView.layer.cornerRadius = 10
        eventTitleTextView.font = .systemFont(ofSize: 16)
        eventTitleTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        eventContentView.addSubview(eventTitleTextView)
        eventTitleTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventTitleTextView.topAnchor.constraint(equalTo: eventTitleLabel.bottomAnchor, constant: 10),
            eventTitleTextView.leadingAnchor.constraint(equalTo: eventContentView.leadingAnchor, constant: 20),
            eventTitleTextView.trailingAnchor.constraint(equalTo: eventContentView.trailingAnchor, constant: -20),
            eventTitleTextView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    
    private func setupEventUploadImageLabel() {
        eventUploadImageLabel.text = "Image"
        eventUploadImageLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        eventContentView.addSubview(eventUploadImageLabel)
        eventUploadImageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventUploadImageLabel.topAnchor.constraint(equalTo: eventTitleTextView.bottomAnchor, constant: 20),
            eventUploadImageLabel.leadingAnchor.constraint(equalTo: eventContentView.leadingAnchor, constant: 20),
            eventUploadImageLabel.trailingAnchor.constraint(equalTo: eventContentView.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupEventUploadImageView() {
        eventUploadImageView.layer.borderWidth = 1
        eventUploadImageView.layer.borderColor = UIColor.systemGray.cgColor
        eventUploadImageView.layer.cornerRadius = 10
        eventUploadImageView.layer.masksToBounds = true
        eventUploadImageView.backgroundColor = .systemGray6
        
        eventContentView.addSubview(eventUploadImageView)
        eventUploadImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventUploadImageView.topAnchor.constraint(equalTo: eventUploadImageLabel.bottomAnchor, constant: 10),
            eventUploadImageView.leadingAnchor.constraint(equalTo: eventContentView.leadingAnchor, constant: 20),
            eventUploadImageView.trailingAnchor.constraint(equalTo: eventContentView.trailingAnchor, constant: -20),
            eventUploadImageView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }

    private func setupEventUploadImageButton() {
        eventUploadImageButton.setTitle("Upload Image", for: .normal)
        eventUploadImageButton.setTitleColor(.systemBlue, for: .normal)
        eventUploadImageButton.addTarget(self, action: #selector(uploadImageTapped), for: .touchUpInside)
        
        eventUploadImageView.addSubview(eventUploadImageButton)
        eventUploadImageButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventUploadImageButton.bottomAnchor.constraint(equalTo: eventUploadImageView.bottomAnchor, constant: -10),
            eventUploadImageButton.centerXAnchor.constraint(equalTo: eventUploadImageView.centerXAnchor)
        ])
    }
    
    private func setupEventSelectedImageView() {
        eventSelectedImageView.contentMode = .scaleAspectFit
        eventSelectedImageView.clipsToBounds = true
        
        eventUploadImageView.addSubview(eventSelectedImageView)
        eventSelectedImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventSelectedImageView.topAnchor.constraint(equalTo: eventUploadImageView.topAnchor, constant: 10),
            eventSelectedImageView.leadingAnchor.constraint(equalTo: eventUploadImageView.leadingAnchor, constant: 10),
            eventSelectedImageView.trailingAnchor.constraint(equalTo: eventUploadImageView.trailingAnchor, constant: -10),
            eventSelectedImageView.bottomAnchor.constraint(equalTo: eventUploadImageButton.topAnchor, constant: -10),
        ])
    }
    
    private func setupEventDescriptionLabel() {
        eventDescriptionLabel.text = "Tell us about your event!"
        eventDescriptionLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        eventContentView.addSubview(eventDescriptionLabel)
        eventDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventDescriptionLabel.topAnchor.constraint(equalTo: eventUploadImageView.bottomAnchor, constant: 20),
            eventDescriptionLabel.leadingAnchor.constraint(equalTo: eventContentView.leadingAnchor, constant: 20),
            eventDescriptionLabel.trailingAnchor.constraint(equalTo: eventContentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupEventDescriptionTextView() {
        eventDescriptionTextView.layer.borderWidth = 1
        eventDescriptionTextView.layer.borderColor = UIColor.systemGray.cgColor
        eventDescriptionTextView.layer.cornerRadius = 10
        eventDescriptionTextView.font = .systemFont(ofSize: 16)
        eventDescriptionTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        eventContentView.addSubview(eventDescriptionTextView)
        eventDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventDescriptionTextView.topAnchor.constraint(equalTo: eventDescriptionLabel.bottomAnchor, constant: 10),
            eventDescriptionTextView.leadingAnchor.constraint(equalTo: eventContentView.leadingAnchor, constant: 20),
            eventDescriptionTextView.trailingAnchor.constraint(equalTo: eventContentView.trailingAnchor, constant: -20),
            eventDescriptionTextView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private func setupEventLocationLabel() {
        eventLocationLabel.text = "Location"
        eventLocationLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        eventContentView.addSubview(eventLocationLabel)
        eventLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventLocationLabel.topAnchor.constraint(equalTo: eventDescriptionTextView.bottomAnchor, constant: 20),
            eventLocationLabel.leadingAnchor.constraint(equalTo: eventContentView.leadingAnchor, constant: 20),
            eventLocationLabel.trailingAnchor.constraint(equalTo: eventContentView.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupEventLocationTextView() {
        eventLocationTextView.layer.borderWidth = 1
        eventLocationTextView.layer.borderColor = UIColor.systemGray.cgColor
        eventLocationTextView.layer.cornerRadius = 10
        eventLocationTextView.font = .systemFont(ofSize: 16)
        eventLocationTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        eventContentView.addSubview(eventLocationTextView)
        eventLocationTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventLocationTextView.topAnchor.constraint(equalTo: eventLocationLabel.bottomAnchor, constant: 10),
            eventLocationTextView.leadingAnchor.constraint(equalTo: eventContentView.leadingAnchor, constant: 20),
            eventLocationTextView.trailingAnchor.constraint(equalTo: eventContentView.trailingAnchor, constant: -20),
            eventLocationTextView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setupNumberOfAttendeesLabel() {
        numberOfAttendeesLabel.text = "How many people can come?"
        numberOfAttendeesLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        eventContentView.addSubview(numberOfAttendeesLabel)
        numberOfAttendeesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numberOfAttendeesLabel.topAnchor.constraint(equalTo: eventLocationTextView.bottomAnchor, constant: 20),
            numberOfAttendeesLabel.leadingAnchor.constraint(equalTo: eventContentView.leadingAnchor, constant: 20),
            numberOfAttendeesLabel.trailingAnchor.constraint(equalTo: eventContentView.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupNumberOfAttendeesTextView() {
        numberOfAttendeesTextView.layer.borderWidth = 1
        numberOfAttendeesTextView.layer.borderColor = UIColor.systemGray.cgColor
        numberOfAttendeesTextView.layer.cornerRadius = 10
        numberOfAttendeesTextView.font = .systemFont(ofSize: 16)
        numberOfAttendeesTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        eventContentView.addSubview(numberOfAttendeesTextView)
        numberOfAttendeesTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numberOfAttendeesTextView.topAnchor.constraint(equalTo: numberOfAttendeesLabel.bottomAnchor, constant: 10),
            numberOfAttendeesTextView.leadingAnchor.constraint(equalTo: eventContentView.leadingAnchor, constant: 20),
            numberOfAttendeesTextView.trailingAnchor.constraint(equalTo: eventContentView.trailingAnchor, constant: -20),
            numberOfAttendeesTextView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setupChooseADateLabel() {
        chooseADateLabel.text = "When is the event?"
        chooseADateLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        eventContentView.addSubview(chooseADateLabel)
        chooseADateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chooseADateLabel.topAnchor.constraint(equalTo: numberOfAttendeesTextView.bottomAnchor, constant: 20),
            chooseADateLabel.leadingAnchor.constraint(equalTo: eventContentView.leadingAnchor, constant: 20),
            chooseADateLabel.trailingAnchor.constraint(equalTo: eventContentView.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupDatePicker() {
        // Configure the date picker mode (date, time, or both)
        datePicker.datePickerMode = .dateAndTime
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        } // Use .inline for modern appearance (iOS 14+)
        let calendar = Calendar.current
        let currentDate = Date()
        let oneYearFromNow = calendar.date(byAdding: .year, value: 1, to: currentDate)
        datePicker.minimumDate = currentDate
        datePicker.maximumDate = oneYearFromNow

        // Add target for value change
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        
        eventContentView.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: eventContentView.centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: chooseADateLabel.bottomAnchor, constant: 10),
            datePicker.widthAnchor.constraint(equalTo: eventContentView.widthAnchor, multiplier: 0.9),
            datePicker.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
            
    @objc private func dateChanged(_ sender: UIDatePicker) {
        // Format the selected date and display it in the label
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        selectedDateLabel.text = "Selected Date: \(formatter.string(from: sender.date))"
    }
    
    private func setupSelectedDateLabel() {
        selectedDateLabel.text = "Selected Date: None"
        selectedDateLabel.textAlignment = .center
        selectedDateLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        eventContentView.addSubview(selectedDateLabel)
        selectedDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            selectedDateLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            selectedDateLabel.centerXAnchor.constraint(equalTo: eventContentView.centerXAnchor),
        ])
    }

    private func setupEventPublishButton() {
        eventPublishButton.layer.cornerRadius = 20
        eventPublishButton.backgroundColor = .systemBlue
        eventPublishButton.setTitle("Publish", for: .normal)
        eventPublishButton.setTitleColor(.white, for: .normal)
        eventPublishButton.setTitleColor(.systemGreen, for: .highlighted)
        eventPublishButton.titleLabel?.font = .systemFont(ofSize: 16)
        eventPublishButton.addTarget(self, action: #selector(createEvent), for: .touchUpInside)
        
        eventPublishButton.translatesAutoresizingMaskIntoConstraints = false
        eventContentView.addSubview(eventPublishButton)
        
        NSLayoutConstraint.activate([
            eventPublishButton.topAnchor.constraint(equalTo: selectedDateLabel.bottomAnchor, constant: 20),
            eventPublishButton.leadingAnchor.constraint(equalTo: eventContentView.leadingAnchor, constant: 20),
            eventPublishButton.trailingAnchor.constraint(equalTo: eventContentView.trailingAnchor, constant: -20),
            eventPublishButton.heightAnchor.constraint(equalToConstant: 50),
            eventPublishButton.bottomAnchor.constraint(equalTo: eventContentView.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: createEvent

    @objc private func createEvent() {
        let userId = 0
        let title = eventTitleTextView.text ?? ""
        let imageUrl = "placeholder"
        let description = eventDescriptionTextView.text ?? ""
        let location = eventLocationTextView.text ?? ""
        let capacity = Int(numberOfAttendeesTextView.text ?? "") ?? 4
        let date = datePicker.date
        
        NetworkManager.shared.createEvent(userId: userId, title: title, imageUrl: imageUrl, description: description, location: location, capacity: capacity, date: date) {
            event in
            // Do something
        }
        
    }
    
    // MARK: upload image to backend
    
    private func uploadImageToBackend(image: UIImage, completion: @escaping (String) -> Void) {
        NetworkManager.shared.postImage(image: image) { imageUrl in
            if let imageUrl = imageUrl {
                print("Image uploaded successfully: \(imageUrl)")
                completion(imageUrl)
            } else {
                print("Failed to upload image")
            }
        }
    }
}



extension CreatePostViewController: UINavigationControllerDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1 // Single column in each picker
        }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == timePicker {
            return timeOptions.count
        } else if pickerView == servingsPicker {
            return servingsOptions.count
        } else if pickerView == ratingPicker {
            return ratingOptions.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == timePicker {
            return timeOptions[row]
        } else if pickerView == servingsPicker {
            return servingsOptions[row]
        } else if pickerView == ratingPicker {
            return ratingOptions[row]
        }
        return nil
    }
}




extension CreatePostViewController: UIImagePickerControllerDelegate {
    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
            print("Source type not available")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            switch segmentedControl.selectedSegmentIndex {
            case 0: // Story
                storySelectedImageView.image = selectedImage
                uploadImageToBackend(image: selectedImage) { [weak self] imageUrl in
                    guard let self = self else { return }
                    self.storySelectedImageView.tag = 1 // Track the upload completion with a tag
                    self.storySelectedImageView.accessibilityLabel = imageUrl // Store the URL in the label
                    print(self.storySelectedImageView.accessibilityLabel)
                }
            case 1: // Recipe
                recipeSelectedImageView.image = selectedImage
                uploadImageToBackend(image: selectedImage) { [weak self] imageUrl in
                    guard let self = self else { return }
                    self.recipeSelectedImageView.tag = 1 // Track the upload completion with a tag
                    self.recipeSelectedImageView.accessibilityLabel = imageUrl
                }
            case 2: // Event
                eventSelectedImageView.image = selectedImage
                uploadImageToBackend(image: selectedImage) { [weak self] imageUrl in
                    guard let self = self else { return }
                    self.eventSelectedImageView.tag = 1 // Track the upload completion with a tag
                    self.eventSelectedImageView.accessibilityLabel = imageUrl
                }
            default:
                break
            }
        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension CreatePostViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientViewCell.reuse, for: indexPath) as? IngredientViewCell else { return UICollectionViewCell() }
        let ingredient = ingredients[indexPath.row]
        cell.configure(ingredient: ingredient)
        return cell
    }
}
