//
//  SplashViewController.swift
//  Esaad
//
//  Created by Faran Rasheed on 30/05/2019.
//  Copyright © 2019 Systems Ltd. All rights reserved.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    @IBOutlet weak var logoAnimationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animation = Animation.named("esaadlogo", subdirectory: "Animations")
        logoAnimationView.animation = animation
        logoAnimationView.contentMode = .scaleAspectFit
        
        logoAnimationView.play() { complete in
        }
    }
}
