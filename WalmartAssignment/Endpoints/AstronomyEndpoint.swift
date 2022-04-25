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
    
    var path: String {
        switch self {
            case .fetch:
                return "\("/planetary/apod")"
        }
    }
    
    var urlComponents: URLComponents? {
        var components = URLComponents(string: baseURL + path)
        components?.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        return components
    }
    
    var method: NetworkRequestMethod {
        switch self {
            case .fetch:
                return .get
        }
    }
    
    var headerFields: NetworkHTTPHeaderField? {
        switch self {
            case .fetch:
                return .headerFields(fields: [.contentType : .json])
        }
    }
}
