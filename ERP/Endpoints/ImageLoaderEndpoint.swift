import Foundation
import NetworkClient

enum ImageLoaderEndpoint {
    case fetch(url: URL)
}

extension ImageLoaderEndpoint: NetworkRequestProtocol {
    var urlPath: String {
        ""
    }

    var urlComponents: URLComponents? {
        switch self {
        case let .fetch(url):
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
    }

    var httpMethod: NetworkRequestMethod {
        .get
    }
}
