//
//  HomeNavigationVCViewController.swift
//  Esaad
//
//  Created by Faraz Haider on 13/06/2019.
//  Copyright © 2019 Systems Ltd. All rights reserved.
//

import UIKit

class HomeNavigationVCViewController: UINavigationController {

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
