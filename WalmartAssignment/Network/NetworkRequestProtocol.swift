//
//  NetworkRequestProtocol.swift
//  WalmartAssignment
//
//  Created by radha chilamkurthy on 25/04/22.
//

import Foundation

protocol NetworkRequestProtocol: NetworkEnvironmentProtocol {
    var path: String { get }
    var method: NetworkRequestMethod { get }
    var urlComponents: URLComponents? { get }
    var headerFields: NetworkHTTPHeaderField? { get }
    var bodyParameters: NetworkBodyRequestParameters? { get }
    var isNetworkReachable: Bool { get }
    func makeRequest() throws -> URLRequest
    func checkInternetConnectivityBasedOnCache(request: URLRequest) -> NetworkError?
}

extension NetworkRequestProtocol {
    
    var headerFields: NetworkHTTPHeaderField? {
        nil
    }
    
    var bodyParameters: NetworkBodyRequestParameters? {
        nil
    }
    
    var apiKey: String? {
        nil
    }
    
    private func makeBody() throws -> Data? {
        guard let parameters = bodyParameters else {
            return nil
        }
        
        do {
            let jsonData =  try JSONSerialization.data(withJSONObject: parameters,
                                                       options: .prettyPrinted)
            return jsonData
        } catch {
            throw error
        }
    }
    
    var isNetworkReachable: Bool {
        NetworkReachability.shared.isReachable
    }
    
    func makeRequest() throws -> URLRequest {
        
        guard let url = urlComponents?.url else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        headerFields?.headers.forEach {
            request.setValue($0.value.description,
                             forHTTPHeaderField: $0.key.description)
        }
        
        do {
            let body =  try makeBody()
            request.httpBody = body
        } catch {
            throw error
        }
        
        guard let isReachableError = checkInternetConnectivityBasedOnCache(request: request) else {
            return request
        }
        
        throw isReachableError
    }
    
    func checkInternetConnectivityBasedOnCache(request: URLRequest) -> NetworkError? {
        
        guard isNetworkReachable else {
            return .noInternet
        }
        
        return nil
    }
}
