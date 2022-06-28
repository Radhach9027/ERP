import Foundation

extension Bundle {
    
    private enum Copy {
        static let appName = "APP_NAME"
        static let apiKey = "API_KEY"
        static let baseUrl = "API_BASE_URL"
        static let appVersion = "APP_VERSION"
        static let appBundleId = "APP_BUNDLE_ID"
    }
    
    static var appName: String? {
        return main.object(forInfoDictionaryKey: Copy.appName) as? String
    }
    
    static var apiKey: String? {
        return main.object(forInfoDictionaryKey: Copy.apiKey) as? String
    }
    
    static var baseUrl: String? {
        return main.object(forInfoDictionaryKey: Copy.baseUrl) as? String
    }
    
    static var appVersion: String? {
        return main.object(forInfoDictionaryKey: Copy.appVersion) as? String
    }
    
    static var bundleId: String? {
        return main.object(forInfoDictionaryKey: Copy.appBundleId) as? String
    }
}
