import NetworkClient

extension NetworkRequestProtocol {
    
    var baseURL: String {
        guard let base = Configuration.baseUrl.description else {
            return ""
        }
        return base
    }
    
    var apiKey: String? {
        Configuration.apiKey.description
    }
}
