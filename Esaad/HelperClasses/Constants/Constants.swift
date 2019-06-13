//
//  Constants.swift
//  Template
//
//  Created by Muzamil Hassan on 02/01/2017.
//  Copyright © 2017 Muzamil Hassan. All rights reserved.
//
import UIKit
import Foundation


enum WidgetElement : String{
    case PhoneNumber = "phoneNumber"
    case Email       = "email"
    case Amount      = "amount"
    case Dropdown    = "dropdown"
    case DatePicker  = "datepicker"
    case Default     = "default"
}

enum DateFormats : String{
    case MM_dd_YYYY = "MM/dd/yyyy"
    case YYYY_MM_dd = "yyyy-MM-dd"
    case dd_MM_YYYY = "dd/MM/yyyy"
    case serverDefaultFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case MMM_DD_YYYY = "MMM dd, yyyy"
    case newUiDateFormat = "dd MMM yy"
    case dd_MMM_YY_H_M = "dd MMM yy | hh:mm a"
    
}

struct Constants{
    static let kEsaadColor                  = "#008952"
    static let kDefaultDateFormat           = DateFormats.newUiDateFormat.rawValue
    static let kEnablePrint                 = true
    static let kWINDOW_WIDTH                = UIScreen.main.bounds.size.width
    static let kWINDOW_HIEGHT               = UIScreen.main.bounds.size.height
    static let APP_DELEGATE                 = UIApplication.shared.delegate as! AppDelegate
    static let UIWINDOW                     = UIApplication.shared.delegate!.window!
    static let USER_DEFAULTS                = UserDefaults.standard
    static let SINGLETON                    = Singleton.sharedInstance
    static let mapZoomLevel: Float          = 12.0
    static let mapZoomLevelZoomed: Float    = 14.0
    static let maximumLengthNumber          = 20
    static let minimumLengthNumber          = 8
    static let maximumLengthText            = 30
    static let minimumLengthPwd             = 6
    static let maximumLengthPwd             = 20
    static let maximumEmpID                 = 10
    static let animationDurationForFav      = 0.6
    static let kDealIdsArrayUserDefaults    = "favDealIDs"
    static let defaultPageSize              = 12
    static let esaadOfflinePath             = "Esaad/OfflineData"
    static let dataJsonFileName             = "data.json"
    
    static let platform                     = "ios"

    static let userType_employee            = "Employee"
    static let userType_retailer            = "Retailer"
    
    static let serverUserType_employee      = "USER"
    static let serverUserType_retail        = "RETAIL_USER"

    
    // Keys to store image to be used for animation in deal details and news details.
    static let keyForNewsCellImage          = "keyForNewsCellImage"
    static let keyForNewDealCellImage       = "keyForNewDealCellImage"
    static let keyForFeaturedDealCellImage  = "keyForFeaturedDealCellImage"
    
    static let keyForSideMenuTotalCompaniesCount = "keyForSideMenuTotalCompaniesCount"
    static let keyForSideMenuTotalDealsCount = "keyForSideMenuTotalDealsCount"
}

struct Global{
    
    static let APP_THEME_COLOR               = Utility.hexStringToUIColor(hex: Constants.kEsaadColor)  // UIColor(red: 2/255, green: 88/255, blue: 68/255, alpha: 1.0)
    static let NavigationBarColor: UIColor   = .white
    static let NavigationBarFontColorHex     = "#383A3E"
    static let API_KEY_GOOGLE                = "AIzaSyApVnZJPvptZNGMTxZoB_MIK1R9rx_Ydy0"
}

struct OfflinePaths {
    
    static let News                         = urlWith(path: "/News")
    static let News_ar                      = urlWith(path: "/News_ar")
    
    static let Categories                         = urlWith(path: "/Categories")
    static let Categories_ar                      = urlWith(path: "/Categories_ar")
    
    static let DealList_All                         = urlWith(path: "/Categories")
    static let DealList_All_ar                      = urlWith(path: "/Categories_ar")
    
    static func urlWith(path: String) -> URL {
        return URL.createFolder(folderName: Constants.esaadOfflinePath + path)!.appendingPathComponent(Constants.dataJsonFileName)
    }
}
