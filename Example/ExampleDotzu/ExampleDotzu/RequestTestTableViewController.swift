//
//  RequestTestTableViewController.swift
//  Dotzu
//
//  Created by Remi Robert on 02/02/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import Dotzu
import Dotzu

class RequestTestTableViewController: UITableViewController {

    var tasks = [URLSessionDataTask]()
    var session: URLSession!

    override func viewDidLoad() {
        super.viewDidLoad()

        let configuration = URLSessionConfiguration.default
        Dotzu.sharedManager.addLogger(session: configuration)
        session = URLSession(configuration: configuration)
    }

    private func makePostRequest(url: String, data: String? = nil) {
        guard let url = URL(string: url) else {return}
        let request = NSMutableURLRequest(url: url)
        let parameters = ["username":"remi"]
        var data: Data?
        do {
            data = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch {
            return
        }
        request.httpBody = data
        request.httpMethod = "POST"
        let task = session.dataTask(with: request as URLRequest, completionHandler: { _, response, error in
            if let response = response {
                Logger.info("response for url : [\(url)] : \(response)")
            }
            if let error = error {
                Logger.error(error.localizedDescription)
            }
        })
        task.resume()
        tasks.append(task)
    }

    private func makeRequest(url: String) {
        guard let url = URL(string: url) else {return}
        let request = NSMutableURLRequest(url: url)
        request.setValue(UUID().uuidString, forHTTPHeaderField: "UUID")
        request.setValue("\(Date().timeIntervalSinceNow)", forHTTPHeaderField: "date")
        request.httpMethod = "GET"
        let task = session.dataTask(with: request as URLRequest, completionHandler: { _, response, error in
            if let response = response {
                Logger.info("response for url : [\(url)] : \(response)")
            }
            if let error = error {
                Logger.error(error.localizedDescription)
            }
        })
        task.resume()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                makeRequest(url: "http://httpbin.org/headers")
                makeRequest(url: "http://httpbin.org/headers")
                makeRequest(url: "http://httpbin.org/status/404")
            case 1:
                makeRequest(url: "http://httpbin.org/status/404")
            case 2:
                makeRequest(url: "http://httpbin.org/status/500")
            default: break
            }
        } else if indexPath.section == 1 {
            makePostRequest(url: "http://httpbin.org/post", data: "1")
            makePostRequest(url: "http://httpbin.org/post", data: "2")
            makePostRequest(url: "http://httpbin.org/post", data: "3")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
