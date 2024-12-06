//
// ProfileViewController
//  A4
//
//  Created by Aidan Joseph on 12/6/24.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    //MARK: properties, views
    private let customHeaderView = CustomHeaderView()
    private let fridgeScrollView = UIScrollView()
    private let fridgeContentView = UIView()
    
    private let myPostsScrollView = UIScrollView()
    private let myPostsContentView = UIView()
    
    private let savedScrollView = UIScrollView()
    private let savedContentView = UIView()
    
    private let eventsScrollView = UIScrollView()
    private let eventsContentView = UIView()
    
    private let topProfileContainerView = UIView()
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let detailsLabel = UILabel()
    private let socialIconsStackView = UIStackView()
    
    private let tabBar = UISegmentedControl(items: ["fridge", "my posts", "saved", "events"])
    private let generateRecipeButton = UIButton(type: .system)
    private let mergeFridgeButton = UIButton(type: .system)
    
    private let dairyLabel = UILabel()
    private var dairyCollectionView: UICollectionView!
    private let vegetableLabel = UILabel()
    private var vegetableCollectionView: UICollectionView!
    private let meatLabel = UILabel()
    private var meatCollectionView: UICollectionView!
    
    //MARK: Propertires: data
    private let dairyItems = ["Yogurt", "Cheese", "Oat Milk"]
    private let vegetableItems = ["Cucumber", "Celery", "Onion", "Garlic", "Potatoes", "Spinach", "Pepper"]
    private let meatItems = ["Chicken", "Beef", "Pork"]
    
    private let dairyImages = ["yogurt", "yogurt", "yogurt"]
    private let vegetableImages = ["cucumber","cucumber","cucumber","cucumber","cucumber","cucumber","cucumber"]
    private let meatImages = ["meat", "meat", "meat"]
    
    //MARK: Inits
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -  View did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.a4.offWhite

        setupCustomHeaderView()
        setUpFridgeScrollView()
        setUpTopProfileContainerView()
        setUpProfileImage()
        setUpNameLabel()
        setUpDetailsLabel()
        setUpIconsStackView()
        setupTabBar()
        setUpGenerateAndMergeButtons()
        setupDairySection()
        setupVegetableSection()
        setupMeatSection()
        
    }
    
    //MARK: set up functions
    
    private func setupCustomHeaderView() {
        view.addSubview(customHeaderView)
        customHeaderView.titleLabel.text = "My Profile"
        customHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customHeaderView.topAnchor.constraint(equalTo: view.topAnchor),
            customHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customHeaderView.heightAnchor.constraint(equalToConstant: 130) // Adjust height as needed
        ])
    }
    
    private func setupTabBar() {
        view.addSubview(tabBar)
        
        tabBar.selectedSegmentIndex = 0
        tabBar.addTarget(self, action: #selector(tabBarChanged(_:)), for: .valueChanged)
        
        tabBar.snp.makeConstraints { make in
            make.top.equalTo(topProfileContainerView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    @objc private func tabBarChanged(_ sender: UISegmentedControl) {
        fridgeScrollView.isHidden = sender.selectedSegmentIndex != 0
        myPostsScrollView.isHidden = sender.selectedSegmentIndex != 1
        savedScrollView.isHidden = sender.selectedSegmentIndex != 2
        eventsScrollView.isHidden = sender.selectedSegmentIndex != 3
    }
    
    private func setUpTopProfileContainerView() {
        view.addSubview(topProfileContainerView)
        topProfileContainerView.snp.makeConstraints{ make in
            make.trailing.leading.equalToSuperview()
            make.top.equalToSuperview().inset(150)
            make.bottom.equalTo(view.snp.top).inset(250)
        }
    }
    
    private func setUpFridgeScrollView() {
        view.addSubview(fridgeScrollView)
        fridgeScrollView.addSubview(fridgeContentView)
        fridgeScrollView.addSubview(topProfileContainerView)
        
        fridgeScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        fridgeContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    
    
    private func setUpProfileImage(){
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.image = UIImage(named: "profileImage")
        topProfileContainerView.addSubview(profileImageView)
       
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(100)
        }
    }
    
    private func setUpNameLabel(){
        nameLabel.text = "Andrew Smith"
        nameLabel.font = .boldSystemFont(ofSize: 18)
        topProfileContainerView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
        }
    }
    
    private func setUpDetailsLabel() {
        detailsLabel.text = "100 followers • 12 recipes"
        detailsLabel.font = .systemFont(ofSize: 14)
        detailsLabel.textColor = .gray
        topProfileContainerView.addSubview(detailsLabel)
        
        detailsLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalTo(nameLabel)
        }
    }
    private func setUpIconsStackView(){
        socialIconsStackView.axis = .horizontal
        socialIconsStackView.spacing = 8
        topProfileContainerView.addSubview(socialIconsStackView)
    }
    

    
    private func setUpGenerateAndMergeButtons() {
        fridgeContentView.addSubview(generateRecipeButton)
        fridgeContentView.addSubview(mergeFridgeButton)
        
        generateRecipeButton.setTitle("Generate Recipe", for: .normal)
        generateRecipeButton.backgroundColor = .systemGreen
        generateRecipeButton.setTitleColor(.white, for: .normal)
        generateRecipeButton.layer.cornerRadius = 8
        
        mergeFridgeButton.setTitle("Merge Fridge", for: .normal)
        mergeFridgeButton.backgroundColor = .systemBlue
        mergeFridgeButton.setTitleColor(.white, for: .normal)
        mergeFridgeButton.layer.cornerRadius = 8
        
        generateRecipeButton.snp.makeConstraints { make in
            make.top.equalTo(tabBar.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(44)
            make.width.equalTo(150)
        }
        
        mergeFridgeButton.snp.makeConstraints { make in
            make.top.equalTo(generateRecipeButton)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
            make.width.equalTo(150)
        }
    }
    
    private func setupDairySection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 4
        layout.itemSize = CGSize(width: 80, height: 100)
        dairyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        dairyCollectionView.dataSource = self
        dairyCollectionView.delegate = self
        dairyCollectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reuse)
        dairyCollectionView.showsHorizontalScrollIndicator = false
        dairyCollectionView.backgroundColor = .clear
        fridgeContentView.addSubview(dairyCollectionView)
        
        dairyLabel.text = "Dairy"
        dairyLabel.font = .boldSystemFont(ofSize: 18)
        fridgeContentView.addSubview(dairyLabel)
        
        
        dairyLabel.snp.makeConstraints { make in
            make.top.equalTo(generateRecipeButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        dairyCollectionView.snp.makeConstraints { make in
            make.top.equalTo(dairyLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
    }
    
    private func setupVegetableSection() {
        vegetableLabel.text = "Vegetables"
        vegetableLabel.font = .boldSystemFont(ofSize: 18)
        fridgeContentView.addSubview(vegetableLabel)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 4
        layout.itemSize = CGSize(width: 80, height: 100)
        vegetableCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vegetableCollectionView.dataSource = self
        vegetableCollectionView.delegate = self
        vegetableCollectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reuse)
        vegetableCollectionView.showsHorizontalScrollIndicator = false
        vegetableCollectionView.backgroundColor = .clear
        fridgeContentView.addSubview(vegetableCollectionView)
        
        
        
        vegetableLabel.snp.makeConstraints { make in
            make.top.equalTo(dairyCollectionView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        vegetableCollectionView.snp.makeConstraints { make in
            make.top.equalTo(vegetableLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
    }
    
    private func setupMeatSection() {
        fridgeContentView.addSubview(meatLabel)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 4
        layout.itemSize = CGSize(width: 80, height: 100)
        meatCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        meatCollectionView.dataSource = self
        meatCollectionView.delegate = self
        meatCollectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reuse)
        meatCollectionView.showsHorizontalScrollIndicator = false
        meatCollectionView.backgroundColor = .clear
        fridgeContentView.addSubview(meatCollectionView)
        
        meatLabel.text = "Meat"
        meatLabel.font = .boldSystemFont(ofSize: 18)
        
        meatLabel.snp.makeConstraints { make in
            make.top.equalTo(vegetableCollectionView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        meatCollectionView.snp.makeConstraints { make in
            make.top.equalTo(meatLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
            make.bottom.equalToSuperview().inset(16) // Ensures scrollable content
        }
    }
    
}
extension ProfileViewController: UICollectionViewDataSource {
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == dairyCollectionView {
            return dairyItems.count
        } else if collectionView == vegetableCollectionView {
            return vegetableItems.count
        } else {
            return meatItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.reuse, for: indexPath) as! ItemCell
        
        if collectionView == dairyCollectionView {
            if indexPath.item == 0 {
                cell.configureAddButton()
            } else {
                cell.configure(with: dairyItems[indexPath.item], with: dairyImages[indexPath.item])
            }
            
        } else if collectionView == vegetableCollectionView {
            if indexPath.item == 0 {
                cell.configureAddButton()
            } else {
                cell.configure(with: vegetableItems[indexPath.item], with: vegetableImages[indexPath.item])
            }
        } else {
            if indexPath.item == 0 {
                cell.configureAddButton()
            } else {
                cell.configure(with: meatItems[indexPath.item], with: meatImages[indexPath.item])
            }
        }
        
        return cell
    }
    
}

extension ProfileViewController: UICollectionViewDelegate { }
