    //
    //  NetworkLogger.swift
    //  WalmartAssignment
    //
    //  Created by radha chilamkurthy on 23/05/22.
    //

import Foundation
import os

public enum LoggerCategory {
    case requests, errors
}

public enum LoggerPrivacy {
    case open, encapsulate, encrypt
}

extension LoggerCategory {
    
    public var description: String {
        switch self {
            case .requests:
                return "NetworkRequests"
            case .errors:
                return "NetworkErrors"
        }
    }
}

protocol NetworkLoggerProtocol {
    
    func logRequest(request: URLRequest,
                    type: OSLogType,
                    privacy: LoggerPrivacy)
    
    func logErrors(request: URLRequest,
                   error: NetworkError,
                   type: OSLogType,
                   privacy: LoggerPrivacy)
}

public struct NetworkLogger: NetworkLoggerProtocol {
    
    private var identifier: String
    private var category: LoggerCategory
    private let logger: Logger
    
    public init(identifier: String,
                category: LoggerCategory) {
        
        self.identifier = identifier
        self.category = category
        self.logger = Logger(
            subsystem: identifier,
            category: category.description
        )
    }
    
    func logRequest(request: URLRequest,
                    type: OSLogType,
                    privacy: LoggerPrivacy) {
        
        switch privacy {
            case .open:
                logger.log(level: type, "NetworkRequest: \(request, privacy: .private(mask: .hash))")
            case .encapsulate:
                logger.log(level: type, "NetworkRequest: \(request, privacy: .private(mask: .hash))")
            case .encrypt:
                logger.log(level: type, "NetworkRequest: \(request, privacy: .private(mask: .hash))")
        }
    }
    
    func logErrors(request: URLRequest,
                   error: NetworkError,
                   type: OSLogType,
                   privacy: LoggerPrivacy) {
        
        switch privacy {
            case .open:
                logger.log(level: type, "NetworkError: \(request, privacy: .private(mask: .hash))")
            case .encapsulate:
                logger.log(level: type, "NetworkError: \(request, privacy: .private(mask: .hash))")
            case .encrypt:
                logger.log(level: type, "NetworkError: \(request, privacy: .private(mask: .hash))")
        }
    }
}
