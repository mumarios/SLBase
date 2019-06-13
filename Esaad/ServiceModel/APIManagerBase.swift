

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage
import MOLH

class APIManagerBase: NSObject {
    
    let baseURL = BASE_URL
    let defaultRequestHeader = ["Content-Type": "application/json"]
    let defaultError = NSError(domain: "Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Request Failed."])
    
    
    func getAuthorizationHeader () -> Dictionary<String,String>{
        
//        if let token = AppStateManager.sharedInstance.serverToken {
//            return ["Authorization":"bearer " + token,"Content-Type":"application/json; charset=utf-8", "Accept-Language":MOLHLanguage.currentAppleLanguage()]
//        }
        
        return ["Content-Type":"application/json; charset=utf-8", "Accept-Language":MOLHLanguage.currentAppleLanguage()]
    }
    
    func getErrorFromResponseData(data: Data) -> NSError? {
        do{
            let result = try JSONSerialization.jsonObject(with: data,options: JSONSerialization.ReadingOptions.mutableContainers) as? Array<Dictionary<String,AnyObject>>
            if let message = result?[0]["message"] as? String{
                let error = NSError(domain: "Error", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
                return error;
            }
        }catch{
            NSLog("Error: \(error)")
        }
        return nil
    }
    
    func URLforRoute(route: String,params:[String: String]) -> NSURL? {
        
        if let components: NSURLComponents  = NSURLComponents(string: (BASE_URL+route)){
            var queryItems = [NSURLQueryItem]()
            for(key,value) in params{
                queryItems.append(NSURLQueryItem(name:key,value: value))
            }
            components.queryItems = queryItems as [URLQueryItem]?
            
            return components.url as NSURL?
        }
        return nil;
    }
    
    func POSTURLforRoute(route:String) -> URL?{
        var baseUrl = BASE_URL
        if route == LOGIN{
            baseUrl = BASE_URL_FOR_USER_AUTHENTICATION
        }
        
        if let components: NSURLComponents = NSURLComponents(string: (baseUrl+route)){
            return components.url! as URL
        }
        return nil
    }
    
    func GETURLfor(route:String) -> URL?{
        
        if let components: NSURLComponents = NSURLComponents(string: (BASE_URL+route)){
            return components.url! as URL
        }
        return nil
    }
    
    func postRequestWithMultipartForCreateRequest(route: URL,parameters: Parameters, images: [UIImage],
                                                  success:@escaping DefaultAPISuccessClosure,
                                                  failure:@escaping DefaultAPIFailureClosure){
        Alamofire.upload (
            multipartFormData: { multipartFormData in
                for (key , value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: key)
                }
                for item in images {
                    let image = UIImageJPEGRepresentation(item, 0.2)
                    if let data:Data = image {
                        multipartFormData.append(data, withName: "images[]", fileName: "fileName.jpg", mimeType: data.mimeType)
                    }
                }
                
        },
            to: route,
            encodingCompletion: { result in
                switch result {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        self.responseResultForArray(response, success: {result in
                            
                            success(result as! Dictionary<String, AnyObject>)
                        }, failure: {error in
                            
                            failure(error)
                        })
                    }
                case .failure(let encodingError):
                    failure(encodingError as NSError)
                }
        }
        )
    }
    
    func postRequestWithMultipart(route: URL,parameters: Parameters,
                                  success:@escaping DefaultAPISuccessClosure,
                                  failure:@escaping DefaultAPIFailureClosure){
        
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            for (key , value) in parameters
            {
                if let data:Data = value as? Data {
                    multipartFormData.append(data, withName: key, fileName: "userImage", mimeType: "image/jpeg")
                } else {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: key)
                }
            }
            
        }, to: route, method: .post, headers: getAuthorizationHeader(),
           encodingCompletion: { result in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    self.responseResultForDictionary(response, success: {response in
                        
                        success(response as! Dictionary<String, AnyObject>)
                    }, failure: {error in
                        
                        failure(error)
                    })
                }
            case .failure(let encodingError):
                failure(encodingError as NSError)
            }
        }
        )
        
        
        
