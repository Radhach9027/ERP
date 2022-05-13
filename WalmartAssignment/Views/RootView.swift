//
//  RootView.swift
//  WalmartAssignment
//
//  Created by radha chilamkurthy on 13/05/22.
//

import UIKit

final class RootView: UIView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        
        backgroundColor = .white
        stack.addArrangedSubview(astronomyImageView)
        addSubview(scrollView)
        scrollView.addSubview(stack)
        NSLayoutConstraint.activate([
            
            astronomyImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            astronomyImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            
            scrollView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            stack.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stack.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    func config(model: NasaAstronomy) {
        
        [makeLabel("\(model.title)",
                   .boldSystemFont(ofSize: 20),
                   .black),
         makeLabel("\(model.explanation)",
                   .systemFont(ofSize: 14),
                   .gray)].forEach { label in
            stack.addArrangedSubview(label)
        }
        
        guard let url = URL(string: model.url) else {
            return
        }
        astronomyImageView.loadImageWithUrl(url)
    }
}
