import Foundation
import DependencyContainer
import NetworkClient

protocol DependencyProtocol {
    static func addDependencies()
    static func mockDependencies()
}

struct DIContainer: DependencyProtocol {
    
    private static let dependcies = Dependencies {
        Dependency { NasaAstronomyViewModel() as NasaAstronomyViewModelProtocol }
        Dependency { Network(config: .default()) as NetworkProtocol }
        Dependency { AstronomyService() as AstronomyServiceProtocol }
    }
    
    static func addDependencies() {
        DIContainer.dependcies.build()
    }
    
    static func mockDependencies() {
        
    }
}
