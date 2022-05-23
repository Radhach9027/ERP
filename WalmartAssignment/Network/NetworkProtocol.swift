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
    
    // TODO: Development in-progress

    /*func upload(with request: URLRequest,
                from bodyData: Data?,
                receive: DispatchQueue) -> AnyPublisher<UploadNetworkResponse, NetworkError>
    
    func download(for request: URLRequest,
                  receive: DispatchQueue) -> AnyPublisher<DownloadNetworkResponse, NetworkError>
    
    func download(for url: URL,
                  receive: DispatchQueue) -> AnyPublisher<DownloadNetworkResponse, NetworkError>
    
    func bulkRequest(for requests: [URLRequest],
                     receive: DispatchQueue) -> AnyPublisher<Data, NetworkError>*/
    
    func cancelAllTasks()
    
    func cancelTaskWithUrl(url: URL)
    
    static var isInternetReachable: Bool { get }
}
