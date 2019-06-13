
import UIKit
import SwiftyJSON
import Alamofire

typealias DefaultAPIFailureClosure = (NSError) -> Void
typealias DefaultAPISuccessClosure = (Dictionary<String,AnyObject>) -> Void
typealias NSCodingSuccessResponse  = (DataResponse<Any>) -> Void

typealias DefaultBoolResultAPISuccesClosure = (Bool) -> Void
typealias DefaultArrayResultAPISuccessClosure = (Array<AnyObject>) -> Void
typealias DefaultImageResultClosure = (UIImage) -> Void
typealias DefaultAPISuccessClosureForPagination = (JSON) -> Void

protocol APIErrorHandler {
    func handleErrorFromResponse(response: Dictionary<String,AnyObject>)
    func handleErrorFromERror(error:NSError)
}


class APIManager: NSObject {
    
    static let sharedInstance = APIManager()
    let defaultManager = DashboardAPIManager()
}

