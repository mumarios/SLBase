//
//  LeftViewController.swift
//  LGSideMenuControllerDemo
//
import UIKit
import EZAlertController
import Kingfisher

class LeftViewController: UIViewController{
    
    
    @IBOutlet weak var sidemenuTableView: UITableView!
    
    override func viewDidLoad() {

        super.viewDidLoad()

        SidemenuManager.sharedInstance.setupData()
        
        sidemenuTableView.register(UINib(nibName: String(describing: LeftProfileTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LeftProfileTableViewCell.self))
        
        sidemenuTableView.register(UINib(nibName: String(describing: LeftMenuItemTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LeftMenuItemTableViewCell.self))
        
        sidemenuTableView.register(UINib(nibName: String(describing: LeftMenuInfoTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LeftMenuInfoTableViewCell.self))
    
        NotificationCenter.default.addObserver(self, selector: #selector(self.profileUpdateNotification(notification:)), name: Notification.Name("ProfileUpdated"), object: nil)
        
        fetchAppStats()
    }
    
    func fetchAppStats() {
        APIManager.sharedInstance.defaultManager.webserviceForDefaultPaginationResultWith(serviceType:.GetService, params: ["": ""], serviceName: GET_VISITORCOUNT, success: { (responseObject) in
            
            if let mobData = responseObject["data"].dictionaryObject{
                
                let numberOfCompanies = mobData["numberOfCompanies"] as! Int
                let numberOfDeals = mobData["numberOfDeals"] as! Int
                
                Constants.USER_DEFAULTS.set(numberOfCompanies, forKey: Constants.keyForSideMenuTotalCompaniesCount)
                Constants.USER_DEFAULTS.set(numberOfDeals, forKey: Constants.keyForSideMenuTotalDealsCount)
                
                self.sidemenuTableView.reloadData()
            }
        }) { (error) in
        }
    }
    
    @objc func profileUpdateNotification(notification: Notification) {
//        self.sidemenuTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: UITableViewRowAnimation.automatic)
        self.sidemenuTableView.reloadData()
    }
}


extension LeftViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            // profile cell
            return 100.0
        }
        else if indexPath.row <= SidemenuManager.sharedInstance.arrayTitle.count
        {
            // Item cell
            return 44.0
        }
        // Bottom/Footer info view
        return 220.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var itemsCount = 1 // profile cell
        itemsCount += SidemenuManager.sharedInstance.arrayTitle.count
        itemsCount += 1 // footer cell
        
        return itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.row == 0{
            // Profile cell
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LeftProfileTableViewCell.self), for: indexPath) as! LeftProfileTableViewCell
            
            let selectedCellBackgroundView = UIView()
            selectedCellBackgroundView.backgroundColor = UIColor.clear
            cell.selectedBackgroundView = selectedCellBackgroundView

   
                cell.userTypeLabel.isHidden = false
                cell.profileName.text = "Muhammad Umar"
                cell.userTypeLabel.text = "Software Engineer"
            
            
//            if let userImage = AppStateManager.sharedInstance.loggedInUser.imageUrl{
//                let url = URL(string: userImage)
//                let image = UIImage(named: "sideMenuProfilePlaceholder")
//                cell.profileImg.kf.setImage(with: url, placeholder: image, options: [.forceRefresh, .keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
//            }
            
            return cell
        }
        else if indexPath.row <= SidemenuManager.sharedInstance.arrayTitle.count
        {
            let row = indexPath.row - 1

            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LeftMenuItemTableViewCell.self), for: indexPath) as! LeftMenuItemTableViewCell
 
            cell.labelTitle.text = SidemenuManager.sharedInstance.arrayTitle[row]
            cell.imageSidebarIcon.image = UIImage(named: SidemenuManager.sharedInstance.arrayImages[row])
            
            let selectedCellBackgroundView = UIView()
            selectedCellBackgroundView.backgroundColor = Utility.hexStringToUIColor(hex: "#0F694A")
            cell.selectedBackgroundView = selectedCellBackgroundView
            
            return cell

        }
        else
        {
            // Footer cell
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LeftMenuInfoTableViewCell.self), for: indexPath) as! LeftMenuInfoTableViewCell

            let selectedCellBackgroundView = UIView()
            selectedCellBackgroundView.backgroundColor = UIColor.clear
            cell.selectedBackgroundView = selectedCellBackgroundView

            cell.copyrightsLabel.text = "sidemenu.copyrightLabel".localized
            cell.companiesLabel.text = "sidemenu.totalCompanies".localized + String(Constants.USER_DEFAULTS.integer(forKey: Constants.keyForSideMenuTotalCompaniesCount))
            cell.dealsLabel.text = "sidemenu.totalDeals".localized + String(Constants.USER_DEFAULTS.integer(forKey: Constants.keyForSideMenuTotalDealsCount))

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.row == 0{
            // Profile cell
            openUserProfile()
        }
        else if indexPath.row <= SidemenuManager.sharedInstance.arrayTitle.count
        {
            let row = indexPath.row - 1
            SidemenuManager.sharedInstance.parentController = sideMenuController!
            SidemenuManager.sharedInstance.menuOptionClicked(atIndex: row, forLeftMenu: Singleton.sharedInstance.isEnglishLanguageSelected)
        }
        else
        {
            // Footer cell
        }
    }

    func openUserProfile() {

            let mainViewController = sideMenuController!
            let tabbarViewController = mainViewController.rootViewController as!UITabBarController
            tabbarViewController.selectedIndex = 2
            sideMenuController?.hideLeftView(animated: true, delay: 0.0, completionHandler: nil)
            sideMenuController?.hideRightView(animated: true, delay: 0.0, completionHandler: nil)
        
    }
    
}
