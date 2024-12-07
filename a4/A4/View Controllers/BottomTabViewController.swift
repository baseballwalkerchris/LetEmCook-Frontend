import UIKit
import SnapKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeVC = HomescreenViewController()
        let profileVC = ProfileViewController()
        let createProfileVC = CreatePostViewController()
        
        tabBar.tintColor = UIColor.systemBlue.withAlphaComponent(0.7)
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homePageIcon2"), selectedImage: nil)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profilePageIcon2"), selectedImage: nil)
        createProfileVC.tabBarItem =  UITabBarItem(title: "Create", image: UIImage(named: "createPostIconPage"), selectedImage: nil)
    
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let profileNav = UINavigationController(rootViewController: profileVC)
        let createNav = UINavigationController(rootViewController: createProfileVC)
        
     
        
        self.viewControllers = [homeNav, profileNav, createNav]
    }
    
}

extension MainTabBarController {
    func logOut() {
        // Simulate logging out by resetting the flag
        UserDefaults.standard.set(false, forKey: "hasSignedIn")

        // Transition back to the sign-up view controller
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            let signUpViewController = SignUpViewController()
            sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: signUpViewController)
        }
    }
}
