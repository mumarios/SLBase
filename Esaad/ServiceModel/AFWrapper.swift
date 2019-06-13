//
//  AFWrapper.swift
//  MediaVoir
//
//  Created by Faraz Haider on 05/11/2016.
//  Copyright © 2016 OutreachGlobal. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

class AFWrapper: NSObject {
    
    class func requestGETURL(_ strURL: String,_ parameters:Parameters, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {

        
        Alamofire.request(strURL,parameters: parameters).responseJSON { (responseObject) -> Void in
            
            print(responseObject.request ?? "")
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    class func requestGETURLWithHeader(_ strURL: String,_ parameters:Parameters?,_ headers:[String:String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
    
        Alamofire.request(strURL,parameters: parameters,headers: headers).responseJSON { (responseObject) -> Void in
            
            print(responseObject.request ?? "")

            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    
    class func requestPOSTURL(_ strURL : String, params : Parameters, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        
        Alamofire.request(strURL, method: .post, parameters: params,headers: headers).responseJSON { (responseObject) -> Void in
            
            print(responseObject.request ?? "")

            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
                print(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    class func requestGetInBackground(_ strURL : String, params : Parameters, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        
        
        let queue = DispatchQueue.global(qos: .background)
        
        Alamofire.request(strURL,parameters: params,headers: headers).responseJSON(queue: queue) { (responseObject) -> Void in
            
            print(responseObject.request ?? "")
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
                
            }
            
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
        
    }
    
    
    
    class func requestPOSTWithSingleImage(_ strURL : String, parameters : Parameters,headers : [String : String]?,dataImage : [String:Any] ,  success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
    
        let imageValue = dataImage["value"] as! UIImage?
        let imageKey = dataImage["key"] as! String?
        let URLSTR = try! URLRequest(url: strURL, method:.post,headers:headers)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            // code
            
            if(imageValue != nil) {
                let imageData = UIImagePNGRepresentation(imageValue!)
                multipartFormData.append(imageData!, withName: imageKey!, fileName: "image.png", mimeType: "image/png")
            }
            for (key, value) in parameters {
                //multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                
                print(key)
                print(value)
                
                if value is Int {
                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                }else{
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }

            }
        },
                         with: URLSTR, encodingCompletion: { (result) in
                            switch result {
                            case .success(let upload, _, _):
                                upload.responseString { responseObject in
                                    if responseObject.result.isSuccess {
                                        
                                        if let data = (responseObject.result.value! as NSString).data(using: String.Encoding.utf8.rawValue) {
                                            let json = try? JSON(data: data)
                                            print(json!)
                                            success(json!)
                                        }
                                        
                                    }
                                    if responseObject.result.isFailure {
                                        let error : Error = responseObject.result.error!
                                        failure(error)
                                    }
                                    
                                }
                                
                            case .failure(let encodingError):
                                print(encodingError)
                            }
        })
        
        
        
    }
    
}
