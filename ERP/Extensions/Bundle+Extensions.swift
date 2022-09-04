import Foundation

extension Bundle {
    
    private enum Copy {
        static let appName = "APP_NAME"
        static let apiKey = "API_KEY"
        static let baseUrl = "API_BASE_URL"
        static let appVersion = "APP_VERSION"
        static let appBundleId = "APP_BUNDLE_ID"
    }
    
    static var appName: String {
        guard let appName = main.object(forInfoDictionaryKey: Copy.appName) as? String else {
            fatalError("App name missing in plist")
        }
        return appName
    }
    
    static var apiKey: String {
        guard let apiKey = main.object(forInfoDictionaryKey: Copy.apiKey) as? String else {
            fatalError("Api key missing in plist")
        }
        return apiKey
    }
    
    static var baseUrl: String {
        guard let baseUrl = main.object(forInfoDictionaryKey: Copy.baseUrl) as? String else {
            fatalError("Base url missing in plist")
        }
        return baseUrl
    }
    
    static var appVersion: String {
        guard let appVersion = main.object(forInfoDictionaryKey: Copy.appVersion) as? String else {
            fatalError("App version missing in plist")
        }
        return appVersion
    }
    
    static var bundleId: String {
        guard let bundleId = main.object(forInfoDictionaryKey: Copy.appBundleId) as? String else {
            fatalError("Bundle id missing in plist")
        }
        return bundleId
    }
}
