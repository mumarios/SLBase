//
//  HomeModuleNC.swift
//  FastCab User
//
//  Created by Hassan Khan on 7/7/17.
//  Copyright © 2017 Hassan Khan. All rights reserved.
//

import UIKit

class DashboardModuleNC: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.clear], for: UIControlState.highlighted)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        let visualEffectView   = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        var bounds = self.view.bounds
        bounds.size.height += 20
        bounds.origin.y -= 20
        visualEffectView.isUserInteractionEnabled = false
        visualEffectView.frame = bounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.navigationController?.navigationBar.addSubview(visualEffectView)
        visualEffectView.layer.zPosition = -1
    }
    

}
