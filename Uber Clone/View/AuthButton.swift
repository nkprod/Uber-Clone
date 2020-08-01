//
//  AuthButton.swift
//  Uber Clone
//
//  Created by Nulrybek Karshyga on 8/1/20.
//  Copyright © 2020 Nulrybek Karshyga. All rights reserved.
//

import UIKit

class AuthButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitle("Login", for: .normal)
        setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
        backgroundColor = .mainBlueTint
        layer.cornerRadius = 5
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
