//
//  Network.swift
//  WalmartAssignment
//
//  Created by radha chilamkurthy on 25/04/22.
//

import Foundation
import Combine

final class Network {
    private var session: URLSessionProtocol
    private var sessionDelegate: NetworkSessionDelegateProtocol?
    static var isInternetReachable: Bool {
        NetworkReachability.shared.isReachable
    }
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
}

extension Network {
    
    convenience init(configuration: URLSessionConfiguration,
                     delegateQueue: OperationQueue,
                     pinning: SSLPinning) {
        
        let delegate = NetworkSessionDelegate(pinning: pinning)
        let session = URLSession(configuration: configuration,
                                 delegate: delegate,
                                 delegateQueue: delegateQueue)
        self.init(session: session)
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
}

// MARK: Cancel Tasks
extension Network {
    
    func cancelAllTasks() {
        session.invalidateAndCancel()
    }
    
    func cancelTaskWithUrl(url: URL) {
        session.getAllTasks { task in
            task
                .filter { $0.state == .running }
                .filter { $0.originalRequest?.url == url }.first?
                .cancel()
        }
    }
}

// TODO: Development in-progress

/*
// MARK: Bulk Tasks
extension Network {
    
    func bulkRequest(for requests: [URLRequest],
                     receive: DispatchQueue) -> AnyPublisher<[Publishers.MergeMany<AnyPublisher<Data, NetworkError>.Output>]> {
        
        return Just(requests)
            .setFailureType(to: NetworkError.self)
            .flatMap { (values) -> Publishers.MergeMany<AnyPublisher<Data, NetworkError>> in
                let tasks = values.map { (request) -> AnyPublisher<Data, NetworkError> in
                    return self.request(for: request, receive: receive)
                }
                return Publishers.MergeMany(tasks)
            }.collect()
            .eraseToAnyPublisher()
    }
}



// MARK: Upload Tasks
extension Network {
    
    func upload(with request: URLRequest,
                from bodyData: Data?,
                receive: DispatchQueue) -> AnyPublisher<UploadNetworkResponse, NetworkError> {
        
    }
}

// MARK: Download Tasks
extension Network {
    
    func download(for request: URLRequest,
                  receive: DispatchQueue) -> AnyPublisher<DownloadNetworkResponse, NetworkError> {
        
    }
    
    func download(for url: URL,
                  receive: DispatchQueue) -> AnyPublisher<DownloadNetworkResponse, NetworkError> {
        
    }
}
*/
