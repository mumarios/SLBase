//
//  EsaadConfiguration.swift
//  Esaad
//
//  Created by Faran Rasheed on 25/03/2019.
//  Copyright © 2019 Systems Ltd. All rights reserved.
//

import Foundation

enum buildType: String
{
    case development    = "development"
    case qa             = "qa"
    case staging        = "staging"
    case release        = "release"
    case localMachine   = "localMachine"
}

class EsaadConfiguration{
    
    static let shared = EsaadConfiguration()

    public var baseURL = ""
    public var authBaseURL = ""
    private var appBuildType: String?{
        return Bundle.main.object(forInfoDictionaryKey: "BuildType") as? String
    }
    
    private init() {
        
        if let _ = buildType.init(rawValue: self.appBuildType!)
        {
            self.setupProperties()
        }
    }
    
    private func setupProperties(){
        if let path = Bundle.main.path(forResource: appBuildType!, ofType: "plist") {
            let dictRoot = NSDictionary(contentsOfFile: path)
            if let dict = dictRoot {
                baseURL = dict["baseURL"] as! String
                authBaseURL = dict["authBaseURL"] as! String
            }
        }
    }
}

