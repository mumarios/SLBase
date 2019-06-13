//
//  DashboardAPIManager.swift
//  Esaad
//
//  Created by Faraz Haider on 10/3/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DashboardAPIManager: APIManagerBase {
    
    enum ServiceType {
        case GetService
        case PostService
        case PatchService
        case Multipart
    }
    
    //MARK: - Generic web service methods
    
    //MARK: -/DefaultArrayResultAPISuccessClosure
    func webserviceForDefaultArrayResultWith(serviceType: ServiceType, params: Parameters, serviceName: String, success: @escaping DefaultArrayResultAPISuccessClosure, failure: @escaping DefaultAPIFailureClosure)  {
        
        let route: URL = serviceType == .GetService ? GETURLfor(route: serviceName)! : POSTURLforRoute(route: serviceName)!
        
        print("----- \(route) ----- \(params)")
        
        if serviceType == .GetService {
            self.getRequestArrayWith(route: route, parameters: params, withHeaders: true, success: success, failure: failure)
        }
        else if serviceType == .PostService {
            self.postRequestArrayWith(route: route, parameters: params, success: success, failure: failure, withHeaders: true)
        }
    }
    
    //MARK: -/DefaultAPISuccessClosureForPagination
    func webserviceForDefaultPaginationResultWith(serviceType: ServiceType, params: Parameters, serviceName: String, success: @escaping DefaultAPISuccessClosureForPagination, failure: @escaping DefaultAPIFailureClosure)  {
        
        let route: URL = serviceType == .GetService ? GETURLfor(route: serviceName)! : POSTURLforRoute(route: serviceName)!
        
        print("----- \(route) ----- \(params)")
        
        if serviceType == .GetService {
            self.getRequestWithPagination(route: route, parameters: params, withHeaders: true, success: success, failure: failure)
        }
        else if serviceType == .PostService {
            self.postRequestWithPagination(route: route, parameters: params, success: success, failure: failure)
        }
        
    }
    
    //MARK: -/DefaultAPISuccessClosure
    func webserviceForDefaultResultWith(serviceType: ServiceType, params: Parameters, serviceName: String, success: @escaping DefaultAPISuccessClosure, failure: @escaping DefaultAPIFailureClosure)  {
        
        var route: URL = serviceType == .GetService ? GETURLfor(route: serviceName)! : POSTURLforRoute(route: serviceName)!
        
        if serviceType == .Multipart {
            route = POSTURLforRoute(route: serviceName)!
        }
        
        print("----- \(route) ----- \(params)")
        
        if serviceType == .GetService {
            self.getRequestWith(route: route, parameters: params, success: success, failure: failure)
        }
        else if serviceType == .PostService {
            self.postRequestWith(route: route, parameters: params, success: success, failure: failure, withHeaders: true)
        }
        else if serviceType == .Multipart {
            self.postRequestWithMultipart(route: route, parameters: params, success: success, failure: failure)
        }
        else if serviceType == .PatchService {
            self.patchRequestWith(route: route, parameters: params, success: success, failure: failure, withHeaders: true)
        }
    }
    
    //MARK: -/DefaultNSCodingSuccessResponse
    func webserviceForDefaultNSCodingResultWith(serviceType: ServiceType, params: Parameters, serviceName: String, success: @escaping NSCodingSuccessResponse, failure: @escaping DefaultAPIFailureClosure)  {
        
        let route: URL = (serviceType == .GetService || serviceType == .PatchService) ? GETURLfor(route: serviceName)! : POSTURLforRoute(route: serviceName)!
        
        print("----- \(route) ----- \(params)")
        
        if serviceType == .GetService{
            self.getRequestWithNSCoding(route: route, parameters: params, success: success, failure: failure)
        }
        else if serviceType == .PostService {
            self.postRequestWithNSCoding(route: route, parameters: params, success: success, failure: failure)
        }
        else if serviceType == .PatchService {
            self.patchDataWithNSCodingRequest(route: route, parameters: params, success: success, failure: failure)

        }
    }
    
    //MARK: -/DefaultNSCodingArraySuccessResponse
    func webserviceForDefaultNSCodingArrayResultWith(serviceType: ServiceType, params: Parameters, serviceName: String, success: @escaping NSCodingSuccessResponse, failure: @escaping DefaultAPIFailureClosure)  {
        
        let route: URL = (serviceType == .GetService || serviceType == .PatchService) ? GETURLfor(route: serviceName)! : POSTURLforRoute(route: serviceName)!
        
        print("----- \(route) ----- \(params)")
        if serviceType == .GetService{
            self.getArrayRequestWithNSCoding(route: route, parameters: params, success: success, failure: failure)
        }
    }
}
