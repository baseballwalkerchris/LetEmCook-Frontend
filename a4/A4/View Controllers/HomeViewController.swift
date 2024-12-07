import UIKit

class HomescreenViewController: UIViewController {
    
    // MARK: - Properties
    
    private let headerView = UIView()
    private let customHeaderView = CustomHeaderView()
    private let logoView = UIImageView()
    private let segmentedControl = UISegmentedControl(items: ["Stories", "Recipes", "Events"])
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let headerTitleLabel = UILabel()

    private var storiesCollectionView: UICollectionView!
    private var recipesCollectionView: UICollectionView!
    private var eventsCollectionView: UICollectionView!
    
    // Data source for events
    private var events: [Event] = [] // Array to hold events data
    // Data source for recipes
    private var recipes: [Recipe] = []
    // Data source for stories
    private var stories: [Story] = []
    
    private let refreshControl = UIRefreshControl()
    
    // MARK: - init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.a4.offWhite

//        setupHeaderView()
        setupCustomHeaderView()
        setupLogoView()
        setupHeaderTitleLabel()
        setupSegmentedView()
        setupScrollView()
        setupContentView()
        setupStoriesCollectionView()
        setupRecipesCollectionView()
        setupEventsCollectionView()
        loadMockRecipes()

        // Hide other collection views initially
        recipesCollectionView.isHidden = true
        eventsCollectionView.isHidden = true

        // Fetch stories
        NetworkManager.shared.fetchStories { [weak self] fetchedStories in
            DispatchQueue.main.async {
                self?.stories = fetchedStories
                self?.storiesCollectionView.reloadData()
            }
        }

