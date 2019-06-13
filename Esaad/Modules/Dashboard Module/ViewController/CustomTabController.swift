//
//  CustomTabController.swift


import UIKit
import Alamofire
import TransitionableTab

class CustomTabController: UITabBarController,UITabBarControllerDelegate {
    
    var alreadyUpdated = false
    var lastSelectedIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    
        
        let tabDeals        = UITabBarItem(title: "bottomBar.deals".localized, image: UIImage(named: "tabbar_deals"), tag: 1)
        let dealsNavController = AppStoryboard.DealsModule.instance.instantiateInitialViewController() as! DashboardModuleNC
        dealsNavController.tabBarItem = tabDeals

            let tabHome         = UITabBarItem(title: "bottomBar.home".localized, image: UIImage(named: "tabbar_home") , tag: 4)
            let tabCategories   = UITabBarItem(title: "bottomBar.categories".localized, image: UIImage(named: "tabbar_categories"), tag: 5)
            let tabNearBy       = UITabBarItem(title: "bottomBar.nearby".localized, image: UIImage(named: "tabbar_nearby"), tag: 6)
            let tabSearch       = UITabBarItem(title: "bottomBar.search".localized, image: UIImage(named: "tabbar_search"), tag: 7)
            
            let homeNavController = AppStoryboard.HomeModule.instance.instantiateInitialViewController() as! DashboardModuleNC
            homeNavController.tabBarItem = tabHome
            
            let categoriesNavController = AppStoryboard.CategoriesModule.instance.instantiateInitialViewController() as! DashboardModuleNC
            categoriesNavController.tabBarItem = tabCategories
            
            let nearbyNavController = AppStoryboard.NearbyModule.instance.instantiateInitialViewController() as! DashboardModuleNC
            nearbyNavController.tabBarItem = tabNearBy
            
            let searchNavController = AppStoryboard.FilterModule.instance.instantiateInitialViewController() as! DashboardModuleNC
            searchNavController.tabBarItem = tabSearch
            
            // Home, categories, Deals, Near bY, Search
            let controllers = [homeNavController, categoriesNavController, dealsNavController, nearbyNavController, searchNavController]
            self.viewControllers = controllers
            self.selectedIndex = 0
            lastSelectedIndex = self.selectedIndex
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        let navController = self.viewControllers?[2] as! DashboardModuleNC
        let viewController = navController.topViewController as! HomeViewController
        //            let _ = viewController.loadView()

    }
}


extension CustomTabController: TransitionableTab {
    func transitionDuration() -> CFTimeInterval {
        return 0.4
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return animateTransition(tabBarController, shouldSelect: viewController)
    }
}
