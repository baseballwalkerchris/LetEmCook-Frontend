//
//  CreatePostViewController.swift
//  A4
//
//  Created by Christopher Cheng on 12/3/24.
//

import UIKit

class CreatePostViewController: UIViewController {
    
    // MARK: - Properties (view)
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
    let recipeDescriptionTextView = UITextView()
    
    let ingredientsLabel = UILabel()
//    let ingredientsCollectionView: UICollectionView
    let addIngredientButton = UIButton()
    
    let directionsLabel = UILabel()
    let directionsStackView = UIStackView()
    let addDirectionButton = UIButton()
//    let publishButton = UIButton()

    // Properties for events
    let eventScrollView = UIScrollView()
    
    // MARK: properties (data)
    // Data for pickers
    let timeOptions = ["5 min", "10 min", "15 min", "30 min", "1 hour", "2 hours"]
    let servingsOptions = ["1 person", "2 people", "4 people", "6 people", "8+ people"]
    let ratingOptions = ["1 Star", "2 Stars", "3 Stars", "4 Stars", "5 Stars"]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Post"
        view.backgroundColor = .systemBackground
        
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


        // Event views
        setupEventScrollView()
        
        segmentChanged(segmentedControl) // Show initial view
    }
    
    // MARK: - Setup Views
    
    private func setupSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0 // Default to "Story"
        
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        storyScrollView.isHidden = sender.selectedSegmentIndex != 0
        recipeScrollView.isHidden = sender.selectedSegmentIndex != 1
        eventScrollView.isHidden = sender.selectedSegmentIndex != 2
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
        publishButton.layer.cornerRadius = 10
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
//        recipeContentView.backgroundColor = .red
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
//            recipeTitleTextView.bottomAnchor.constraint(equalTo: recipeContentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupRecipeUploadImageLabel() {
        recipeUploadImageLabel.text = "Show us what your food looks like!"
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
            pickersStackView.bottomAnchor.constraint(equalTo: recipeContentView.bottomAnchor, constant: -20),
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
}

extension CreatePostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UITextFieldDelegate {
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

//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if pickerView == timePicker {
//            timePickerTextField.text = timeOptions[row]
//        } else if pickerView == servingsPicker {
//            servingsPickerTextField.text = servingsOptions[row]
//        } else if pickerView == ratingPicker {
//            ratingPickerTextField.text = ratingOptions[row]
//        }
//    }
}

extension CreatePostViewController: UIPickerViewDelegate {
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
            case 0:
                storySelectedImageView.image = selectedImage
            case 1:
                recipeSelectedImageView.image = selectedImage
            case 2:
                break
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
