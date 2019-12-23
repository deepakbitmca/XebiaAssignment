//
//  ConnectionManager.swift
//  SwiftFoundationApp
//
//  Created by Deepak Kumar on 23/08/17.
//  Copyright © 2017 Deepak Kumar. All rights reserved.
//

import UIKit

class ConnectionManager: NSObject {
    
    var urlString : String = ""
    
    typealias CompletionHandlerSuccessArray = (_ array:NSArray?, _ status:Bool) -> Void
    typealias CompletionHandlerSuccess = (_ dictionary:NSDictionary?, _ status:Bool) -> Void
    typealias CompletionHandlerSuccessString = (_ dictionary:NSString?, _ status:Bool) -> Void
    typealias CompletionHandlerFaliour = (_ errorMessage:NSString?, _ status:Bool) -> Void
    
    class var sharedInstance :ConnectionManager {
        struct Singleton {
            static let instance = ConnectionManager()
        }
        return Singleton.instance
    }
    
    func getDataRequest(inputParameter: String, serviceName: String,httpMethod: String, dataPost: NSData?, completionHandler: @escaping CompletionHandlerSuccess, faliour: @escaping CompletionHandlerFaliour) {
        
        let urlStringComplete = urlString + serviceName + inputParameter
        let url_to_request : String = urlStringComplete
        let url:NSURL = NSURL(string: url_to_request)!
        let request = NSMutableURLRequest(url: url as URL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.httpMethod = httpMethod
        request.httpBody = dataPost as Data?
        request.timeoutInterval = 600.0
        
        let session = URLSession.shared
        let task : URLSessionDataTask = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                faliour(error?.localizedDescription as NSString?,false)
                return
            }
            do {
                let responseDictionary : NSDictionary? = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                let responseStr = responseDictionary?.value(forKey: "status") as! String
                print(responseStr)
                if (responseStr ==  "OK") {
                    completionHandler(responseDictionary! as NSDictionary , true)
                }
                else {
                    let errorMessageString = responseDictionary?.value(forKey: "status") as! NSString
                    faliour(errorMessageString,false)
                    return
                }
            }
            catch {
                faliour(error.localizedDescription as NSString?,false)
                return
            }
            
        });
        task.resume()
    }
    
}
