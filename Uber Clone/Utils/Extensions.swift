//
//  Extensions.swift
//  Uber Clone
//
//  Created by Nulrybek Karshyga on 7/10/20.
//  Copyright © 2020 Nulrybek Karshyga. All rights reserved.
//

import UIKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: top, constant: paddingTop)])
        }
        if let left = left {
            NSLayoutConstraint.activate([
            leftAnchor.constraint(equalTo: left, constant: paddingLeft)])
        }
        if let bottom = bottom {
            NSLayoutConstraint.activate([
                bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom)])
        }
        if let right = right {
            NSLayoutConstraint.activate([
            rightAnchor.constraint(equalTo: right, constant: -paddingRight)])
        }
        if let width = width {
            NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: width)])
        }
        
        if let height = height {
            NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: height)])
        }

    }
    func centerX(inView view: UIView){
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor)])
    }
    func centerY(inView view: UIView){
        NSLayoutConstraint.activate([
            centerYAnchor.constraint(equalTo: view.centerYAnchor)])
    }
}

