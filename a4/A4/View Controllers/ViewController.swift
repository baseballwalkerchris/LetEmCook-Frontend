//
//  Home Screen View Controller
//  A4
//
//  Created by Vin Bui on 10/31/23.
//

import UIKit
import SDWebImage
import SnapKit

class HomescreenViewController: UIViewController {
    
    // MARK: - Properties (view)
    private var collectionView: UICollectionView!

   
    
    // MARK: - Properties (data)
    private var recipePosts: [RecipePost] = [
        
    ]
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
        
        //collectionView.delegate = self
        //collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.a4.offWhite
        
        view.addSubview(collectionView)
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
