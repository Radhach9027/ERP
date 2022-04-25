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
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension RootViewController {
    
    func setup() {
        
        view.backgroundColor = .white
        stack.addArrangedSubview(astronomyImageView)
        view.addSubview(scrollView)
        scrollView.addSubview(stack)
        NSLayoutConstraint.activate([
            
            astronomyImageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            astronomyImageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stack.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stack.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}

