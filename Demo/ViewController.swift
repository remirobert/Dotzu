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
        
        mockGET()
        mockDELETE()
        mockPOST()
        mockPUT()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        printColor("test color print").with(.red)
    }
    
    //MARK: - HTTP mock
    func mockGET() {
        NetworkManager.sharedInstance().requestData(withURL: "https://httpbin.org/get", method: "GET", parameter: nil, header: nil, cookies: nil, timeoutInterval: 10, requestSerializer: RequestSerializer(rawValue: 0), responseSerializer: ResponseSerializer(rawValue: 0), result: { (responseObject) in
            print(responseObject) //you can see the logs in DebugMan
        }) { (error) in
            print(error?.localizedDescription)
        }
    }
    
    func mockDELETE() {
        NetworkManager.sharedInstance().requestData(withURL: "https://httpbin.org/delete", method: "DELETE", parameter: nil, header: nil, cookies: nil, timeoutInterval: 10, requestSerializer: RequestSerializer(rawValue: 0), responseSerializer: ResponseSerializer(rawValue: 0), result: { (responseObject) in
            print(responseObject) //you can see the logs in DebugMan
        }) { (error) in
            print(error?.localizedDescription)
        }
    }
    
    func mockPOST() {
        NetworkManager.sharedInstance().requestData(withURL: "https://httpbin.org/post", method: "POST", parameter: ["data": "hello world"], header: nil, cookies: nil, timeoutInterval: 10, requestSerializer: RequestSerializer(rawValue: 0), responseSerializer: ResponseSerializer(rawValue: 0), result: { (responseObject) in
            print(responseObject) //you can see the logs in DebugMan
        }) { (error) in
            print(error?.localizedDescription)
        }
    }
    
    func mockPUT() {
        NetworkManager.sharedInstance().requestData(withURL: "https://httpbin.org/put", method: "PUT", parameter: ["data": "hello world"], header: nil, cookies: nil, timeoutInterval: 10, requestSerializer: RequestSerializer(rawValue: 0), responseSerializer: ResponseSerializer(rawValue: 0), result: { (responseObject) in
            print(responseObject) //you can see the logs in DebugMan
        }) { (error) in
            print(error?.localizedDescription)
        }
    }
}

