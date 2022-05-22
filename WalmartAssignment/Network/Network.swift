//
//  Network.swift
//  WalmartAssignment
//
//  Created by radha chilamkurthy on 25/04/22.
//

import Foundation
import Combine

struct Network {
    private var session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
}

extension Network: NetworkProtocol {
    
    func request(for request: URLRequest,
                 receive: DispatchQueue) -> AnyPublisher<Data, NetworkError> {
        
        session.dataTaskPublisher(for: request)
            .receive(on: receive)
            .tryMap { (data, response) in
                guard let error = NetworkError.validateHTTPError(urlResponse: response as? HTTPURLResponse) else {
                    return data
                }
                
                throw error
            }
            .mapError { error in
                guard let error = error as? NetworkError else {
                    return NetworkError.convertErrorToNetworkError(error: error as NSError)
                }
                
                return error
            }
            .eraseToAnyPublisher()
    }
    
    func request(for url: URL,
                 receive: DispatchQueue) -> AnyPublisher<Data, NetworkError> {
        
        session.dataTaskPublisher(for: url)
            .receive(on: receive)
            .tryMap { (data, response) in
                guard let error = NetworkError.validateHTTPError(urlResponse: response as? HTTPURLResponse) else {
                    return data
                }
                
                throw error
            }
            .mapError { error in
                guard let error = error as? NetworkError else {
                    return NetworkError.convertErrorToNetworkError(error: error as NSError)
                }
                
                return error
            }
            .eraseToAnyPublisher()
    }
    
//    func bulkRequest(for requests: [URLRequest],
//                     receive: DispatchQueue) -> AnyPublisher<[Publishers.MergeMany<AnyPublisher<Data, NetworkError>.Output>]> {
//        
//        return Just(requests)
//            .setFailureType(to: NetworkError.self)
//            .flatMap { (values) -> Publishers.MergeMany<AnyPublisher<Data, NetworkError>> in
//                let tasks = values.map { (request) -> AnyPublisher<Data, NetworkError> in
//                    return self.request(for: request, receive: receive)
//                }
//                return Publishers.MergeMany(tasks)
//            }.collect()
//            .eraseToAnyPublisher()
//    }
}
