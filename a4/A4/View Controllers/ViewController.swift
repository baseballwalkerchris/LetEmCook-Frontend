//
//  Home Screen View Controller
//  A4
//
//  Created by Vin Bui on 10/31/23.
//

import UIKit
import SDWebImage
import SnapKit
import Foundation

//MARK: - To Do register and set up recipe View cells and Social Event View cell (need to make config and probably struct for social event)


class HomescreenViewController: UIViewController {
    
    // MARK: - Properties (view)
    private var collectionView: UICollectionView!

   
    
    // MARK: - Properties (data)
    private var recipePosts: [Recipe] = [
//        Recipe(userId: "emily12345", description: "made this over the weekened and it was very good", imageUrl: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F8368708.jpg&q=60&c=sc&orient=true&poi=auto&h=512", time: Date()),
//        Recipe(userId: "john2134", description: "delicious meal can't complain", imageUrl: "https://www.allrecipes.com/thmb/cLLmeWO7j9YYI66vL3eZzUL_NKQ=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/7501402crockpot-italian-chicken-recipe-fabeveryday4x3-223051c7188841cb8fd7189958c62f3d.jpg", time: Date())
    ]
    
    private var socialPosts: [Event] = [
        Event(eventName: "Taco Tuesday", author: "aidan j", maxCount: 15, date: "5:30pm on 12/2/2024", location: "Collegetown Crossings", descriptionOfEvent: "Come over to my apartment to make tacos and watch movies. Try to come with some drinks and movie recs", currentAttendees: 4, imageURL: "https://www.allrecipes.com/thmb/neJT4JLJz7ks8D0Rkvzf8fRufWY=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/6900-dumplings-DDMFS-4x3-c03fe714205d4f24bd74b99768142864.jpg")
    ]
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Home"
        view.backgroundColor = UIColor.a4.offWhite
        
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
        collectionView.register(SocialEventViewCell.self, forCellWithReuseIdentifier: SocialEventViewCell.reuse)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.a4.offWhite
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}



// MARK: - UICollectionView DataSource
extension HomescreenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipePosts.count + socialPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReceipeViewCell.reuse, for: indexPath) as? ReceipeViewCell else { return UICollectionViewCell() }
//        
//        cell.recipeConfigure(recipePost: recipePosts[indexPath.row])
//        cell.socialConfigure(socialEvent: [indexPath.row])
//        cell.onImageTapped = { [weak self] in
//            let recipeVC = RecipeViewController()
//            self?.navigationController?.pushViewController(recipeVC, animated: true)
//        }
//        return cell
        if indexPath.row < recipePosts.count {
                // Configure Recipe cell
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReceipeViewCell.reuse, for: indexPath) as? ReceipeViewCell else {
                    return UICollectionViewCell()
                }
                cell.recipeConfigure(recipePost: recipePosts[indexPath.row])
                cell.onImageTapped = { [weak self] in
                    let recipeVC = RecipeViewController()
                    self?.navigationController?.pushViewController(recipeVC, animated: true)
                }
                return cell
            } else {
                // Configure Social cell
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SocialEventViewCell.reuse, for: indexPath) as? SocialEventViewCell else {
                    return UICollectionViewCell()
                }
                let socialIndex = indexPath.row - recipePosts.count
                cell.socialConfigure(socialEvent: socialPosts[socialIndex])
                return cell
            }
        }
}
    
    


// MARK: - UICollectionViewDelegateFlowLayout

extension HomescreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let size = collectionView.frame.width / 2 - 16
        //return CGSize(width: size, height: size)
        
        let padding: CGFloat = 8
        let availableWidth = collectionView.frame.width - padding * 3
        let cellWidth = availableWidth / 2
        if indexPath.row < recipePosts.count {
            return CGSize(width: cellWidth, height: 200) //216
        }
        return CGSize(width: cellWidth, height: 250) //300
    }
  
    
}
