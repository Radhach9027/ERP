//
//  URLSessionConfiguration+Extensions.swift
//  WalmartAssignment
//
//  Created by radha chilamkurthy on 23/05/22.
//

import Foundation

extension URLSessionConfiguration {
    
    static var defaultConfig: URLSessionConfiguration {
        URLSessionConfiguration.default
    }
    
    static var backgroundConfig: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.background(withIdentifier: "Downloader")
        configuration.isDiscretionary = true
        return configuration
    }
}
