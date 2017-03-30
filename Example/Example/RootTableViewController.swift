//
//  RootTableViewController.swift
//  Example
//
//  Created by Remi Robert on 18/03/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import Dotzu

class RootTableViewController: UITableViewController {

    @IBAction func switchChanged(_ sender: UISwitch) {
        if sender.isOn {
            Dotzu.sharedManager.enable()
        } else {
            Dotzu.sharedManager.disable()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dotzu test app"
    }
}
