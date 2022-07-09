import UIKit
import DesignSystem
import Home
import Profile
import Favourites
import Settings

final class ModularConfiguration {
    
    static let shared = ModularConfiguration()
    private init(){}
    
    private lazy var homeTab: TabBar = {
        var root = RootViewController()
        root.title = Copy.home
        let rootNavigation = navigationController(root)
        return TabBar.makeTab(controller: rootNavigation,
                              title: Copy.home,
                              image: UIImage(systemName: ImagesCopy.home)!,
                              selectedImage:  UIImage(systemName: ImagesCopy.homeSelected)!)
    }()
    
    private lazy var favoritesTab: TabBar = {
        var fav = FavouritesViewController()
        fav.title = Copy.fav
        let rootNavigation = navigationController(fav)
        return TabBar.makeTab(controller: rootNavigation,
                              title: Copy.fav,
                              image: UIImage(systemName: ImagesCopy.favorites)!,
                              selectedImage:  UIImage(systemName: ImagesCopy.favoritesSelected)!)
    }()
    
    private lazy var profileTab: TabBar = {
        var profile = ProfileViewController()
        profile.title = Copy.profile
        let rootNavigation = navigationController(profile)
        return TabBar.makeTab(controller: rootNavigation,
                       title: Copy.profile,
                       image: UIImage(systemName: ImagesCopy.profile)!,
                       selectedImage:  UIImage(systemName: ImagesCopy.profileSelected)!)
    }()
    
    private lazy var settingsTab: TabBar = {
        var settings = SettingsViewController()
        settings.title = Copy.settings
        let rootNavigation = navigationController(settings)
        return TabBar.makeTab(controller: rootNavigation,
                       title: Copy.settings,
                       image: UIImage(systemName: ImagesCopy.settings)!,
                       selectedImage:  UIImage(systemName: ImagesCopy.settingsSelected)!)
    }()
    
    private lazy var navigationController:(UIViewController)-> UINavigationController = { controller in
        return UINavigationController(rootViewController: controller)
    }

    
    private lazy var tabBarAppearance: TabBarAppearance = {
        TabBarAppearance(tabColor: .blue,
                         tabTintColor: .white,
                         tabUnselectedColor: .gray,
                         tabItemTitleSelectedColor: .gray,
                         tabItemTitleUnSelectedColor: .gray,
                         tabItemTitleSelectedFont: UIFont.boldSystemFont(ofSize: 14),
                         tabItemTitleUnSelectedFont: UIFont.systemFont(ofSize: 14))
    }()
    
    var fetchRoot: UIViewController {
        let viewControllers = [homeTab,
                               favoritesTab,
                               profileTab,
                               settingsTab]
        return TabBarController(viewControllers: viewControllers,
                                didSelected: { _ in },
                                tabBarAppearance: tabBarAppearance)
    }
}

extension ModularConfiguration {
    
    private enum Copy {
        static let home: String = "Home"
        static let fav: String = "Favorites"
        static let profile: String = "Profile"
        static let settings: String = "Settings"
    }
    
    private enum ImagesCopy {
        static let home: String = "house"
        static let homeSelected: String = "house.fill"
        static let favorites: String = "star"
        static let favoritesSelected: String = "star.fill"
        static let profile: String = "person"
        static let profileSelected: String = "person.fill"
        static let settings: String = "gear.circle"
        static let settingsSelected: String = "gear.circle.fill"
    }
}
