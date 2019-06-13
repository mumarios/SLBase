//
//  AppDelegate.swift
//  Esaad
//
//  Created by Faraz Haider on 27/08/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleMaps
import RMMapper
import UserNotifications
import MOLH
import Firebase
import Fabric
import Crashlytics


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let center = UNUserNotificationCenter.current()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        // Shift to Splash Screen for animation
        let storyboard = AppStoryboard.SplashModule.instance
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "splashViewController") as! SplashVC
        Constants.UIWINDOW?.rootViewController = mainViewController
        Constants.UIWINDOW?.makeKeyAndVisible()

        return true
    }
    
    func shiftToHome()  {
        let storyboard = AppStoryboard.DashboardModule.instance
        let mainViewController = storyboard.instantiateInitialViewController() as! MainViewController
        ShowHomeController(mainViewController)
    }
    
    func ShowHomeController(_ viewController:UIViewController){
        //homeNavController = viewController
        Constants.UIWINDOW?.rootViewController = viewController
        Constants.UIWINDOW?.makeKeyAndVisible()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
