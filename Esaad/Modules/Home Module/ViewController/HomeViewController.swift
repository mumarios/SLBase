//
//  HomeViewController.swift
//  Esaad
//
//  Created by Faraz Haider on 13/06/2019.
//  Copyright © 2019 Systems Ltd. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

class HomeViewController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showTabBar()
        
    }
    
    func setupUI(){
        super.createLeftNavigationItemButtons()
    }

}
