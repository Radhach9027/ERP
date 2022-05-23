//
//  Network+Extensions.swift
//  WalmartAssignment
//
//  Created by radha chilamkurthy on 23/05/22.
//

import Foundation

extension Network {
    
    static var certificate: SecCertificate? {
        switch SecCertificate.loadFromBundle() {
            case .success(let cert):
                return cert
            case .failure(let error):
                print(error)
                return nil
        }
    }
    
    static var session: Network {
        
        guard let certificate = certificate else {
            return Network()
        }
        
        let network = Network(configuration: .defaultConfig,
                              delegateQueue: OperationQueue(),
                              pinning: SSLPinning.certificatePinning(certificate: certificate,
                                                                     hash: SecCertificate.hashKey))
        return network
        
    }
}
