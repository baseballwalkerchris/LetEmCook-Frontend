//
//  SignInViewController.swift
//  A4
//
//  Created by Aidan Joseph on 12/6/24.
//

//
//  SignUpViewController.swift
//  A4
//
//  Created by Aidan Joseph on 12/6/24.
//

import SnapKit
import UIKit


class SignInViewController: UIViewController {
    //MARK: Properties (Views)
    private let emptyProfPic = UIImageView()
    private let loginLabel = UILabel()
    private let usernameTextField = UITextField()
    private let passwordTextField = UITextField()
    private let signInButton = UIButton()
    private let createAccountButton = UIButton()
    
    
    
    //MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.a4.offWhite
        setUpEmptyProfPic()
        setUpLoginLabel()
        setUpUsernameTextField()
        setUpPasswordTextField()
        setUpSignInButton()
        setUpCreateAccountButton()
        
    }
    
    
    //MARK: - Inits
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        let customLightBlue = UIColor(red: 120/255.0, green: 180/255.0, blue: 240/255.0, alpha: 1.0)
        view.backgroundColor = customLightBlue
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - set upviews
    
    
    private func setUpEmptyProfPic(){
        emptyProfPic.image = UIImage(named: "noProfPic")
        emptyProfPic.layer.cornerRadius = 124/2
        emptyProfPic.layer.masksToBounds = true
        view.addSubview(emptyProfPic)
        
        emptyProfPic.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(150)
            make.height.width.equalTo(124)
        }
    }
    private func setUpLoginLabel(){
        loginLabel.text = "Login"
        loginLabel.textColor = UIColor.a4.black
        loginLabel.font = .systemFont(ofSize: 40, weight: .bold).rounded
        view.addSubview(loginLabel)
        
        loginLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emptyProfPic.snp.bottom).offset(40)
        }
    }
    
    private func setUpUsernameTextField(){
        usernameTextField.placeholder = "Username"
        usernameTextField.layer.borderWidth = 1
        usernameTextField.layer.borderColor = UIColor.a4.offWhite.cgColor
        usernameTextField.layer.cornerRadius = 20
        usernameTextField.font = .systemFont(ofSize: 16)
        usernameTextField.textColor = .white
        
        //Subview
        view.addSubview(usernameTextField)
        let usernameTextFieldPadding = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 40)) // Adjust width for padding
        usernameTextField.leftView = usernameTextFieldPadding
        usernameTextField.leftViewMode = .always
        
        usernameTextField.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginLabel.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(30)
            make.height.equalTo(70)
        }
        
    }
    
    private func setUpPasswordTextField(){
        passwordTextField.placeholder = "Password"
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.a4.offWhite.cgColor
        passwordTextField.layer.cornerRadius = 20
        passwordTextField.font = .systemFont(ofSize: 16)
        passwordTextField.textColor = .white
        
        //Subview
        view.addSubview(passwordTextField)
        let passwordTextFieldPadding = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 40)) // Adjust width for padding
        passwordTextField.leftView = passwordTextFieldPadding
        passwordTextField.leftViewMode = .always
        
        passwordTextField.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(30)
            make.height.equalTo(70)
        }
        
    }
    
    private func setUpSignInButton(){
        signInButton.setImage(UIImage(named: "signInButton"), for: .normal)
        signInButton.layer.cornerRadius = 30
        view.addSubview(signInButton)
        
        signInButton.addTarget(self, action: #selector(onSignInComplete), for: .touchUpInside)
        
        signInButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(30)
            make.height.equalTo(60)
        }
    }
    
    private func setUpCreateAccountButton(){
        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.setTitleColor(UIColor.a4.white, for: .normal)
        createAccountButton.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)
        view.addSubview(createAccountButton)
        
        createAccountButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signInButton.snp.bottom).offset(10)
        }
    }
    
    
    @objc func onSignInComplete() {
        // Simulate a successful sign-up by setting the flag
        UserDefaults.standard.set(true, forKey: "hasSignedIn")
        
        // Transition to the main tab bar controller
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            let mainTabBarController = MainTabBarController()
            sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: mainTabBarController)
        }
    }
    
    
    @objc private func createAccountButtonTapped(){
        navigationController?.popViewController( animated: true)
    }
    
}

    
    
    
