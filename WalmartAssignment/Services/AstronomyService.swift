//
//  AstronomyService.swift
//  WalmartAssignment
//
//  Created by radha chilamkurthy on 25/04/22.
//

import Foundation
import Combine

protocol AstronomyServiceProtocol {
    func fetchAstronomyFromServer(endpoint: AstronomyEndpoint,
                                  receive: DispatchQueue) -> Future<NasaAstronomy, NetworkError>
}

final class AstronomyService: AstronomyServiceProtocol {
    private var network: NetworkProtocol
    private var cancellable = Set<AnyCancellable>()
    
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }
    
    deinit {
        print("AstronomyService de-init")
    }
    
    func fetchAstronomyFromServer(endpoint: AstronomyEndpoint,
                                  receive: DispatchQueue) -> Future<NasaAstronomy, NetworkError> {
        
        Future<NasaAstronomy, NetworkError> { [unowned self] promise in
            do {
                let request = try endpoint.makeRequest()
                self.network.request(for: request,
                                        receive: .main)
                    .receive(on: receive)
                    .decode(type: NasaAstronomy.self, decoder: JSONDecoder())
                    .sink(receiveCompletion: { result in
                        switch result {
                            case .failure(let error):
                                promise(.failure(NetworkError.apiError(reason: error.localizedDescription)))
                            default:
                                break
                        }
                    }, receiveValue: {promise(.success($0))})
                    .store(in: &self.cancellable)
                
            } catch {
                promise(.failure(NetworkError.apiError(reason: error.localizedDescription)))
            }
        }
    }
}