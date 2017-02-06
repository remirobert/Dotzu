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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func makeRequest(url: String) {
        if segmentNetwork.selectedSegmentIndex == 0 {
            guard let url = URL(string: url) else {return}
            URLSession.shared.dataTask(with: url) { _, response, _ in
                Logger.info("response for url : [\(url)] : \(response)")
                }.resume()
        } else {
            let configuration = URLSessionConfiguration.default
            Dotzu.sharedManager.addLogger(session: configuration)
            let sessionManager = Alamofire.SessionManager(configuration: configuration)

            sessionManager.request(url).responseJSON { response in
                Logger.info("response for url : [\(url)] : \(response)")
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                makeRequest(url: "http://httpbin.org/ip")
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
