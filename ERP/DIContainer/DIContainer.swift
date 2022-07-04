import Foundation
import DependencyContainer
import NetworkClient

protocol DependencyProtocol {
    static func addDependencies()
    static func mockDependencies()
}

struct DIContainer: DependencyProtocol {
    
    private static let dependcies = Dependencies {
        Dependency { Network() as NetworkProtocol }
    }
    
    static func addDependencies() {
        DIContainer.dependcies.build()
    }
    
    static func mockDependencies() {
    }
}
