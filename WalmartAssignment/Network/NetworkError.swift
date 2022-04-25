//
//  NetworkError.swift
//  WalmartAssignment
//
//  Created by radha chilamkurthy on 25/04/22.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case unknown, badRequest, serverError, redirected, badUrl, noInternet, apiError(reason: String)
}

extension NetworkError {
    
    var errorDescription: String? {
        
        switch self {
            case .unknown:
                return "An unknown error occurred while processing request, please check and try again."
            case .badRequest:
                return "Bad Request, Please check your request and try again."
            case .serverError:
                return "The server has encountered a situation it does not know how to handle"
            case .redirected:
                return "The request had to be redirected, for various reasons."
            case .badUrl:
                return "Something wrong with the url that has been constructed, Please check and try again"
            case .noInternet:
                return "No internet, Please check your connection and try again"
            case .apiError(let reason):
                return reason
        }
    }
    
    static func validateHTTPError(urlResponse: HTTPURLResponse?) -> NetworkError? {
        
        guard let response = urlResponse else {
            return  .unknown
        }
        
        switch response.statusCode {
            case 200...299:
                return nil
            case 300...399:
                return .redirected
            case 400...499:
                return .badRequest
            case 500...599:
                return .serverError
            default:
                let message: String = HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
                return .apiError(reason: message)
        }
    }
}
