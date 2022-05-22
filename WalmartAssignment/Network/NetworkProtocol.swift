//
//  NetworkProtocol.swift
//  WalmartAssignment
//
//  Created by radha chilamkurthy on 25/04/22.
//

import Foundation
import Combine

protocol NetworkProtocol {
    
    func request(for request: URLRequest,
                 receive: DispatchQueue) -> AnyPublisher<Data, NetworkError>
    
    func request(for url: URL,
                 receive: DispatchQueue) -> AnyPublisher<Data, NetworkError>
    
    /*func bulkRequest(for requests: [URLRequest],
                 receive: DispatchQueue) -> AnyPublisher<Data, NetworkError>*/
    
}
