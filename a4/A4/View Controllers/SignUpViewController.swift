//
//  SignUpViewController.swift
//  A4
//
//  Created by Aidan Joseph on 12/6/24.
//

import SnapKit
import UIKit


class SignUpViewController: UIViewController {
    //MARK: Properties (Views)
    private let appLogo = UIImageView()
    private let appName = UIImageView()
    private let getStarted = UILabel()
    private let usernameTextField = UITextField()
    private let passwordTextField = UITextField()
    private let signUpButton = UIButton()
    private let loginButton = UIButton()
    
    
    
    //MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        let customLightBlue = UIColor(red: 120/255.0, green: 180/255.0, blue: 240/255.0, alpha: 1.0)
        view.backgroundColor = customLightBlue
        setUpAppName()
        setUpAppLogo()
        setUpGetStarted()
        setUpUsernameTextField()
        setUpPasswordTextField()
        setUpSignUpButton()
        setUpLoginButton()
        
        
    }
    
    
    //MARK: - Inits
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - set upviews
    
    private func setUpAppName(){
        appName.image = UIImage(named: "getCooked")
        view.addSubview(appName)
        
        appName.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(40)
            make.width.equalTo(120)
        }
    }
    
    private func setUpAppLogo(){
        appLogo.image = UIImage(named: "cookedLogo")
        view.addSubview(appLogo)
        
        appLogo.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(appName.snp.bottom).inset(20)
            make.height.width.equalTo(60)
        }
    }
        private func setUpGetStarted(){
            getStarted.text = "Get Started!"
            getStarted.textColor = UIColor.a4.black
            getStarted.font = .systemFont(ofSize: 40, weight: .bold).rounded
            view.addSubview(getStarted)
            
            getStarted.snp.makeConstraints{ make in
                make.centerX.equalToSuperview()
                make.top.equalTo(appLogo.snp.bottom).offset(130)
            }
        }
    
    private func setUpUsernameTextField(){
        usernameTextField.placeholder = "Username"
        usernameTextField.layer.borderWidth = 1
        usernameTextField.layer.borderColor = UIColor.a4.white.cgColor
        usernameTextField.layer.cornerRadius = 20
        usernameTextField.font = .systemFont(ofSize: 16)
        usernameTextField.textColor = .a4.white
        
        view.addSubview(usernameTextField)
        let usernameTextFieldPadding = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 40)) // Adjust width for padding
        usernameTextField.leftView = usernameTextFieldPadding
        usernameTextField.leftViewMode = .always
        
        usernameTextField.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(getStarted.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(30)
            make.height.equalTo(70)
        }
        
    }
    
    private func setUpPasswordTextField(){
        passwordTextField.placeholder = "Password"
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.a4.white.cgColor
        passwordTextField.layer.cornerRadius = 20
        passwordTextField.font = .systemFont(ofSize: 16)
        passwordTextField.textColor = .a4.white
        
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
    
    private func setUpSignUpButton(){
        signUpButton.setImage(UIImage(named: "signUpButton"), for: .normal)
        signUpButton.layer.cornerRadius = 30
        view.addSubview(signUpButton)
        
        signUpButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(30)
            make.height.equalTo(60)
        }
    }
    
    private func setUpLoginButton(){
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.a4.white, for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signUpButton.snp.bottom).offset(10)
        }
    }
    
    @objc private func loginButtonTapped(){
        let signInProfileVC = SignInViewController()
        navigationController?.pushViewController(signInProfileVC, animated: true)
    }
    
    
    
    
    
    
    
}
