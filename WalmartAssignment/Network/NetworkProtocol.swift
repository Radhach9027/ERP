//
//  NetworkProtocol.swift
//  WalmartAssignment
//
//  Created by radha chilamkurthy on 25/04/22.
//

import Foundation
import Combine

protocol RequestProtocol {
    
    func request(for request: URLRequest,
                 receive: DispatchQueue) -> AnyPublisher<Data, NetworkError>
    
    func request(for url: URL,
                 receive: DispatchQueue) -> AnyPublisher<Data, NetworkError>
}

protocol UploadProtocol {
    
    func upload(with request: URLRequest,
                from bodyData: Data?,
                receive: DispatchQueue) -> AnyPublisher<UploadNetworkResponse, NetworkError>
    
    func upload(for request: URLRequest,
                fileURL: URL,
                receive: DispatchQueue) -> AnyPublisher<UploadNetworkResponse, NetworkError>
    
}

protocol DownloadProtocol {
    
    func download(for request: URLRequest,
                  receive: DispatchQueue) -> AnyPublisher<DownloadNetworkResponse, NetworkError>
    
    func download(for url: URL,
                  receive: DispatchQueue) -> AnyPublisher<DownloadNetworkResponse, NetworkError>
    
}

protocol sessionCancelProtocol {
    
    func cancelAllTasks()
    
    func cancelTaskWithUrl(url: URL)
    
    static var isInternetReachable: Bool { get }
}

protocol NetworkProtocol : RequestProtocol, sessionCancelProtocol {}
