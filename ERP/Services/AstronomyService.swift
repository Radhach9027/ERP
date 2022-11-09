import Foundation
import Combine
import NetworkClient

protocol AstronomyServiceProtocol {
    func fetchAstronomyFromServer(
        endpoint: AstronomyEndpoint,
        receive: DispatchQueue
    ) -> AnyPublisher<NasaAstronomy, NetworkError>
}

final class AstronomyService: AstronomyServiceProtocol {
    private var network: NetworkProtocol
    private var cancellable = Set<AnyCancellable>()

    init(network: NetworkProtocol = Network.defaultSession) {
        self.network = network
    }
        
    deinit {
        print("AstronomyService de-init")
    }
    
    func fetchAstronomyFromServer(
        endpoint: AstronomyEndpoint,
        receive: DispatchQueue
    ) -> AnyPublisher<NasaAstronomy, NetworkError> {
        network.request(for: endpoint, codable: NasaAstronomy.self, receive: receive)
    }
}
