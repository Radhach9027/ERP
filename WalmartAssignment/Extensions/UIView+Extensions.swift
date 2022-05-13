//
//  UIView+Extensions.swift
//  WalmartAssignment
//
//  Created by radha chilamkurthy on 13/05/22.
//

import UIKit

extension UIView {
    
    func pin(someView: UIView) {
        NSLayoutConstraint.activate([
            someView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            someView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            someView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            someView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
