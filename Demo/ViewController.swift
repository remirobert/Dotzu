//
//  ViewController.swift
//  DebugMan
//
//  Created by liman on 13/12/2017.
//  Copyright © 2017 liman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("hello world")
        print("hello world in red", .red)
        
        mockHTTP()
    }
    
    func mockHTTP() {
        
        //1.GET
        NetworkManager.sharedInstance().requestData(withURL: "https://httpbin.org/get", method: "GET", parameter: nil, header: nil, cookies: nil, timeoutInterval: 10, requestSerializer: RequestSerializer(rawValue: 0), responseSerializer: ResponseSerializer(rawValue: 0), result: { (responseObject) in
            
            //you can see logs in white color (default color)
            print(responseObject)
        }) { (error) in
            print(error?.localizedDescription)
        }
        
        //2.POST
        NetworkManager.sharedInstance().requestData(withURL: "https://httpbin.org/post", method: "POST", parameter: ["data": "hello world"], header: nil, cookies: nil, timeoutInterval: 10, requestSerializer: RequestSerializer(rawValue: 0), responseSerializer: ResponseSerializer(rawValue: 0), result: { (responseObject) in
            
            //you can see logs in blue color
            print(responseObject, .blue)
        }) { (error) in
            print(error?.localizedDescription)
        }
        
        //3.DELETE
        NetworkManager.sharedInstance().requestData(withURL: "https://httpbin.org/delete", method: "DELETE", parameter: nil, header: nil, cookies: nil, timeoutInterval: 10, requestSerializer: RequestSerializer(rawValue: 0), responseSerializer: ResponseSerializer(rawValue: 0), result: { (responseObject) in
            
            //you can see logs in red color
            print(responseObject, .red)
        }) { (error) in
            print(error?.localizedDescription)
        }
        
        //4.PUT
        NetworkManager.sharedInstance().requestData(withURL: "https://httpbin.org/put", method: "PUT", parameter: ["data": "hello world"], header: nil, cookies: nil, timeoutInterval: 10, requestSerializer: RequestSerializer(rawValue: 0), responseSerializer: ResponseSerializer(rawValue: 0), result: { (responseObject) in
            
            //you can see logs in purple color
            print(responseObject, .purple)
        }) { (error) in
            print(error?.localizedDescription)
        }
    }
}

