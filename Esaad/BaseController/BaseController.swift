//
//  BaseController.swift
//  Template
//
//  Created by Muzamil Hassan on 02/01/2017.
//  Copyright © 2017 Muzamil Hassan. All rights reserved.
//

import UIKit
import LGSideMenuController

class BaseController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.clear], for: UIControlState.highlighted)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        backButton()
    }
    
    fileprivate func backButton(){
    
    let backImage: UIImage = UIImage(named: "back_dark") ?? UIImage()
    let btnBack: UIButton = UIButton(type: .custom)
    btnBack.bounds = CGRect(x: 8, y: 0, width: backImage.size.width, height: backImage.size.height+20)
    self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(customView: btnBack)
    self.navigationController?.navigationBar.backIndicatorImage = backImage
    self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: #selector(self.popViewController), action: nil)
    }
    
   
    func whiteBackButton(){
        let backImage: UIImage = UIImage(named: "back") ?? UIImage()
        let btnBack: UIButton = UIButton(type: .custom)
        btnBack.bounds = CGRect(x: 8, y: 0, width: backImage.size.width, height: backImage.size.height+20)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(customView: btnBack)
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: #selector(self.popViewController), action: nil)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func createCenteredLogoImage(){
        
        let logo = UIImage(named: "home_EsaadLogoTopBar")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    
    func hideTabBar() {
        self.extendedLayoutIncludesOpaqueBars = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.tabBarController?.tabBar.isHidden = true
        }
        
    }
    func showTabBar() {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func createLeftNavigationItemButtons() {
        let imgSideMenu: UIImage = UIImage(named: "sideMenuIcon")!
        let leftSideMenuButton: UIButton = UIButton(type: .custom)
        leftSideMenuButton.bounds = CGRect(x: 0, y: 0, width: imgSideMenu.size.width, height: imgSideMenu.size.height+20)
        leftSideMenuButton.setImage(imgSideMenu, for: UIControlState())
        leftSideMenuButton.addTarget(self, action: #selector(showSideMenuOptions), for: .touchUpInside)
        let btnLeftSideItem: UIBarButtonItem = UIBarButtonItem(customView: leftSideMenuButton)
        self.navigationItem.leftBarButtonItems = [btnLeftSideItem]
    }
    
    
    @objc func showSideMenuOptions(){
        sideMenuController?.showLeftViewAnimated()
     //   Singleton.sharedInstance.isEnglishLanguageSelected ? sideMenuController?.showLeftViewAnimated() : //sideMenuController?.showRightViewAnimated()
    }
    @objc func actionSearchButton(){
        
    }
    
    @objc func actionFilterButton(){
        
    }
    
    

    
    func createHomeButtons() {
    }
    
    
    func popToRootViewController() {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addSideMenuBarButtonItem() {
        let image = UIImage(named:"Walkthrough_2Logo" )
        let side = UIBarButtonItem(image: image,
                                   style: .plain,
                                   target: self,
                                   action: #selector(onBtnSideMenu))
        
        self.navigationItem.leftBarButtonItem = side
    }
    func addEditMenuBarButtonItem() {
        let image = #imageLiteral(resourceName: "edit")
        let side = UIBarButtonItem(image: image,
                                   style: .plain,
                                   target: self,
                                   action: #selector(onBtnEdit))
        
        self.navigationItem.rightBarButtonItem = side
    }
    
    func createBackarrow(){
        backButton()
    }
    
    
    func addNotificationBarButtonItem() {
        let image = UIImage(named: "bell")
        let searchItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(onBtnNotification))
        
        self.navigationItem.rightBarButtonItem = searchItem
    }
    func addTickBarButtonItem() {
        let image = UIImage(named: "tick")
        let searchItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(onBtnTick))
        
        self.navigationItem.rightBarButtonItem = searchItem
    }
    
    func addTitle(title: String) {
        self.navigationController?.navigationBar.topItem?.title = title
    }
    
    @objc func onBtnNotification() {
    }
    
    @objc func onBtnSideMenu()  {
        self.showLeftView(self)
    }
    
    @objc func onBtnTick() {
        
    }
    
    @objc func onBtnEdit() {
        
    }
    
    @objc func popViewController() {
        self.navigationController?.popViewController(animated: true)
        
    }
    
//    func getArrayOfBytesFromImage(imageData:NSData,  array: @escaping (NSMutableArray)->())
    func getArrayOfBytesFromImage(imageData:NSData)->NSMutableArray
    {
        
        // the number of elements:
        let count = imageData.length / sizeof(UInt8.self)
        
        // create array of appropriate length:
        var bytes = [UInt8](repeating: 0, count: count)
        
        // copy bytes into array
        imageData.getBytes(&bytes, length:count * sizeof(UInt8.self))
        
        let byteArray:NSMutableArray = NSMutableArray()
        
        for i in 0..<count{
            byteArray.add(NSNumber(value: bytes[i]))
        }
        
//        array(byteArray)
        return byteArray
        
        
    }
    
    func sizeof <T> (_ : T.Type) -> Int
    {
        return (MemoryLayout<T>.size)
    }
    
    func sizeof <T> (_ : T) -> Int
    {
        return (MemoryLayout<T>.size)
    }
    
    func sizeof <T> (_ value : [T]) -> Int
    {
        return (MemoryLayout<T>.size * value.count)
    }
    
//    func changeColorOfNavigationWithColor(_ color:String?) {
//        if let navColor = color {
//        self.navigationController?.navigationBar.barTintColor = Utility.hexStringToUIColor(hex: navColor)
//        }
//        else
//        {
//            self.navigationController?.navigationBar.barTintColor = Global.APP_THEME_COLOR
//        }
//    }
    
}




