//
//  Enums.swift
//  Versole
//
//  Created by Soomro Shahid on 2/21/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import Foundation
import UIKit

enum Controllers {
    case ChannelVoirController
    case AddVoirController
    case ReportController
    
}

enum TransitionType {
    case PUSH
    case PRESENT
}

enum notificationRouteType : Int {
    case NEW = 1
    case FEATURED
    case NEAREST
    case FAV
}

enum AppStoryboard : String {
    
    //Add all the storyboard names you wanted to use in your project
    case LoginModule,SplashModule, HomeModule, WalkthroughModule, DashboardModule ,SideMenuModule, PopupModule, SettingsModule,FilterModule, ContactUsModule, AboutModule, PrivacyModule, TermsAndConditionModule, CategoriesModule, NearbyModule, DealsModule, QuicklinksModule, ProfileModule, NewsModule, UserDashboardModule
    
    var instance : UIStoryboard {
        
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        
        return instance.instantiateInitialViewController()
    }
}


