//
//  SidemenuManager.swift
//  Esaad
//
//  Created by Faran Rasheed on 11/04/2019.
//  Copyright © 2019 Systems Ltd. All rights reserved.
//

import UIKit
import EZAlertController
import Kingfisher
import LGSideMenuController

class SidemenuManager: NSObject {
   
    static let sharedInstance = SidemenuManager()
    private var leftMenu = true
    public var arrayTitle = [String]()
    public var arrayImages = [String]()
    public var parentController: LGSideMenuController?
    
    public func setupData(){
    
        arrayTitle = [
            "sidemenu.partnerFacility".localized,
            "sidemenu.inquiry".localized,
            "sidemenu.quickLinks".localized,
            "sidemenu.news".localized,
            "sidemenu.settings".localized
        ]
    
        arrayImages = [
            "sidemenu_partner",
            "sidemenu_inquires",
            "sidemenu_quicklinks",
            "sidemenu_news",
            "sidemen_setting",
            "sidemenu_logout"]
    }
    
    public func menuOptionClicked(atIndex index: Int, forLeftMenu lMemnu: Bool = true){

        self.leftMenu = lMemnu


            switch index {
                
            case 0:
                print(("Dashboard Clicked"))
                self.dashboardButtonClicked()
                break
            
            case 1:
                print(("Fav deals Clicked"))
                self.favDealsButtonClicked()
                break
            
            case 2:
                print(("Partner facilities Clicked"))
                self.partnersButtonClicked()
                break
            
            case 3:
                print(("Inquiry Clicked"))
                self.inquiriesButtonClicked()
                break
            
            case 4:
                print(("Quick Links Clicked"))
                self.quickLinksButtonClicked()
                break
            
            case 5:
                print(("News Clicked"))
                self.newsButtonClicked()
                break
            
            case 6:
                print(("Settings Clicked"))
                self.settingButtonClicked()
                break
            
            case 7:
                print(("Logout Clicked"))
                self.logoutButtonClicked()
                break
            
            default:
                print("......")
            }
        
    }
    
    func dashboardButtonClicked() {
        
    }
    
    func favDealsButtonClicked(){
        self.hideSideMenu()
    }
    
    func partnersButtonClicked() {

    }
    
    func inquiriesButtonClicked() {

    }
    
    func quickLinksButtonClicked() {

    }
        
    func newsButtonClicked() {

    }
    
    func settingButtonClicked() {
 
    }
    
    func navigateTo(viewController: UIViewController){
        
        let tabbarViewController = self.parentController?.rootViewController as! UITabBarController
        let currentNavigationController = tabbarViewController.selectedViewController as! DashboardModuleNC
        currentNavigationController.pushViewController(viewController, animated: false)
        
        self.hideSideMenu()
    }
    
    func hideSideMenu(){
        if self.leftMenu{
            self.parentController?.hideLeftView(animated: true, delay: 0.0, completionHandler: nil)
        } else {
            self.parentController?.hideRightView(animated: true, delay: 0.0, completionHandler: nil)
        }
    }
    
    func logout() {

    }
    
    func logoutButtonClicked() {
        
    }
}