        // Fetch events
        NetworkManager.shared.fetchEvents { [weak self] fetchedEvents in
            DispatchQueue.main.async {
                self?.events = fetchedEvents
                self?.eventsCollectionView.reloadData()
            }
        }

    }
    // MARK: - Set up views
    
    private func setupCustomHeaderView() {
        view.addSubview(customHeaderView)
        customHeaderView.titleLabel.text = "My Feed"
        customHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customHeaderView.topAnchor.constraint(equalTo: view.topAnchor),
            customHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customHeaderView.heightAnchor.constraint(equalToConstant: 130) // Adjust height as needed
        ])
    }
    
    
    
    private func setupSegmentedView() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .white
        segmentedControl.selectedSegmentTintColor = UIColor.systemBlue.withAlphaComponent(0.4)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.systemBlue], for: .normal)
        
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        storiesCollectionView.isHidden = sender.selectedSegmentIndex != 0
        recipesCollectionView.isHidden = sender.selectedSegmentIndex != 1
        eventsCollectionView.isHidden = sender.selectedSegmentIndex != 2
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    
    private func setupContentView() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupStoriesCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10 // Spacing between columns
        layout.minimumLineSpacing = 15 // Spacing between rows
        layout.itemSize = CGSize(width: 160, height: 200) // Adjust item size as needed
        
        storiesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        storiesCollectionView.delegate = self
        storiesCollectionView.dataSource = self
        storiesCollectionView.register(StoryViewCell.self, forCellWithReuseIdentifier: StoryViewCell.reuse)
        storiesCollectionView.backgroundColor = UIColor.a4.offWhite
        
        contentView.addSubview(storiesCollectionView)
        storiesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            storiesCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            storiesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            storiesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            storiesCollectionView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            storiesCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupRecipesCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 2 // Spacing between columns
        layout.minimumLineSpacing = 15 // Spacing between rows
        layout.itemSize = CGSize(width: 160, height: 300) // Adjust the height as needed
        
        recipesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        recipesCollectionView.delegate = self
        recipesCollectionView.dataSource = self
        recipesCollectionView.register(RecipeViewCell.self, forCellWithReuseIdentifier: RecipeViewCell.reuse)
        recipesCollectionView.backgroundColor = UIColor.a4.offWhite
        
        contentView.addSubview(recipesCollectionView)
        recipesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipesCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            recipesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            recipesCollectionView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            recipesCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    @objc private func refreshData() {
        switch segmentedControl.selectedSegmentIndex {
        case 0: // Stories
            NetworkManager.shared.fetchStories { [weak self] fetchedStories in
                DispatchQueue.main.async {
                    self?.stories = fetchedStories
                    self?.storiesCollectionView.reloadData()
                    self?.refreshControl.endRefreshing()
                }
            }
        case 1: // Recipes
            // Assuming you fetch recipes from the network
            NetworkManager.shared.fetchRecipes { [weak self] fetchedRecipes in
                DispatchQueue.main.async {
                    self?.recipes = fetchedRecipes
                    self?.recipesCollectionView.reloadData()
                    self?.refreshControl.endRefreshing()
                }
            }
        case 2: // Events
            NetworkManager.shared.fetchEvents { [weak self] fetchedEvents in
                DispatchQueue.main.async {
                    self?.events = fetchedEvents
                    self?.eventsCollectionView.reloadData()
                    self?.refreshControl.endRefreshing()
                }
            }
        default:
            break
        }
    }
    
    private func setupEventsCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 2 // Spacing between columns
        layout.minimumLineSpacing = 15 // Spacing between rows
        layout.itemSize = CGSize(width: 160, height: 320) // Adjust the height as needed
        
        eventsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        eventsCollectionView.delegate = self
        eventsCollectionView.dataSource = self
        eventsCollectionView.register(EventViewCell.self, forCellWithReuseIdentifier: EventViewCell.reuse)
        eventsCollectionView.backgroundColor = UIColor.a4.offWhite
        
        contentView.addSubview(eventsCollectionView)
        eventsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventsCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            eventsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            eventsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            eventsCollectionView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            eventsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func loadMockRecipes() {
        recipes = [
            Recipe(
                id: 1,
                userId: "chef1",
                title: "Spaghetti Bolognese",
                imageUrl: "spaghetti",
                time: "30 mins",
                servings: "4",
                ratings: "4.5",
                description: "Classic Italian pasta dish with rich meat sauce.",
                ingredients: [],
                instructions: [],
                createdAt: Date()
            ),
            Recipe(
                id: 2,
                userId: "chef2",
                title: "Avocado Toast",
                imageUrl: "avocado_toas",
                time: "10 mins",
                servings: "1",
                ratings: "5",
                description: "Simple and delicious avocado toast.",
                ingredients: [],
                instructions: [],
                createdAt: Date()
            ),
            Recipe(
                id: 3,
                userId: "chef3",
                title: "Grilled Chicken Salad",
                imageUrl: "grilled_chicken",
                time: "25 mins",
                servings: "2",
                ratings: "4",
                description: "Healthy grilled chicken salad with fresh vegetables.",
                ingredients: [],
                instructions: [],
                createdAt: Date()
            ),
            Recipe(
                    id: 1,
                    userId: "bubblelover123",
                    title: "Classic Bubble Tea",
                    imageUrl: "bubble_tea", // Replace with your image URL
                    time: "20 mins",
                    servings: "2 cups",
                    ratings: "5",
                    description: "A simple and delicious bubble tea recipe to enjoy at home.",
                    ingredients: [],
                    instructions: [ ],
                    createdAt: Date()
                )
        ]
    }
    
    private func setupLogoView() {
        logoView.image = UIImage(named: "logo")
        logoView.contentMode = .scaleAspectFit
        
        headerView.addSubview(logoView)
        logoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10),
            logoView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            logoView.heightAnchor.constraint(equalToConstant: 70), // Adjust the height as needed
            logoView.widthAnchor.constraint(equalToConstant: 70) // Adjust the width as needed
        ])
    }
    
    private func setupHeaderTitleLabel() {
        headerTitleLabel.text = "My Feed"
        headerTitleLabel.textColor = .white
        headerTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold) // Adjust font size and weight as needed
        headerTitleLabel.textAlignment = .center
        
        headerView.addSubview(headerTitleLabel)
        headerTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerTitleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headerTitleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: 30)
        ])
    }
}

extension HomescreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == storiesCollectionView {
            return stories.count
        } else if collectionView == recipesCollectionView {
            return recipes.count
        } else if collectionView == eventsCollectionView {
            return events.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == storiesCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryViewCell.reuse, for: indexPath) as? StoryViewCell else {
                fatalError("Failed to dequeue StoryViewCell")
            }
            let story = stories[indexPath.item]
            cell.configure(story: story)
            return cell
        } else if collectionView == recipesCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeViewCell.reuse, for: indexPath) as? RecipeViewCell else {
                fatalError("Failed to dequeue RecipeViewCell")
            }
            let recipe = recipes[indexPath.item]
            cell.configure(recipe: recipe)
            return cell
        } else if collectionView == eventsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventViewCell.reuse, for: indexPath) as? EventViewCell else {
                fatalError("Failed to dequeue EventViewCell")
            }
            let event = events[indexPath.item]
            cell.configure(event: event)
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == eventsCollectionView {
            let selectedEvent = events[indexPath.item]
            let eventVC = SocialEventViewController(event: selectedEvent)
            navigationController?.pushViewController(eventVC, animated: true)
        } else if collectionView == recipesCollectionView {
            let selectedRecipe = recipes[indexPath.item]
            let recipeVC = RecipeViewController()
            
            
            navigationController?.pushViewController(recipeVC, animated: true)
        }
    }
}
