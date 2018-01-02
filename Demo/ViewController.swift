//
//  ViewController.swift
//  DebugMan
//
//  Created by liman on 13/12/2017.
//  Copyright © 2017 liman. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //just for test...
        
        print("hello world")
        print("hello world in red", .red)
        
        Alamofire.request("https://httpbin.org/get").responseJSON { response in
            switch response.result {
            case .success:
                print(response)
            case .failure(let error):
                print(error, .red)
            }
        }
        
        Alamofire.request("https://httpbin.org/post", method: .post, parameters: ["data": "hello world"], encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print(response, .green)
            case .failure(let error):
                print(error, .red)
            }
        }
    }
}

