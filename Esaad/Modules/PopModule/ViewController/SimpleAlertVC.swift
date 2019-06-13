//
//  SimpleAlertVC.swift
//  FastCab User
//
//  Created by Hassan Khan on 7/17/17.
//  Copyright © 2017 Hassan Khan. All rights reserved.
//

import UIKit

class SimpleAlertVC: UIViewController {

    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    
    
    var titleString = ""
    var descriptionString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.clear
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    
        self.labelTitle.text = self.titleString
        self.labelDescription.text = self.descriptionString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionOk(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
