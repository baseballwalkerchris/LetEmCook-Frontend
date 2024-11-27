//
//  Home Screen View Controller
//  A4
//
//  Created by Vin Bui on 10/31/23.
//

import UIKit
import SDWebImage
import SnapKit

//MARK: - To Do register and set up recipe View cells and Social Event View cell (need to make config and probably struct for social event)

class HomescreenViewController: UIViewController {
    
    // MARK: - Properties (view)
    private var collectionView: UICollectionView!

   
    
    // MARK: - Properties (data)
    private var recipePosts: [RecipePost] = [
        RecipePost(
            username: "Ava K",
            caption: "Bubble Tea",
            message: "How to make creamy and not too sweet bubble tea using black tea, milk, and store-bought boba. Easy to make and can serve with extra sugar if needed.",
            imageURL: "bubble_tea",
            time: Date()
        ),
        RecipePost(
            username: "John D",
            caption: "Spaghetti Carbonara",
            message: "Learn to make authentic spaghetti carbonara with simple ingredients: pasta, eggs, pancetta, Parmesan, and black pepper.",
            imageURL: "spaghetti_carbonara",
            time: Date()
        ),
        RecipePost(
            username: "Emily W",
            caption: "Avocado Toast",
            message: "An easy recipe for avocado toast with a variety of topping ideas for breakfast or a healthy snack.",
            imageURL: "avocado_toast",
            time: Date()
        )
    ]
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Home"
        
        setupCollectionView() 
    }
    
    
    
    //MARK: - Set up collectionView
    private func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 24, left: 0, bottom: 24, right: 0)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.collectionView?.alwaysBounceVertical = true
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ReceipeViewCell.self, forCellWithReuseIdentifier: ReceipeViewCell.reuse)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.a4.offWhite
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}



// MARK: - UICollectionView DataSource
extension HomescreenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipePosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReceipeViewCell.reuse, for: indexPath) as? ReceipeViewCell else { return UICollectionViewCell() }
        
        cell.configure(recipePost: recipePosts[indexPath.row])
        cell.onImageTapped = { [weak self] in
            let recipeVC = RecipeViewController()
            self?.navigationController?.pushViewController(recipeVC, animated: true)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomescreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let size = collectionView.frame.width / 2 - 16
        //return CGSize(width: size, height: size)
        
        let padding: CGFloat = 16
        let availableWidth = collectionView.frame.width - padding * 3
        let cellWidth = availableWidth / 2
        return CGSize(width: cellWidth, height: 216)
    }
    
}
