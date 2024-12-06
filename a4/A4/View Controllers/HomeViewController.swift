import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let segmentedControl = UISegmentedControl(items: ["Stories", "Recipes", "Events"])
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private var storiesCollectionView: UICollectionView!
    private var recipesCollectionView: UICollectionView!
    private var eventsCollectionView: UICollectionView!
    
    // Data source for events
    private var events: [Event] = [] // Array to hold events data
    // Data source for recipes
    private var recipes: [Recipe] = []
    // Data source for stories
    private var stories: [Story] = []
    
    // MARK: - init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.a4.offWhite
        title = "My Feed"
        
        setupSegmentedView()
        setupScrollView()
        setupContentView()
        setupStoriesCollectionView()
        setupRecipesCollectionView()
        setupEventsCollectionView()
        
        // Hide other collection views initially
        recipesCollectionView.isHidden = true
        eventsCollectionView.isHidden = true
        
        NetworkManager.shared.fetchStories { [weak self] fetchedStories in
            DispatchQueue.main.async {
                self?.stories = fetchedStories
                self?.storiesCollectionView.reloadData()
            }
        }
        // Load mock data for events
        loadMockEvents()
        loadMockRecipes()
//        loadMockStories()
    }
    
    // MARK: - Set up views
    
    private func setupSegmentedView() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .white
        segmentedControl.selectedSegmentTintColor = .systemBlue
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
        layout.itemSize = CGSize(width: 160, height: 250) // Adjust the height as needed
        
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
    
    private func setupEventsCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 2 // Spacing between columns
        layout.minimumLineSpacing = 15 // Spacing between rows
        layout.itemSize = CGSize(width: 160, height: 250) // Adjust the height as needed
        
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
    
    private func loadMockEvents() {
        // Create mock events for testing
        events = [
            Event(id: 1, userId: "user1", title: "Event 1", imageUrl: "https://example.com/image1.jpg", description: "Description 1", location: "Location 1", capacity: "50", date: Date(), createdAt: Date()),
            Event(id: 2, userId: "user2", title: "Event 2", imageUrl: "https://example.com/image2.jpg", description: "Description 2", location: "Location 2", capacity: "100", date: Date(), createdAt: Date()),
            Event(id: 3, userId: "user3", title: "Event 3", imageUrl: "https://example.com/image3.jpg", description: "Description 3", location: "Location 3", capacity: "100", date: Date(), createdAt: Date())
        ]
        eventsCollectionView.reloadData()
    }
    
    private func loadMockStories() {
        stories = [
            Story(id: 1, imageUrl: "https://example.com/story1.jpg", title: "emily122345", caption: "made this over the weekend and it was very good.", createdAt: Date()),
            Story(id: 2, imageUrl: "https://example.com/story2.jpg", title: "johnDoe", caption: "Tried this recipe last night, amazing taste!", createdAt: Date()),
            Story(id: 2, imageUrl: "https://example.com/story2.jpg", title: "johnDoe", caption: "Tried this recipe last night, amazing taste!", createdAt: Date())
        ]
        storiesCollectionView.reloadData()
    }
    
    private func loadMockRecipes() {
        recipes = [
            Recipe(id: 1, userId: "chef1", title: "Recipe 1", imageUrl: "https://example.com/recipe1.jpg", time: "30 mins", servings: "2", ratings: "5", description: "Delicious recipe 1", ingredients: [], directions: [], createdAt: Date()),
            Recipe(id: 2, userId: "chef2", title: "Recipe 2", imageUrl: "https://example.com/recipe2.jpg", time: "45 mins", servings: "4", ratings: "4", description: "Tasty recipe 2", ingredients: [], directions: [], createdAt: Date())
        ]
        recipesCollectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
}
