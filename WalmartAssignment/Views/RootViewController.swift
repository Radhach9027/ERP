//
//  ViewController.swift
//  WalmartAssignment
//
//  Created by radha chilamkurthy on 25/04/22.
//

import UIKit
import Combine

class RootViewController: UIViewController {
    
    private var cancellable = Set<AnyCancellable>()
    private var viewModel: NasaAstronomyViewModelProtocol
    
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
    
    init(viewModel: NasaAstronomyViewModelProtocol = NasaAstronomyViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension RootViewController {
    
    func setup() {

        defer {
            fetchData()
            listenToSubscriptions()
        }
        
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
    
    func fetchData() {
        viewModel.fetchAstronomy(on: .main)
    }
    
    func listenToSubscriptions() {
        viewModel.subject
            .compactMap{$0}
            .sink { result in
                switch result {
                    case .failure(let error):
                        print(error.errorDescription ?? "something went wrong")
                    default:
                        break
                }
            } receiveValue: { [weak self] model in
                self?.renderUIElements(model: model)
            }.store(in: &cancellable)
    }
    
    
    func renderUIElements(model: NasaAstronomy) {
        
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

