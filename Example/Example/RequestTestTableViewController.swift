//
//  RequestTestTableViewController.swift
//  Dotzu
//
//  Created by Remi Robert on 02/02/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import Dotzu
import Alamofire
import Dotzu

class RequestTestTableViewController: UITableViewController {

    @IBOutlet weak var segmentNetwork: UISegmentedControl!
    var task: URLSessionDataTask?
    var session: URLSession!
    var sessionManager: SessionManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        let configuration = URLSessionConfiguration.default
        Dotzu.sharedManager.addLogger(session: configuration)
        session = URLSession(configuration: configuration)
    }

    private func makeRequest(url: String) {
        if segmentNetwork.selectedSegmentIndex == 1 {
            guard let url = URL(string: url) else {return}
            task?.cancel()
            let request = NSMutableURLRequest(url: url)
            request.setValue(UUID().uuidString, forHTTPHeaderField: "UUID")
            request.setValue("\(Date().timeIntervalSinceNow)", forHTTPHeaderField: "date")
            task = session.dataTask(with: request as URLRequest, completionHandler: { _, response, error in
                Logger.info("response for url : [\(url)] : \(response)")
            })
            task?.resume()
        } else {
            let configuration = URLSessionConfiguration.default
            Dotzu.sharedManager.addLogger(session: configuration)
            sessionManager = Alamofire.SessionManager(configuration: configuration)
            let hedears = ["UUID": UUID().uuidString] as HTTPHeaders
            sessionManager.request(url, headers: hedears).responseJSON { response in
                Logger.info("response for url : [\(url)] : \(response)")
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                makeRequest(url: "http://httpbin.org/headers")
            case 1:
                makeRequest(url: "http://httpbin.org/status/404")
            case 2:
                makeRequest(url: "http://httpbin.org/status/500")
            default: break
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
