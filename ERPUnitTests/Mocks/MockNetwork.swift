import ERP
import Foundation
import Combine
import NetworkClient

struct MockNetwork: NetworkProtocol {
    
    static var isInternetReachable = true
    var isSuccess: Bool
    var errorType: NetworkError? = nil
    
    var mockNasaAstronomyData: Data? {
        guard let ressourceURL =  BundleClass().bundle.url(forResource: "AstronomyResponse", withExtension: "json") else {
            return nil
        }
        let jsonData = try? Data(contentsOf: ressourceURL)
        return jsonData
    }
    
    var expectedAstronomyModel: NasaAstronomy? {
        guard let jsonData =  mockNasaAstronomyData,
              let model = try? JSONDecoder().decode(NasaAstronomy.self, from: jsonData)else {
                  return nil
              }
        
        return model
    }

    func request(for request: URLRequest,
                 receive: DispatchQueue) -> AnyPublisher<Data, NetworkError> {
        
        if isSuccess {
            return Just(mockNasaAstronomyData!)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: errorType ?? .unknown)
                .eraseToAnyPublisher()
        }
    }
    
    func request(for url: URL, receive: DispatchQueue) -> AnyPublisher<Data, NetworkError> {
        
        if isSuccess {
            return Just(mockNasaAstronomyData!)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: errorType ?? .unknown)
                .eraseToAnyPublisher()
        }
    }
    
    func cancelAllTasks() {
        
    }
    
    func cancelTaskWithUrl(url: URL) {
        
    }
}
