import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeVC = HomeViewController()
        
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        let homeNav = UINavigationController(rootViewController: HomeViewController())
        
        
        self.viewControllers = [homeVC]
    }
}
