import UIKit

class IngredientsPopupViewController: UIViewController {
    
    // MARK: - Properties
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let collectionView: UICollectionView
    private let backButton = UIButton() // Back button
    private var ingredients: [Ingredient] = []
    var onIngredientSelected: ((Ingredient) -> Void)?
    
    // MARK: - Initializer
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10 // Space between rows
        layout.minimumInteritemSpacing = 10 // Space between items in a row
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchIngredients()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Dim background

        // Setup the white container
        containerView.backgroundColor = UIColor.a4.offWhite
        containerView.layer.cornerRadius = 20 // Rounded corners
        containerView.layer.masksToBounds = true
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Make the container view larger
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor), // Full screen width
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor) // Full screen height
        ])
        
        // Setup the back button
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(.systemBlue, for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        containerView.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        ])
        
        // Setup the title label
        titleLabel.text = "My Fridge"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textAlignment = .center
        containerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        // Setup the collection view below the label
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(IngredientViewCell.self, forCellWithReuseIdentifier: IngredientViewCell.reuse)
        collectionView.backgroundColor = UIColor.a4.offWhite
        containerView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
    }
    
    private func fetchIngredients() {
        // Fetch ingredients from backend or local data source
        NetworkManager.shared.fetchIngredients { [weak self] fetchedIngredients in
            DispatchQueue.main.async {
                self?.ingredients = fetchedIngredients
                self?.collectionView.reloadData()
            }
        }
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegate and UICollectionViewDataSource
extension IngredientsPopupViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientViewCell.reuse, for: indexPath) as? IngredientViewCell else {
            fatalError("Failed to dequeue IngredientViewCell")
        }
        let ingredient = ingredients[indexPath.item]
        cell.configure(ingredient: ingredient)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedIngredient = ingredients[indexPath.item]
        onIngredientSelected?(selectedIngredient)
        dismiss(animated: true)
    }
    
    // Set the size for each item to allow multiple items per row
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 3 // Number of items per row
        let padding: CGFloat = 10 * (itemsPerRow + 1) // Total padding between items
        let availableWidth = collectionView.frame.width - padding
        let itemWidth = availableWidth / itemsPerRow
        return CGSize(width: itemWidth, height: itemWidth + 40) // Adjust height as needed
    }
}
