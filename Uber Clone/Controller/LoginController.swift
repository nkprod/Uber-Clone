//
//  LoginController.swift
//  Uber Clone
//
//  Created by Nulrybek Karshyga on 7/9/20.
//  Copyright © 2020 Nulrybek Karshyga. All rights reserved.
//
import UIKit
import Firebase

class LoginController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties

    private let uberTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "UBER"
        label.textColor = .white
        label.font = UIFont(name: "Avenir-Light", size: 36)
        return label
    }()

    private lazy var emailContainerView: UIView = {
        let view = UIView().instantiateView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextField)
        view.anchor(height: 50)
        return view
    }()
    
    private let emailTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false)
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView().instantiateView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
        view.anchor(height: 50)
        return view
    }()

    private let passwordTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
    }()
    
    private let loginButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes:
            [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
             NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes:
            [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),
             NSAttributedString.Key.foregroundColor : UIColor.mainBlueTint]))
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    // delegate methods

    
    // MARK: Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    

    // MARK: Helper funcitons
    
    func configureUI() {
        
        configureNaviagtionController()
         
        view.backgroundColor = .backgroundColor
        view.addSubview(uberTitleLabel)
        uberTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 40)
        uberTitleLabel.centerX(inView: view)
         
        let stackView = UIStackView(arrangedSubviews: [emailContainerView,
                                                        passwordContainerView,
                                                         loginButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
         
        view.addSubview(stackView)
         
        stackView.anchor(top: uberTitleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    func configureNaviagtionController() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    // MARK: Selectors
    @objc func handleLogin() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { (data, error) in
            if let error = error {
                print("Failed to log user in with error \(error.localizedDescription)")
                return
            }
            print("Successfully signed user in ...")
        }
    }
    
    
    @objc func handleShowSignUp() {
        let controller = SignUpController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
