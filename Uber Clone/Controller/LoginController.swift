//
//  LoginController.swift
//  Uber Clone
//
//  Created by Nulrybek Karshyga on 7/9/20.
//  Copyright © 2020 Nulrybek Karshyga. All rights reserved.
//
import UIKit

class LoginController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties

    private let uberTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "MyApp"
        label.textColor = .white
        label.font = UIFont(name: "Avenir-Light", size: 36)
        return label
    }()
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.lightGray
        button.layer.cornerRadius = 10
        return button
    }()
    
    // delegate methods

    
    // MARK: Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        view.addSubview(uberTitleLabel)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        uberTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 40)
        uberTitleLabel.centerX(inView: view)
        
        
        usernameTextField.anchor(top: uberTitleLabel.bottomAnchor, paddingTop: 200, width: view.frame.width - 40)
        usernameTextField.centerX(inView: view)
        usernameTextField.borderStyle = UITextField.BorderStyle.roundedRect

        
        passwordTextField.anchor(top: usernameTextField.bottomAnchor, paddingTop: 0, width: view.frame.width - 40)
        passwordTextField.centerX(inView: view)
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        
        loginButton.anchor(top: passwordTextField.bottomAnchor, paddingTop: 20, width: view.frame.width - 40)
        loginButton.centerX(inView: view)
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(loginPressed(_:)), for: .touchUpInside)

        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gesture)
        
    }
    

    @objc func loginPressed(_ sender: UIButton) {
        print(usernameTextField.text)
        print(passwordTextField.text)
        hideKeyboard()
    }
    
    @objc func hideKeyboard() {
        passwordTextField.resignFirstResponder()
        usernameTextField.resignFirstResponder()
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = .lightGray
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = .darkGray
    }
}
