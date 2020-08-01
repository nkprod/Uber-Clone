//
//  SingUpController.swift
//  Uber Clone
//
//  Created by Nulrybek Karshyga on 7/15/20.
//  Copyright © 2020 Nulrybek Karshyga. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SignUpController: UIViewController {
    
    //MARK: Properties
    
    //title
    private let uberTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "UBER"
        label.textColor = .white
        label.font = UIFont(name: "Avenir-Light", size: 36)
        return label
    }()
    //email
    private lazy var emailContainerView: UIView = {
        let view = UIView().instantiateView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextField)
        view.anchor(height: 50)
        return view
    }()
    
    private let emailTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false)
    }()
    //fullname
    private lazy var fullnameContainerView: UIView = {
        let view = UIView().instantiateView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: fullnameTextField)
        view.anchor(height: 50)
        return view
    }()
    
    private let fullnameTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false)
    }()
    
    //password
    private lazy var passwordContainerView: UIView = {
        let view = UIView().instantiateView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
        view.anchor(height: 50)
        return view
    }()

    private let passwordTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
    }()
    
    private lazy var reenterPasswordContainerView: UIView = {
        let view = UIView().instantiateView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: reenterPasswordTextField)
        view.anchor(height: 50)
        return view
    }()

    private let reenterPasswordTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
    }()
    
    private let signUpButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes:
            [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
             NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        button.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)
        attributedTitle.append(NSAttributedString(string: "Log In", attributes:
            [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),
             NSAttributedString.Key.foregroundColor : UIColor.mainBlueTint]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    // segmented control
    private let accountTypeSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Rider", "Driver"])
        sc.backgroundColor = .backgroundColor
        sc.tintColor = UIColor(white: 1, alpha: 0.87)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    private lazy var acountTypeContainerView: UIView = {
        let view = UIView().instantiateView(image: #imageLiteral(resourceName: "chevron-sign-to-right"), segmentedControl: accountTypeSegmentedControl)
        view.anchor(height: 100)
        return view
    }()
    
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .red
        configureUI()
        
    }
    
    func configureUI() {
         
        view.backgroundColor = .backgroundColor
        view.addSubview(uberTitleLabel)
        uberTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 40)
        uberTitleLabel.centerX(inView: view)
         
        let stackView = UIStackView(arrangedSubviews: [emailContainerView,
                                                       fullnameContainerView,
                                                       passwordContainerView,
                                                       reenterPasswordContainerView,
                                                       accountTypeSegmentedControl,
                                                       signUpButton,
                                                       alreadyHaveAccountButton
                                                       ])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 16
         
        view.addSubview(stackView)
         
        stackView.anchor(top: uberTitleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
    }
    
    //MARK: Selectors
    @objc func handleShowLogIn() {
        let controller = LoginController()
        navigationController?.popViewController(animated: true)
    }
    @objc func handleSignUp() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        let accountTypeIndex = accountTypeSegmentedControl.selectedSegmentIndex
        
        Auth.auth().createUser(withEmail: email, password: password) {(result, error) in
            if let error = error {
                print("Failed to register user with error: \(error)")
                return
            }
            guard let uid = result?.user.uid else { return }
            let values = ["email": email,
                          "fullname": fullname,
                          "accountType": accountTypeIndex] as [String : Any]
            Database.database().reference().child("users").child(uid).updateChildValues(values) { (error, ref) in
                print("Successfully stored the information to the database")
            }
        }
    }
}
