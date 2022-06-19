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

extension Bundle {
    static var appName: String? {
        return main.object(forInfoDictionaryKey: "APP_NAME") as? String
    }
    
    static var apiKey: String? {
        return main.object(forInfoDictionaryKey: "API_KEY") as? String
    }
    
    static var baseUrl: String? {
        return main.object(forInfoDictionaryKey: "API_BASE_URL") as? String
    }
    
    static var appVersion: String? {
        return main.object(forInfoDictionaryKey: "APP_VERSION") as? String
    }
    
    static var bundleId: String? {
        return main.object(forInfoDictionaryKey: "APP_BUNDLE_ID") as? String
    }
}
