//
// NetworkEngine.swift
// Classixs //
// Created by UMENIT on 14/12/18.
// Copyright © 2018 UMENIT. All rights reserved. //

import UIKit
import Alamofire
import SwiftHTTP

class NetworkEngine: NSObject {
    
    static let sharedInstance = NetworkEngine()
    
    func getRequestHandler(_ urlString: String,isBaseAuthorized: Bool!, completionHandler:@escaping (AnyObject?, NSError?, Int?)->()) ->() {
        #if DEBUG
        print("HTTP METHOD: GET")
        print("REQUEST URL : \(urlString)") #endif
        let headers = [
            "content-type": "application/json",
            "api_version": "1.1",
            "api_key": "b80bf030b63dce44916650ed59"
        ]
        //        if let token = UserDefaults.standard.object(forKey: "token") as? String { headers["authorization"] = token
        //        }
        
        Alamofire.request(
            URL(string: urlString)!,
            method: .get,
            parameters: nil, encoding: JSONEncoding.default, headers: headers) .validate(statusCode: 200..<600)
            .responseJSON { (response) -> Void in guard response.result.isSuccess else {
                print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                completionHandler(nil, response.result.error as NSError? ,response.response?.statusCode)
                
                return }
                guard let responseJSON = response.result.value as? [String: Any] else {
                    print("Invalid tag information received from the service")
                    completionHandler(nil, response.result.error as NSError?,response.response?.statusCode)
                    return }
                completionHandler(responseJSON as AnyObject, nil,response.response?.statusCode)
        } }
    
    func postRequestHandler(_ urlString: String,isBaseAuthorized: Bool!, params:Dictionary<String,AnyObject>,completionHandler:@escaping (AnyObject?, NSError?, Int?)->()) ->() {
        #if DEBUG
        print("HTTP METHOD: POST")
        print("REQUEST URL : \(urlString)")
        print("PARAMS : \(params)")
        #endif
//        let headers = [
//            "content-type": "application/json",
//            "api_version": "1.1",
//            "api_key": "b80bf030b63dce44916650ed59"
//        ]
        
        let headers = [
            "key": "]5642vcb546gfnbvb7r6ewc211365vhh34"
            ]
        
        
        
        
        //            if let token = UserDefaults.standard.object(forKey: kToken) as? String { headers["authorization"] = token
        //            }
        Alamofire.request(
            URL(string: urlString)!,
            method: .post,
            parameters: params, encoding: JSONEncoding.default, headers:
            headers)
            .validate(statusCode: 200..<600) .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    completionHandler(nil, response.result.error as
                        NSError? ,response.response?.statusCode)
                    return
                    
                }
                guard let responseJSON = response.result.value as? [String: Any] else {
                    print("Invalid tag information received from the service")
                    completionHandler(nil, response.result.error as NSError?,response.response?.statusCode)
                    return }
                completionHandler(responseJSON as AnyObject, nil,response.response?.statusCode)
        }
    }
    
    func patchRequestHandler(_ urlString: String,isBaseAuthorized: Bool!, params:Dictionary<String,AnyObject>, completionHandler:@escaping (AnyObject?, NSError?, Int?)->()) ->() {
        #if DEBUG
        print("HTTP METHOD: PATCH")
        print("REQUEST URL : \(urlString)")
        print("PARAMS : \(params)")
        #endif
        let headers = [
            "content-type": "application/json",
            "api_version": "1.1",
            "api_key": "b80bf030b63dce44916650ed59"
        ]
        //                if let token = UserDefaults.standard.object(forKey: kToken) as? String { headers["authorization"] = token
        //                }
        Alamofire.request(
            URL(string: urlString)!,
            method: .patch,
            parameters: params,encoding: JSONEncoding.default, headers:
            headers)
            .validate(statusCode: 200..<600)
            .responseJSON { (response) -> Void in guard response.result.isSuccess else {
                print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                completionHandler(nil, response.result.error as NSError? ,response.response?.statusCode)
                return }
                guard let responseJSON = response.result.value as? [String: Any] else {
                    print("Invalid tag information received from the service")

                    completionHandler(nil, response.result.error as NSError?,response.response?.statusCode)
                    return }
                completionHandler(responseJSON as AnyObject, nil,response.response?.statusCode)
        } }
    func deleteRequestHandler(_ urlString: String,isBaseAuthorized: Bool!, completionHandler:@escaping (AnyObject?, NSError?, Int?)->()) ->() {
        #if DEBUG
        print("HTTP METHOD: DELETE")
        print("REQUEST URL : \(urlString)") #endif
        let headers = [
            "content-type": "application/json",
            "api_version": "1.1",
            "api_key": "b80bf030b63dce44916650ed59"
        ]
        //        if let token = UserDefaults.standard.object(forKey: kToken) as? String { headers["authorization"] = token
        //        }
        Alamofire.request(
            URL(string: urlString)!,
            method: .delete,
            parameters: nil,encoding: JSONEncoding.default, headers: headers)

            .validate(statusCode: 200..<600) .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    completionHandler(nil, response.result.error as
                        NSError? ,response.response?.statusCode)
                    return

                }
                guard let responseJSON = response.result.value as? [String: Any] else {
                    print("Invalid tag information received from the service")
                    completionHandler(nil, response.result.error as NSError?,response.response?.statusCode)
                    return }
                completionHandler(responseJSON as AnyObject, nil,response.response?.statusCode)
        } }
    func multipartPostRequestHandler(_ urlString: String, isBaseAuthorized: Bool!, params:Dictionary<String,AnyObject>, fileData : Data?, completionHandler:@escaping (AnyObject?, NSError?, Int?)->()) ->() {
        #if DEBUG
        print("HTTP METHOD: POST")
        print("REQUEST URL : \(urlString)")
        print("PARAMS : \(params)")
        #endif
        let headers = [
            "content-type": "application/json",
            "api_version": "1.1",
            "api_key": "b80bf030b63dce44916650ed59"
        ]
        //        if let token = UserDefaults.standard.object(forKey: kToken) as? String { headers["authorization"] = token
        //        }
        Alamofire.upload(multipartFormData: { multipart in
            if fileData != nil {
                multipart.append(fileData!, withName: "uploadImage", fileName:

                    "userIamge\(arc4random_uniform(9)).jpg", mimeType: "image/jpeg") }
            for (key, value) in params {
                multipart.append(value.data(using: String.Encoding.utf8.rawValue)!,
                                 withName: key) }
            print(multipart)
        }, to: urlString, method: .post, headers: headers) { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload
                    .validate(statusCode: 200..<600) .responseJSON { (response) -> Void in
                        print(response)
                        guard response.result.isSuccess else {
                            print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                            completionHandler(nil, response.result.error as NSError? ,response.response?.statusCode)
                            return }
                        guard let responseJSON = response.result.value as? [String:
                            Any] else {
                                print("Invalid tag information received from the service")
                                completionHandler(nil, response.result.error as NSError?,response.response?.statusCode)
                                return }
                        completionHandler(responseJSON as AnyObject, nil,response.response?.statusCode)
                }
            case .failure(let encodingError):
                print("encodingError: \(encodingError)")
                completionHandler(nil, encodingError as NSError? ,nil) }
        }
    }
    
}


