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
    
    enum Copy {
        static let fileName = "NetworkErrors"
        static let fileType = "json"
        static let noInternet = "Something wrong with the url that has been constructed, Please check and try again"
        static let noInternetTitle = "No Internet"
        static let badUrlTitle = "Bar Request Constructed"
        static let badUrl = "Something wrong with the url that has been constructed, Please check and try again"
        static let unknown = "An unknown error occurred while processing request, please check and try again."
        static let HTTPresponseNil = "HTTPURLResponse is nil"
        static let apiError =  "ApiError"
        static let nsErrorURLKey = "NSErrorFailingURLKey"
    }
    
    static var noInternet: NetworkError {
        NetworkError(title: Copy.noInternetTitle,
                     code: LocalNetworkCodes.noInternet,
                     errorMessage: Copy.noInternet,
                     userMessage: .empty)
    }
    
    static var badUrl: NetworkError {
        NetworkError(title: Copy.badUrlTitle,
                     code: LocalNetworkCodes.badUrl,
                     errorMessage: Copy.badUrl,
                     userMessage: .empty)
    }
    
    static var networkErrorModel: [NetworkError]? {
        guard let ressourceURL =  BundleClass().bundle.url(forResource: Copy.fileName,
                                                           withExtension: Copy.fileType) else {
            return nil
        }
        
        do {
            let jsonData = try Data(contentsOf: ressourceURL)
            let model = try JSONDecoder().decode([NetworkError].self,
                                                 from: jsonData)
            return model
        } catch {
            print(error)
        }
        
        return nil
    }
    
    static var unknown: NetworkError {
        NetworkError(title: Copy.HTTPresponseNil,
                     code: LocalNetworkCodes.unknown,
                     errorMessage: .empty,
                     userMessage: Copy.unknown)
    }
    
    static func apiError(reason: String) -> NetworkError {
        NetworkError(title: Copy.apiError,
                     code: LocalNetworkCodes.api,
                     errorMessage: reason,
                     userMessage: .empty)
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
        var errorMessage: String = .empty
        
        if let urlError = error.userInfo.first(where: {$0.key == Copy.nsErrorURLKey })?.value {
            errorMessage = String(describing: urlError)
        }
        
        return NetworkError(title: domain,
                            code: errorcode,
                            errorMessage: errorMessage,
                            userMessage: userMessage)
    }
}
