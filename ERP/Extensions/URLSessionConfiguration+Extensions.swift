import Foundation

extension URLSessionConfiguration {
    
    static var defaultConfig: URLSessionConfiguration {
        URLSessionConfiguration.default
    }
    
    static var backgroundConfig: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.background(withIdentifier: "Downloader")
        configuration.isDiscretionary = true
        return configuration
    }
}
