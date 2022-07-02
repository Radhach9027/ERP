import UIKit
import DesignSystem

final class ModularConfiguration {
    
    static let shared = ModularConfiguration()
    private init(){}
    
    private enum ImagesCopy {
         static let search: String = "video"
         static let searchSelected: String = "video.fill"
         static let favorites: String = "star"
         static let favoritesSelected: String = "star.fill"
     }
    
    private lazy var makeFirstTab: TabBar = {
        TabBar.makeTab(controller: RootViewController(),
                       title:"First",
                       image: UIImage(systemName: ImagesCopy.favorites)!,
                       selectedImage:  UIImage(systemName: ImagesCopy.favoritesSelected)!)
    }()
    
    private lazy var makeSecondTab: TabBar = {
        TabBar.makeTab(controller: RootViewController(),
                       title:"Second",
                       image: UIImage(systemName: ImagesCopy.search)!,
                       selectedImage:  UIImage(systemName: ImagesCopy.searchSelected)!)
    }()
    
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
        let viewControllers = [makeFirstTab, makeSecondTab]
        return TabBarController(viewControllers: viewControllers,
                                didSelected: { _ in },
                                tabBarAppearance: tabBarAppearance)
    }
}
