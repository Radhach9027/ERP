//
//  NetworkRequestProtocol.swift
//  WalmartAssignment
//
//  Created by radha chilamkurthy on 25/04/22.
//

import Foundation

protocol NetworkRequestProtocol: NetworkEnvironmentProtocol {
    var urlPath: String { get }
    var httpMethod: NetworkRequestMethod { get }
    var urlComponents: URLComponents? { get }
    var httpHeaderFields: NetworkHTTPHeaderField? { get }
    var httpBodyParameters: NetworkBodyRequestParameters? { get }
    var isNetworkReachable: Bool { get }
    func makeRequest() throws -> URLRequest
    func manageInternetConnectivityBasedOnCache(request: URLRequest) -> NetworkError?
}

extension NetworkRequestProtocol {
    
    var httpHeaderFields: NetworkHTTPHeaderField? {
        nil
    }
    
    var httpBodyParameters: NetworkBodyRequestParameters? {
        nil
    }
    
    var apiKey: String? {
        nil
    }
    
    private func makeBody() throws -> Data? {
        guard let parameters = httpBodyParameters else {
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
        request.httpMethod = httpMethod.rawValue
        
        httpHeaderFields?.headers.forEach {
            request.setValue($0.value.description,
                             forHTTPHeaderField: $0.key.description)
        }
        
        do {
            let body =  try makeBody()
            request.httpBody = body
        } catch {
            throw error
        }
        
        guard let isReachableError = manageInternetConnectivityBasedOnCache(request: request) else {
            return request
        }
        
        throw isReachableError
    }
    
    func manageInternetConnectivityBasedOnCache(request: URLRequest) -> NetworkError? {
        
        guard isNetworkReachable else {
            return .noInternet
        }
        
        return nil
    }
}
