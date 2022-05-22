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
    private lazy var rootView: RootView = {
        let rootView = RootView(frame: .zero)
        rootView.translatesAutoresizingMaskIntoConstraints = false
        return rootView
    }()
    
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
        
        title = "Nasa Astronomy"
        view.backgroundColor = .white
        view.addSubview(rootView)
        view.pin(someView: rootView)
    }
    
    func fetchData() {
        viewModel.fetchAstronomy(on: .main)
    }
    
    func listenToSubscriptions() {
        viewModel.subject
            .receive(on: DispatchQueue.main)
            .compactMap{$0}
            .sink { [weak self] result in
                switch result {
                    case .failure(let error):
                    self?.present(withTitle: error.title,
                                  message: error.errorMessage)
                    default:
                        break
                }
            } receiveValue: { [weak self] model in
                self?.rootView.config(model: model)
            }.store(in: &cancellable)
    }
}

