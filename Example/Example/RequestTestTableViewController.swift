//
//  RequestTestTableViewController.swift
//  Dotzu
//
//  Created by Remi Robert on 02/02/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import Dotzu

class RequestTestTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func makeRequest(url: String) {
        guard let url = URL(string: url) else {return}
        URLSession.shared.dataTask(with: url) { _, response, _ in
            Logger.info("response for url : [\(url)] : \(response)")
        }.resume()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            makeRequest(url: "http://httpbin.org/headers")
        case 1:
            makeRequest(url: "http://httpbin.org/status/404")
        case 2:
            makeRequest(url: "http://httpbin.org/status/500")
        default: break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
