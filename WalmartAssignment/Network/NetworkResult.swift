//
//  NetworkResult.swift
//  WalmartAssignment
//
//  Created by radha chilamkurthy on 23/05/22.
//

import Foundation

enum UploadNetworkResponse {
    case progress(percentage: Double)
    case response(data: Data?)
}

enum DownloadNetworkResponse {
    case progress(percentage: Double)
    case response(data: URL?)
}
