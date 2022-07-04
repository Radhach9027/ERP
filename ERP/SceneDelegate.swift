import UIKit
import DesignSystem

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let navigation = UINavigationController(rootViewController: ModularConfiguration.shared.fetchRoot)
        window.rootViewController = navigation
        self.window = window
        window.makeKeyAndVisible()
    }
}

