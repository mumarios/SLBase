//
//  SplashVC.swift
//  Esaad
//
//  Created by Faraz Haider on 9/10/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit
import MOLH
import Crashlytics


enum LanguageSelection:Int {
    case EnglishSelected = 0
    case ArabicSelected = 1
}

class SplashVC: UIViewController {
    var languageSelected : LanguageSelection = LanguageSelection.EnglishSelected

    @IBOutlet weak var buttonArabicSelected: UIButton!
    @IBOutlet weak var buttonEnglishSelected: UIButton!
    @IBOutlet weak var imageViewSplash: UIImageView!

    let appDelegate = Constants.APP_DELEGATE
    let defauls = Constants.USER_DEFAULTS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonEnglishSelected.alpha = 1.0
        buttonArabicSelected.alpha = 0.5
    }
    
    @IBAction func actionChangeLanguage(_ sender: Any) {
        
        let buttonSelected:UIButton = sender as! UIButton
        if buttonSelected == buttonEnglishSelected{
            buttonEnglishSelected.isSelected = true
            buttonArabicSelected.isSelected = false

            buttonEnglishSelected.alpha = 1.0
            buttonArabicSelected.alpha = 0.5

            languageSelected = LanguageSelection.EnglishSelected
        } else{
            buttonEnglishSelected.isSelected = true
            buttonArabicSelected.isSelected = false

            buttonEnglishSelected.alpha = 0.5
            buttonArabicSelected.alpha = 1.0

            languageSelected = LanguageSelection.ArabicSelected
        }
    }
    
    @IBAction func actionSelectLanguage(_ sender: Any) {
//        if let homeVC = AppStoryboard.HomeModule.instance.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
//            Constants.APP_DELEGATE.window?.rootViewController = homeVC
//        }
        
        Constants.APP_DELEGATE.shiftToHome()
        
        print(languageSelected)
        if languageSelected == LanguageSelection.EnglishSelected
        {
            MOLH.setLanguageTo("en")
            defauls.set(true, forKey: "EnglishSelected")
            Singleton.sharedInstance.isEnglishLanguageSelected = true
        }else
        {
            MOLH.setLanguageTo("ar")
            defauls.set(false, forKey: "EnglishSelected")
            Singleton.sharedInstance.isEnglishLanguageSelected = false
        }
        
        MOLH.reset()
        
    }
}
