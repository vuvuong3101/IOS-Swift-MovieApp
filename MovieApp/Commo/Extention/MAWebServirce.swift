//
//  BCAWebservice.swift
//  BCAInvestment
//
//  Created by PhucNguyen on 11/24/17.
//  Copyright © 2017 PhucNguyen. All rights reserved.
//

import UIKit
import Foundation
import AFNetworking

typealias ServerResponseHandler = (_ success:Bool, _ response:MABaseModel?) -> Void;

final class MAWebServirce: NSObject {
    
    static let shareInstance = MAWebServirce()
    let requestManager: AFHTTPSessionManager
    
    override init() {
        
        let securityPolicy:AFSecurityPolicy = AFSecurityPolicy();
        securityPolicy.allowInvalidCertificates = true
        securityPolicy.validatesDomainName = false;
        self.requestManager = AFHTTPSessionManager()
        self.requestManager.securityPolicy = securityPolicy
        
        let requestSerializer = AFJSONRequestSerializer()
        requestSerializer.stringEncoding = String.Encoding.utf8.rawValue
        self.requestManager.requestSerializer = requestSerializer
        self.requestManager.responseSerializer = AFJSONResponseSerializer()
        self.requestManager.requestSerializer.timeoutInterval = TimeInterval(60)
        
        if let contentType = self.requestManager.responseSerializer.acceptableContentTypes {
            let set = NSMutableSet(set: contentType)
            set.add("application/json")
            set.add("text/html")
            
            let setobj  = NSSet(set: set)
            self.requestManager.responseSerializer.acceptableContentTypes = setobj as? Set<String>
        }
    }
    
    func sendGETRequest(path:String,
                        params:NSDictionary?,
                        headers:NSDictionary?,
                        responseObjectClass:MABaseModel?,
                        responseHandler:@escaping ServerResponseHandler) {
        
        let allKeys = headers?.allKeys as? [String] ?? []
        
        for key in allKeys {
            let value = headers?.object(forKey: key)
            self.requestManager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key)
        }
        
        self.requestManager.get(path, parameters: params, progress: nil, success: {(task, responseObject) in
            
            guard let response = responseObject as? NSDictionary else {
                responseHandler(false, nil);
                return
            }
            responseObjectClass?.paserResponse(dic: response)
            responseHandler(true, responseObjectClass);
            
        }, failure: { (task, responseOBJ) in
            responseHandler(false, nil);
        })
    }
    
    func sendPOSTRequest (path:String,
                          params:NSDictionary?,
                          headers:NSDictionary?,
                          responseObjectClass:MABaseModel,
                          responseHandler:@escaping ServerResponseHandler) {
        
        let allKeys = headers?.allKeys as? [String] ?? []
        
        for key in allKeys {
            let value = headers?.object(forKey: key)
            self.requestManager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key)
        }
        
        self.requestManager.post(path, parameters:params , progress: nil, success: {(task, responseObject) in
            
            guard let response = responseObject as? NSDictionary else {
                responseHandler(false, nil);
                return
            }
            
            responseObjectClass.paserResponse(dic: response)
            responseHandler(true, responseObjectClass);
        }, failure: { (task, responseOBJ) in
            
            responseHandler(false, nil);
        })
        
    }
    
    func sendMultiPartFile(path: String,
                           params:NSDictionary?,
                           headers:NSDictionary?,
                           fileData: Data,
                           fileName: String,
                           responseObjectClass:MABaseModel,
                           responseHandler:@escaping ServerResponseHandler) {
        
        let allKeys = headers?.allKeys as? [String] ?? []
        
        for key in allKeys {
            let value = headers?.object(forKey: key)
            self.requestManager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key)
        }
        
        self.requestManager.post(path, parameters: params, constructingBodyWith: { (data: AFMultipartFormData) in
            
            data.appendPart(withFileData: fileData, name: "", fileName: fileName, mimeType: "image/*")
        }, progress: nil,success: {(task, responseObject) in
            
            guard let response = responseObject as? NSDictionary else {
                responseHandler(false, nil);
                return
            }
            
            responseObjectClass.paserResponse(dic: response)
            responseHandler(true, responseObjectClass);
            
        }, failure: { (task, responseOBJ) in
            
            responseHandler(false, nil);
        })
    }
    
    
    private func convertParamsToJson(params:NSDictionary) -> String {
        
        do {
            if let data:NSData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted) as NSData? {
                if let jsonString = String.init(data: data as Data, encoding: String.Encoding.utf8) {
                    return jsonString
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return ""
    }
}

