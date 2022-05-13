//
//  AstronomyEndpoint.swift
//  WalmartAssignment
//
//  Created by radha chilamkurthy on 25/04/22.
//

import Foundation

enum AstronomyEndpoint {
    case fetch
}

extension AstronomyEndpoint: NetworkRequestProtocol {
    
    var baseURL: String {
        "https://api.nasa.gov"
    }
    
    var apiKey: String? {
        "DEMO_KEY"
    }
    
    var urlPath: String {
        "\("/planetary/apod")"
    }
    
    var urlComponents: URLComponents? {
        var components = URLComponents(string: baseURL + urlPath)
        components?.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        return components
    }
    
    var httpMethod: NetworkRequestMethod {
        .get
    }
    
    var httpHeaderFields: NetworkHTTPHeaderField? {
        .headerFields(fields: [.contentType : .json])
    }
    
    func manageInternetConnectivityBasedOnCache(request: URLRequest) -> NetworkError? {
        
        guard !isNetworkReachable else {
            return nil
        }
        
        guard (URLCache.shared.cachedResponse(for: request) == nil) else {
            return nil
        }
        
        return .noInternet
    }
}
