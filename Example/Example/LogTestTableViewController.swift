//
//  LogTestTableViewController.swift
//  Dotzu
//
//  Created by Remi Robert on 02/02/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import Dotzu

class LogTestTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let uuid = UUID().uuidString
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                Logger.verbose("UUID: \(uuid)")
            case 1:
                Logger.info("UUID: \(uuid)")
            case 2:
                Logger.warning("UUID: \(uuid)")
            case 3:
                Logger.error("UUID: \(uuid)")
            default: break
            }
        }
        else {
            switch indexPath.row {
            case 0:
                print("UUID: \(uuid)")
            default: break
            }
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
