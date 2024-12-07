import UIKit

class NewIngredientViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - UI Components
    private let titleLabel = UILabel()
    private let imageUploadView = UIView()
    private let imageView = UIImageView()
    private let uploadLabel = UILabel()
    private let nameLabel = UILabel()
    private let nameTextField = UITextField()
    private let quantityLabel = UILabel()
    private let quantityTextField = UITextField()
    private let addButton = UIButton()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        addTapGestureToImageUploadView()
    }

    // MARK: - Setup UI
    private func setupUI() {
        setupTitleLabel()
        setupImageUploadView()
        setupNameField()
        setupQuantityField()
        setupAddButton()
    }

    private func setupTitleLabel() {
        titleLabel.text = "New Ingredient"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupImageUploadView() {
        // Container for the image upload view
        imageUploadView.backgroundColor = UIColor.systemGray6
        imageUploadView.layer.cornerRadius = 12
        imageUploadView.layer.borderWidth = 1
        imageUploadView.layer.borderColor = UIColor.systemGray4.cgColor
        view.addSubview(imageUploadView)
        
        imageUploadView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageUploadView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            imageUploadView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageUploadView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            imageUploadView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // Add ImageView
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.systemGray
        imageUploadView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: imageUploadView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: imageUploadView.centerYAnchor, constant: -10),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // Add Upload Label
        uploadLabel.text = "Upload Image"
        uploadLabel.font = UIFont.systemFont(ofSize: 14)
        uploadLabel.textColor = UIColor.systemGray
        uploadLabel.textAlignment = .center
        imageUploadView.addSubview(uploadLabel)
        
        uploadLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            uploadLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            uploadLabel.centerXAnchor.constraint(equalTo: imageUploadView.centerXAnchor)
        ])
    }

    private func setupNameField() {
        nameLabel.text = "Name"
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        nameLabel.textColor = .black
        view.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageUploadView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: imageUploadView.leadingAnchor)
        ])
        
        nameTextField.borderStyle = .roundedRect
        nameTextField.placeholder = "Enter ingredient name"
        view.addSubview(nameTextField)
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: imageUploadView.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: imageUploadView.trailingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupQuantityField() {
        quantityLabel.text = "Quantity"
        quantityLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        quantityLabel.textColor = .black
        view.addSubview(quantityLabel)
        
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quantityLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            quantityLabel.leadingAnchor.constraint(equalTo: imageUploadView.leadingAnchor)
        ])
        
        quantityTextField.borderStyle = .roundedRect
        quantityTextField.placeholder = "Enter quantity"
        view.addSubview(quantityTextField)
        
        quantityTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quantityTextField.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 8),
            quantityTextField.leadingAnchor.constraint(equalTo: imageUploadView.leadingAnchor),
            quantityTextField.trailingAnchor.constraint(equalTo: imageUploadView.trailingAnchor),
            quantityTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupAddButton() {
        addButton.setTitle("+ Add", for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        addButton.backgroundColor = UIColor.systemBlue
        addButton.layer.cornerRadius = 10
        addButton.setTitleColor(.white, for: .normal)
        view.addSubview(addButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: quantityTextField.bottomAnchor, constant: 20),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        addButton.addTarget(self, action: #selector(addIngredient), for: .touchUpInside)
    }

    // MARK: - Image Upload Functionality
    private func addTapGestureToImageUploadView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(uploadImageTapped))
        imageUploadView.addGestureRecognizer(tapGesture)
    }

    @objc private func uploadImageTapped() {
        let alertController = UIAlertController(title: "Upload Image", message: "Choose an image source", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            self.openImagePicker(sourceType: .camera)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            self.openImagePicker(sourceType: .photoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    private func openImagePicker(sourceType: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
            let alert = UIAlertController(title: "Error", message: "This source type is not available on your device.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }

    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let editedImage = info[.editedImage] as? UIImage {
            imageView.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            imageView.image = originalImage
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    // MARK: - Action
    @objc private func addIngredient() {
        print("Add ingredient button tapped")
        // Handle add logic here
        NetworkManager.shared.postImage(image: (imageView.image ?? UIImage(systemName: "photo"))!) { [weak self] image in
            guard let self = self else { return }
            print("Image was added to ingredients.")
            // Do something with the member if needed
        }
       
    }
}
