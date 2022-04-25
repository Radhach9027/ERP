//
//  NetworkEnvironmentProtocol.swift
//  WalmartAssignment
//
//  Created by radha chilamkurthy on 25/04/22.
//

import Foundation

protocol NetworkEnvironmentProtocol {
    var baseURL: String { get }
    var apiKey: String? { get }
}
