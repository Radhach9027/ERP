//
//  ViewController.swift
//  WalmartAssignment
//
//  Created by radha chilamkurthy on 25/04/22.
//

import UIKit

class RootViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var astronomyImageView: ImageLoader = {
        let image = ImageLoader()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var makeLabel:(String,
                                UIFont,
                                UIColor) -> UILabel = { (title,
                                                         font,
                                                         color) in
        let label = UILabel()
        label.numberOfLines = 0
        label.text = title
        label.textColor = color
        label.font = font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    }

}