//        Alamofire.upload (
//            multipartFormData: { multipartFormData in
//                for (key , value) in parameters {
//                    if let data:Data = value as? Data {
//                        multipartFormData.append(data, withName: key, fileName: "fileName.jpeg", mimeType: "image/jpeg")
//                    } else {
//                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: key)
//                    }
//                }
//
//        },
//            to: route,
//            encodingCompletion: { result in
//                switch result {
//                case .success(let upload, _, _):
//                    upload.responseJSON { response in
//                        self.responseResultForArray(response, success: {result in
//
//                            success(result as! Dictionary<String, AnyObject>)
//                        }, failure: {error in
//
//                            failure(error)
//                        })
//                    }
//                case .failure(let encodingError):
//                    failure(encodingError as NSError)
//                }
//        }
//        )
    }
    
    func postRequestWith(route: URL,parameters: Parameters,
                         success:@escaping DefaultAPISuccessClosure,
                         failure:@escaping DefaultAPIFailureClosure, withHeaders:Bool){
        
        if withHeaders {
            Alamofire.request(route, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: getAuthorizationHeader()).responseJSON{
                response in
                
                self.responseResultForDictionary(response, success: {response in
                    
                    success(response as! Dictionary<String, AnyObject>)
                }, failure: {error in
                    
                    failure(error as NSError)
                })
            }
        }else {
            Alamofire.request(route, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON{
                response in
                
                self.responseResultForDictionary(response, success: {response in
                    
                    success(response as! Dictionary<String, AnyObject>)
                }, failure: {error in
                    
                    failure(error as NSError)
                })
            }
        }
    }
    
    
    func patchRequestWith(route: URL,parameters: Parameters,
                         success:@escaping DefaultAPISuccessClosure,
                         failure:@escaping DefaultAPIFailureClosure, withHeaders:Bool){
        
        if withHeaders {
            Alamofire.request(route, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: getAuthorizationHeader()).responseJSON{
                response in
                
                self.responseResultForDictionary(response, success: {response in
                    
                    success(response as! Dictionary<String, AnyObject>)
                }, failure: {error in
                    
                    failure(error as NSError)
                })
            }
        }else {
            Alamofire.request(route, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON{
                response in
                
                self.responseResultForDictionary(response, success: {response in
                    
                    success(response as! Dictionary<String, AnyObject>)
                }, failure: {error in
                    
                    failure(error as NSError)
                })
            }
        }
    }
    
    func postRequestArrayWith(route: URL,parameters: Parameters,
                         success:@escaping DefaultArrayResultAPISuccessClosure,
                         failure:@escaping DefaultAPIFailureClosure, withHeaders:Bool){
        
        if withHeaders {
            Alamofire.request(route, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: getAuthorizationHeader()).responseJSON{
                response in
                
                self.responseResultForArray(response, success: {response in
                    
                    success(response as! (Array<AnyObject>))
                }, failure: {error in
                    
                    failure(error as NSError)
                })
            }
        }else {
            Alamofire.request(route, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON{
                response in
                
                self.responseResultForArray(response, success: {response in
                    
                    success(response as! (Array<AnyObject>))
                }, failure: {error in
                    
                    failure(error as NSError)
                })
            }
        }
    }
    
    
    func getRequestWith(route: URL,parameters: Parameters,
                        success:@escaping DefaultAPISuccessClosure,
                        failure:@escaping DefaultAPIFailureClosure){
        
        Alamofire.request(route, method: .get, parameters: parameters).responseJSON{
            response in
            self.responseResultForDictionary(response, success: {response in
                
                success(response as! Dictionary<String, AnyObject>)
            }, failure: {error in
                
                failure(error as NSError)
            })
            
            
        }
    }
    
    func getRequestWithNSCoding(route: URL,parameters: Parameters,
                        success:@escaping NSCodingSuccessResponse,
                        failure:@escaping DefaultAPIFailureClosure){
        
        Alamofire.request(route, method: .get, parameters: parameters).responseJSON{
            response in
            self.responseResultForDictionary(response, success: {NewResponse in

                success(response)
            }, failure: {error in
                
                failure(error as NSError)
            })
            
            
        }
    }
    
    
    func getArrayRequestWithNSCoding(route: URL,parameters: Parameters,
                                success:@escaping NSCodingSuccessResponse,
                                failure:@escaping DefaultAPIFailureClosure){
        
        Alamofire.request(route, method: .get, parameters: parameters).responseJSON{
            response in
            
            self.responseResultForJSONArray(response, success: {NewResponse in
                
                success(response)
            }, failure: {error in
                
                failure(error as NSError)
            })
            
            
            
        }
    }
    
    
    
    func postRequestWithNSCoding(route: URL,parameters: Parameters,
                                success:@escaping NSCodingSuccessResponse,
                                failure:@escaping DefaultAPIFailureClosure){
        
       
        Alamofire.request(route, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON{
            response in
            self.responseResultForJSONArray(response, success: {NewResponse in
                
                success(response)
            }, failure: {error in
                
                failure(error as NSError)
            })
            
            
        }
    }
    
    func postDataWithNSCodingRequest(route: URL,parameters: Parameters,
                                 success:@escaping NSCodingSuccessResponse,
                                 failure:@escaping DefaultAPIFailureClosure){
        
        Alamofire.request(route, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON{
            response in
            
            self.responseResultForDictionaryWithPagination(response, success: {NewResponse in
                
                success(response)
            }, failure: {error in
                
                failure(error as NSError)
            })
            
            
        }
    }
    
    func patchDataWithNSCodingRequest(route: URL,parameters: Parameters,
                                     success:@escaping NSCodingSuccessResponse,
                                     failure:@escaping DefaultAPIFailureClosure){
        
        Alamofire.request(route, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON{
            response in
            
            self.responseResultForDictionaryWithPagination(response, success: {NewResponse in
                
                success(response)
            }, failure: {error in
                
                failure(error as NSError)
            })
            
            
        }
    }
    

    func getRequestWithPagination(route: URL,parameters: Parameters, withHeaders:Bool,
                        success:@escaping DefaultAPISuccessClosureForPagination,
                        failure:@escaping DefaultAPIFailureClosure){
        
        if !withHeaders{
            Alamofire.request(route, method: .get, parameters: parameters).responseJSON{
                response in
                self.responseResultForDictionaryWithPagination(response, success: {response in
                    
                    success(response as JSON)
                }, failure: {error in
                    
                    failure(error as NSError)
                })
                
                
            }
        }else{
            Alamofire.request(route, method: .get, parameters: parameters, headers: getAuthorizationHeader()).responseJSON{
                response in
                self.responseResultForDictionaryWithPagination(response, success: {response in
                    
                    success(response as JSON)
                }, failure: {error in
                    
                    failure(error as NSError)
                })
                
                
            }
        }
    }
    
    
    func postRequestWithPagination(route: URL,parameters: Parameters,
                         success:@escaping DefaultAPISuccessClosureForPagination,
                         failure:@escaping DefaultAPIFailureClosure){

        Alamofire.request(route, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON{
            response in
            
            self.responseResultForDictionaryWithPagination(response, success: {response in
                
                success(response as JSON)
            }, failure: {error in
                
                failure(error as NSError)
            })
        }
    }
    
    
    
    func getRequestArrayWith(route: URL,parameters: Parameters, withHeaders:Bool,
                             success:@escaping DefaultArrayResultAPISuccessClosure,
                             failure:@escaping DefaultAPIFailureClosure) {
        
        if withHeaders{
            
            Alamofire.request(route, method: .get, parameters: parameters, headers: getAuthorizationHeader()).responseJSON{
                response in
                self.responseResultForArray(response, success: { response in
                    success(response as! (Array<AnyObject>))
                }, failure: {error in
                    failure(error as NSError)
                })
            }
            
        }else{
            Alamofire.request(route, method: .get, parameters: parameters).responseJSON{
                response in
                self.responseResultForArray(response, success: { response in
                    success(response as! (Array<AnyObject>))
                }, failure: {error in
                    failure(error as NSError)
                })
            }
        }
    }
    
    func getRequestArrayWithTemp(route: URL,parameters: Parameters,
                                 success:@escaping DefaultArrayResultAPISuccessClosure,
                                 failure:@escaping DefaultAPIFailureClosure) {
        Alamofire.request(route, method: .get, parameters: parameters).responseJSON{
            response in
            self.responseResultForArray(response, success: { response in
                success(response as! (Array<AnyObject>))
            }, failure: {error in
                failure(error as NSError)
            })
        }
    }
    func putRequestWith(route: URL,parameters: Parameters,
                        success:@escaping DefaultAPISuccessClosure,
                        failure:@escaping DefaultAPIFailureClosure){
        
        Alamofire.request(route, method: .put, parameters: parameters, encoding: JSONEncoding.default).responseJSON{
            response in
            
            self.responseResultForArray(response, success: {response in
                
                success(response as! Dictionary<String, AnyObject>)
            }, failure: {error in
                
                failure(error as NSError)
            })
        }
    }
    
    func deleteRequestWith(route: URL,parameters: Parameters,
                           success:@escaping DefaultAPISuccessClosure,
                           failure:@escaping DefaultAPIFailureClosure){
        
        Alamofire.request(route, method: .delete, parameters: parameters, encoding: JSONEncoding.default).responseJSON{
            response in
            
            self.responseResultForArray(response, success: {response in
                
                success(response as! Dictionary<String, AnyObject>)
            }, failure: {error in
                
                failure(error as NSError)
            })
        }
    }
    func deleteRequestWithT(endPoint: String, success:@escaping DefaultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure) {
        Alamofire.request(endPoint, method: .delete, headers:getAuthorizationHeader())
            .responseJSON { response in
                self.responseResultForArray(response, success: {response in
                    
                    success(response as! Dictionary<String, AnyObject>)
                }, failure: {error in
                    
                    failure(error as NSError)
                })
        }
    }
    
    func downloadImageT(route: String, success:@escaping DefaultImageResultClosure) {
        Alamofire.request(route).responseImage { response in
            self.responseImage(response, success: success)
        }
    }
    fileprivate func responseImage(_ response: DataResponse<UIImage>, success: @escaping (_ response: UIImage) -> Void) {
        if let image = response.result.value {
            print(image)
            success(image)
        }
    }
    
    //MARK: - Response Handling
    
    fileprivate func responseResultForJSONArray(_ response:DataResponse<Any>,
                                            success: @escaping (_ response: AnyObject) -> Void,
                                            failure: @escaping (_ error: NSError) -> Void
        ) {
        switch response.result
        {
        case .success:
            
            if((response.result.value) != nil) {
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                
        
                if let messageData = swiftyJsonVar["message"].dictionaryObject {
                    let message:Message = Message(fromDictionary: messageData)
                    let code = message.code
                    if (code == "200") {
                     
                            success(swiftyJsonVar["mobData"] as AnyObject)
                       
                    }else {
                        //Failure
                        let errorMessage: String = message.message ?? "Unknown error";
                        let userInfo = [NSLocalizedFailureReasonErrorKey: errorMessage]
                        
                        let error = NSError(domain: "Domain", code: Int(code!)!, userInfo: userInfo)
                        failure(error)
                        //Utility.showAlert(title: "Alert", message: error.localizedFailureReason!)
                    }
                }else {
                    //Failure
                    let errorMessage: String = "Unknown error";
                    let userInfo = [NSLocalizedFailureReasonErrorKey: errorMessage]
                    let error = NSError(domain: "Domain", code: 0, userInfo: userInfo);
                    
                    failure(error)
                }
            }
            
        case .failure(let error):
            failure(error as NSError)
        }
    }
    
    
    fileprivate func responseResultForArray(_ response:DataResponse<Any>,
                                    success: @escaping (_ response: AnyObject) -> Void,
                                    failure: @escaping (_ error: NSError) -> Void
        ) {
        switch response.result
        {
        case .success:
            
            if((response.result.value) != nil) {
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                
                
                
                if let messageData = swiftyJsonVar["message"].dictionaryObject {
                    let message:Message = Message(fromDictionary: messageData)
                    let code = message.code
                    if (code == "200") {
                         if let mobData = swiftyJsonVar["mobData"].arrayObject
                        {
//                            let _:MobData = MobData(fromDictionary: mobData)
                            success(mobData as AnyObject)
//                            return
                        }
                        
                        else if let data = swiftyJsonVar["data"].arrayObject
                        {
                            //                            let _:MobData = MobData(fromDictionary: mobData)
                            success(data as AnyObject)
//                            return
                        }
                        
                            
                         else {
                            //Failure
                            let errorMessage: String = message.message ?? "Unknown error";
                            let userInfo = [NSLocalizedFailureReasonErrorKey: errorMessage]
                            
                            let error = NSError(domain: "Domain", code: Int(code!)!, userInfo: userInfo)
                            failure(error)
                            //Utility.showAlert(title: "Alert", message: error.localizedFailureReason!)
                        }
                    }else {
                        //Failure
                        let errorMessage: String = message.message ?? "Unknown error";
                        let userInfo = [NSLocalizedFailureReasonErrorKey: errorMessage]
                        
                        let error = NSError(domain: "Domain", code: Int(code!)!, userInfo: userInfo)
                        failure(error)
                        //Utility.showAlert(title: "Alert", message: error.localizedFailureReason!)
                    }
                }else {
                    //Failure
                    let errorMessage: String = "Unknown error";
                    let userInfo = [NSLocalizedFailureReasonErrorKey: errorMessage]
                    let error = NSError(domain: "Domain", code: 0, userInfo: userInfo);
                    
                    failure(error)
                }
            }
            
        case .failure(let error):
            failure(error as NSError)
        }
    }
            
            
    
    fileprivate func responseResultForDictionary(_ response:DataResponse<Any>,
                                            success: @escaping (_ response: AnyObject) -> Void,
                                            failure: @escaping (_ error: NSError) -> Void
        ) {
        switch response.result
        {
        case .success:
            
            if((response.result.value) != nil) {
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                
                if let messageData = swiftyJsonVar["message"].dictionaryObject {
                    let message:Message = Message(fromDictionary: messageData)
                    let code = message.code
                    if (code == "200") {
                        if let mobData = swiftyJsonVar["mobData"].dictionaryObject
                        {
                            //                            let _:MobData = MobData(fromDictionary: mobData)
                            success(mobData as AnyObject)
                        }else if let data = swiftyJsonVar["data"].dictionaryObject
                        {
                            //                            let _:MobData = MobData(fromDictionary: mobData)
                            success(data as AnyObject)
                        }
                        else {
                            //Failure
                            let errorMessage: String = message.message ?? "Unknown error";
                            let userInfo = [NSLocalizedFailureReasonErrorKey: errorMessage]
                            
                            let error = NSError(domain: "Domain", code: Int(code!)!, userInfo: userInfo)
                            failure(error)
                            //Utility.showAlert(title: "Alert", message: error.localizedFailureReason!)
                        }
                    }else {
                        //Failure
                        let errorMessage: String = message.message ?? "Unknown error";
                        let userInfo = [NSLocalizedFailureReasonErrorKey: errorMessage]
                        
                        let error = NSError(domain: "Domain", code: Int(code!)!, userInfo: userInfo)
                        failure(error)
                        //Utility.showAlert(title: "Alert", message: error.localizedFailureReason!)
                    }
                }else {
                    //Failure
                    let errorMessage: String = "Unknown error";
                    let userInfo = [NSLocalizedFailureReasonErrorKey: errorMessage]
                    let error = NSError(domain: "Domain", code: 0, userInfo: userInfo);
                    
                    failure(error)
                }
            }
            
        case .failure(let error):
            failure(error as NSError)
        }
    }
    
    
    fileprivate func responseResultForDictionaryWithPagination(_ response:DataResponse<Any>,
                                                 success: @escaping (_ response: JSON) -> Void,
                                                 failure: @escaping (_ error: NSError) -> Void
        ) {
        switch response.result
        {
        case .success:
            
            if((response.result.value) != nil) {
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                
                
                
                if let messageData = swiftyJsonVar["message"].dictionaryObject {
                    let message:Message = Message(fromDictionary: messageData)
                    let code = message.code
                    if (code == "200") {
                        
                        success(swiftyJsonVar as JSON)
//                        if let mobData = swiftyJsonVar["mobData"].dictionaryObject
//                        {
//                            //                            let _:MobData = MobData(fromDictionary: mobData)
//                            success(mobData as AnyObject)
//                        }
//                        else {
//                            //Failure
//                            let errorMessage: String = message.message ?? "Unknown error";
//                            let userInfo = [NSLocalizedFailureReasonErrorKey: errorMessage]
//
//                            let error = NSError(domain: "Domain", code: Int(code!)!, userInfo: userInfo)
//                            failure(error)
//                            //Utility.showAlert(title: "Alert", message: error.localizedFailureReason!)
//                        }
                    }else {
                        //Failure
                        let errorMessage: String = message.message ?? "Unknown error";
                        let userInfo = [NSLocalizedFailureReasonErrorKey: errorMessage]
                        
                        let error = NSError(domain: "Domain", code: Int(code!)!, userInfo: userInfo)
                        failure(error)
                        //Utility.showAlert(title: "Alert", message: error.localizedFailureReason!)
                    }
                }else {
                    //Failure
                    let errorMessage: String = "Unknown error";
                    let userInfo = [NSLocalizedFailureReasonErrorKey: errorMessage]
                    let error = NSError(domain: "Domain", code: 0, userInfo: userInfo);
                    
                    failure(error)
                }
            }
            
        case .failure(let error):
            failure(error as NSError)
        }
    }
    
           /* if let dictData = response.result.value as? NSDictionary {
                
                if let messageData = dictData["message"].dictionaryObject{
                    
                }
                let message:Message = Message(fromDictionary: dictData["message"])
                
                
                let code = message.code
                
                
                if (code == "200") {
                    //Success
                    
                if let dataResponse = dictData["data"]
                {
                   // let data:Datas = Datas(object: dataResponse)
                    success(dataResponse as AnyObject)
                }
                    
                    
                } else {
                    //Failure
                    let errorMessage: String = (dictData["Message"] as? String) ?? "Unknown error";
                    let userInfo = [NSLocalizedFailureReasonErrorKey: errorMessage]
                    
                    let error = NSError(domain: "Domain", code: (code as? Int)!, userInfo: userInfo)
                    failure(error)
                    //Utility.showAlert(title: "Alert", message: error.localizedFailureReason!)
                }
            } else {
                //Failure
                let errorMessage: String = "Unknown error";
                let userInfo = [NSLocalizedFailureReasonErrorKey: errorMessage]
                let error = NSError(domain: "Domain", code: 0, userInfo: userInfo);
                
                failure(error)
            }*/
            
      
    
    fileprivate func multipartFormData(parameters: Parameters) {
        let formData: MultipartFormData = MultipartFormData()
        if let params:[String:AnyObject] = parameters as [String : AnyObject]? {
            for (key , value) in params {
                
                if let data:Data = value as? Data {
                    formData.append(data, withName: key, fileName: "fileName", mimeType: data.mimeType)
                } else {
                    formData.append("\(value)".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: key)
                }
            }
        }
    }
}


public extension Data {
    public var mimeType:String {
        get {
            var c = [UInt32](repeating: 0, count: 1)
            (self as NSData).getBytes(&c, length: 1)
            switch (c[0]) {
            case 0xFF:
                return "image/jpeg";
            case 0x89:
                return "image/png";
            case 0x47:
                return "image/gif";
            case 0x49, 0x4D:
                return "image/tiff";
            case 0x25:
                return "application/pdf";
            case 0xD0:
                return "application/vnd";
            case 0x46:
                return "text/plain";
            default:
                print("mimeType for \(c[0]) in available");
                return "application/octet-stream";
            }
        }
    }
}
struct Message{
    
    var code : String!
    var message : String!
    var status : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        code = dictionary["code"] as? String
        message = dictionary["message"] as? String
        status = dictionary["status"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if code != nil{
            dictionary["code"] = code
        }
        if message != nil{
            dictionary["message"] = message
        }
        if status != nil{
            dictionary["status"] = status
        }
        return dictionary
    }
    
}
