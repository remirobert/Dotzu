//
//  CrashTestTableViewController.swift
//  Dotzu
//
//  Created by Remi Robert on 02/02/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class CrashTestTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func crashSigbart() {
        let _ = (view as! UIButton).showsTouchWhenHighlighted
    }

    private func crashExecption() {
        self.delete(nil)
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            crashSigbart()
        case 1:
            crashExecption()
        default: break
        }
    }
}
