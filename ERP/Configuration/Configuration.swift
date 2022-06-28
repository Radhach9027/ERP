import Foundation

enum Configuration {
    case baseUrl
    case apiKey
    case appName
    case appVersion
    case bundleId
    
    var description: String? {
        switch self {
            case .baseUrl:
                return Bundle.baseUrl
            case .apiKey:
                return Bundle.apiKey
            case .appName:
                return Bundle.appName
            case .appVersion:
                return Bundle.appVersion
            case .bundleId:
                return Bundle.bundleId
        }
    }
}
