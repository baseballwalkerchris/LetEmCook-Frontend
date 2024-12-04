//
//  CreatePostViewController.swift
//  A4
//
//  Created by Christopher Cheng on 12/3/24.
//

import UIKit

class CreatePostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties (view)
    let segmentedControl = UISegmentedControl(items: ["Story", "Recipe", "Event"])
    let storyScrollView = UIScrollView()
    let storyContentView = UIView()
    let uploadImageLabel = UILabel()
    let uploadImageView = UIView()
    let uploadImageButton = UIButton()
    let selectedImageView = UIImageView() // To display the selected image
    let publishButton = UIButton()
    let descriptionTextView = UITextView()
    let recipeScrollView = UIScrollView()
    let eventScrollView = UIScrollView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Post"
        view.backgroundColor = .systemBackground
        
        setupSegmentedControl()
        setupStoryScrollView()
        setupStoryContentView()
        setupUploadImageLabel()
        setupUploadImageView()
        setupUploadImageButton()
        setupSelectedImageView()
        setupDescriptionTextView()
        setupPublishButton()
        setupRecipeScrollView()
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
    
    private func setupUploadImageLabel() {
        uploadImageLabel.text = "Image"
        uploadImageLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        
        storyContentView.addSubview(uploadImageLabel)
        uploadImageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            uploadImageLabel.topAnchor.constraint(equalTo: storyContentView.topAnchor, constant: 10),
            uploadImageLabel.leadingAnchor.constraint(equalTo: storyContentView.leadingAnchor, constant: 20),
            uploadImageLabel.trailingAnchor.constraint(equalTo: storyContentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupUploadImageView() {
        uploadImageView.layer.borderWidth = 1
        uploadImageView.layer.borderColor = UIColor.systemGray.cgColor
        uploadImageView.layer.cornerRadius = 10
        uploadImageView.layer.masksToBounds = true
        uploadImageView.backgroundColor = .systemGray6
        
        storyContentView.addSubview(uploadImageView)
        uploadImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            uploadImageView.topAnchor.constraint(equalTo: storyContentView.topAnchor, constant: 50),
            uploadImageView.leadingAnchor.constraint(equalTo: storyContentView.leadingAnchor, constant: 20),
            uploadImageView.trailingAnchor.constraint(equalTo: storyContentView.trailingAnchor, constant: -20),
            uploadImageView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    private func setupSelectedImageView() {
        selectedImageView.contentMode = .scaleAspectFit
        selectedImageView.clipsToBounds = true
        
        uploadImageView.addSubview(selectedImageView)
        selectedImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            selectedImageView.topAnchor.constraint(equalTo: uploadImageView.topAnchor, constant: 10),
            selectedImageView.leadingAnchor.constraint(equalTo: uploadImageView.leadingAnchor, constant: 10),
            selectedImageView.trailingAnchor.constraint(equalTo: uploadImageView.trailingAnchor, constant: -10),
            selectedImageView.bottomAnchor.constraint(equalTo: uploadImageButton.topAnchor, constant: -10),
        ])
    }
    
    private func setupUploadImageButton() {
        uploadImageButton.setTitle("Upload Image", for: .normal)
        uploadImageButton.setTitleColor(.systemBlue, for: .normal)
        uploadImageButton.addTarget(self, action: #selector(uploadImageTapped), for: .touchUpInside)
        
        uploadImageView.addSubview(uploadImageButton)
        uploadImageButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            uploadImageButton.bottomAnchor.constraint(equalTo: uploadImageView.bottomAnchor, constant: -10),
            uploadImageButton.centerXAnchor.constraint(equalTo: uploadImageView.centerXAnchor)
        ])
        
    }
    
    private func setupDescriptionTextView() {
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor.systemGray.cgColor
        descriptionTextView.layer.cornerRadius = 10
        descriptionTextView.font = .systemFont(ofSize: 16)
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        storyContentView.addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: uploadImageView.bottomAnchor, constant: 20),
            descriptionTextView.leadingAnchor.constraint(equalTo: storyContentView.leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: storyContentView.trailingAnchor, constant: -20),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 150),
            descriptionTextView.bottomAnchor.constraint(equalTo: storyContentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupPublishButton() {
        publishButton.layer.cornerRadius = 10
        publishButton.backgroundColor = .systemBlue
        publishButton.setTitle("Publish", for: .normal)
        publishButton.setTitleColor(.white, for: .normal)
        publishButton.setTitleColor(.systemGreen, for: .highlighted)
        publishButton.titleLabel?.font = .systemFont(ofSize: 16)
//        publishButton.addTarget(self, action: #selector(publishButtonTapped), for: .touchUpInside
        
        publishButton.translatesAutoresizingMaskIntoConstraints = false
        storyContentView.addSubview(publishButton)
        
        NSLayoutConstraint.activate([
            publishButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20),
            publishButton.leadingAnchor.constraint(equalTo: storyContentView.leadingAnchor, constant: 20),
            publishButton.trailingAnchor.constraint(equalTo: storyContentView.trailingAnchor, constant: -20),
            publishButton.heightAnchor.constraint(equalToConstant: 50)
        ])
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
      
      // MARK: - UIImagePickerControllerDelegate
      
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          if let selectedImage = info[.originalImage] as? UIImage {
              selectedImageView.image = selectedImage
          }
          picker.dismiss(animated: true)
      }
      
      func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          picker.dismiss(animated: true)
      }
}

