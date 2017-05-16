//
//  FilterLogTableViewController.swift
//  exampleWindow
//
//  Created by Remi Robert on 22/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class FilterLogTableViewController: UITableViewController, FilterViewControllerProtocol {

    @IBOutlet weak var switchError: UISwitch!
    @IBOutlet weak var switchWarning: UISwitch!
    @IBOutlet weak var switchInfo: UISwitch!
    @IBOutlet weak var switchVerbose: UISwitch!

    @IBOutlet weak var viewTypeError: UIView!
    @IBOutlet weak var viewTypeWarning: UIView!
    @IBOutlet weak var viewTypeInfo: UIView!
    @IBOutlet weak var viewTypeVerbose: UIView!

    @IBAction func setFilter(_ sender: UISwitch) {
        switch sender.tag {
        case 0: LogLevelFilter.shared.error = sender.isOn
        case 1: LogLevelFilter.shared.warning = sender.isOn
        case 2: LogLevelFilter.shared.info = sender.isOn
        case 3: LogLevelFilter.shared.verbose = sender.isOn
        default: break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        switchWarning.tag = 1
        switchInfo.tag = 2
        switchVerbose.tag = 3

        switchError.isOn = LogLevelFilter.shared.error
        switchWarning.isOn = LogLevelFilter.shared.warning
        switchInfo.isOn = LogLevelFilter.shared.info
        switchVerbose.isOn = LogLevelFilter.shared.verbose

        switchError.onTintColor = LogLevel.colorFor(type: .error)
        switchWarning.onTintColor = LogLevel.colorFor(type: .warning)
        switchInfo.onTintColor = LogLevel.colorFor(type: .info)
        switchVerbose.onTintColor = LogLevel.colorFor(type: .verbose)

        viewTypeError.backgroundColor = LogLevel.colorFor(type: .error)
        viewTypeWarning.backgroundColor = LogLevel.colorFor(type: .warning)
        viewTypeInfo.backgroundColor = LogLevel.colorFor(type: .info)
        viewTypeVerbose.backgroundColor = LogLevel.colorFor(type: .verbose)
    }

    func resetFilter() {
        LogLevelFilter.shared.error = true
        LogLevelFilter.shared.warning = true
        LogLevelFilter.shared.info = true
        LogLevelFilter.shared.verbose = true
        switchVerbose.isOn = true
        switchWarning.isOn = true
        switchInfo.isOn = true
        switchError.isOn = true
        LogNotificationApp.refreshLogs.post(Void())
    }
}
