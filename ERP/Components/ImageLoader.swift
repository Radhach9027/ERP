import UIKit
import Combine
import NetworkClient

final class ImageLoader: UIImageView {
    
    private var network: NetworkProtocol?
    private var imageURL: URL?
    private var cancellable = Set<AnyCancellable>()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .medium
        indicator.color = .darkGray
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    init(network: NetworkProtocol = Network(config: .cache())) {
        self.network = network
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func loadImageWithUrl(_ url: URL) {
        imageURL = url
        image = nil
        activityIndicator.startAnimating()
        loadImage(endpoint: .fetch(url: url))
    }
    
    private func loadImage(endpoint: ImageLoaderEndpoint) {
        network?.request(for: endpoint,
                            receive: .main)
            .sink { [weak self] result in
                switch result {
                    case .finished:
                        print("Done")
                    case .failure(let error):
                        print(error)
                }
                self?.activityIndicator.stopAnimating()
                
            } receiveValue: { [weak self] data in
                
                if let imageToCache = UIImage(data: data) {
                    self?.image = imageToCache
                }
            }.store(in: &cancellable)
    }
}
