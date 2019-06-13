//
//  MainViewController.swift
//  LGSideMenuControllerDemo


import LGSideMenuController

class MainViewController: LGSideMenuController {
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        leftViewBackgroundColor = Global.APP_THEME_COLOR
        rightViewBackgroundColor = Global.APP_THEME_COLOR
        
        leftViewPresentationStyle = .slideAbove
        rightViewPresentationStyle = .slideAbove
        
        isLeftViewSwipeGestureEnabled = false
        isRightViewSwipeGestureEnabled = false
    }
}
