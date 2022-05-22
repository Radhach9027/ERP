//
//  NetworkError.swift
//  WalmartAssignment
//
//  Created by radha chilamkurthy on 25/04/22.
//

import Foundation

final class BundleClass {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
}

struct NetworkError: Error, Codable {
    let title: String
    let code: Int
    let errorMessage: String
    let userMessage: String
}

extension NetworkError {
    
    enum LocalNetworkCodes {
        static let unknown = 0
        static let noInternet = -1
        static let badUrl = -2
        static let api = -111
    }
    
    static var noInternet: NetworkError {
        NetworkError(title: "No Internet",
                     code: LocalNetworkCodes.noInternet,
                     errorMessage: "Something wrong with the url that has been constructed, Please check and try again",
                     userMessage: "")
    }
    
    static var badUrl: NetworkError {
        NetworkError(title: "Bar Request Constructed",
                     code: LocalNetworkCodes.badUrl,
                     errorMessage: "Something wrong with the url that has been constructed, Please check and try again",
                     userMessage: "")
    }
    
    static var networkErrorModel: [NetworkError]? {
        guard let ressourceURL =  BundleClass().bundle.url(forResource: "NetworkErrors",
                                                           withExtension: "json"),
              let jsonData = try? Data(contentsOf: ressourceURL),
              let model = try? JSONDecoder().decode([NetworkError].self,
                                                    from: jsonData) else {
            return nil
        }
        
        return model
    }
    
    static var unknown: NetworkError {
        NetworkError(title: "HTTPURLResponse is nil",
                     code: LocalNetworkCodes.unknown,
                     errorMessage: "",
                     userMessage: "An unknown error occurred while processing request, please check and try again.")
    }
    
    static func apiError(reason: String) -> NetworkError {
        NetworkError(title: "ApiError",
                     code: LocalNetworkCodes.api,
                     errorMessage: reason,
                     userMessage: "")
    }
    
    static func validateHTTPError(urlResponse: HTTPURLResponse?) -> NetworkError? {
        guard let response = urlResponse else {
            return  unknown
        }
        
        return networkErrorModel?.first(where: { $0.code == response.statusCode })
    }
    
    static func convertErrorToNetworkError(error: NSError) -> NetworkError {
        let errorcode = error.code
        let domain = error.domain
        let userMessage = error.localizedDescription
        var errorMessage = ""
        
        if let urlError = error.userInfo.first(where: {$0.key == "NSErrorFailingURLKey"})?.value as? Any {
            errorMessage = String(describing: urlError)
        }
        
        return NetworkError(title: domain,
                            code: errorcode,
                            errorMessage: errorMessage,
                            userMessage: userMessage)
    }
}
