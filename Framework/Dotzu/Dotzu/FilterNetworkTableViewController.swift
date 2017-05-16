//
//  FilterNetworkTableViewController.swift
//  exampleWindow
//
//  Created by Remi Robert on 27/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class FilterNetworkTableViewController: UITableViewController, FilterViewControllerProtocol {

    @IBOutlet weak var switch200: UISwitch!
    @IBOutlet weak var switch300: UISwitch!
    @IBOutlet weak var switch400: UISwitch!
    @IBOutlet weak var switch500: UISwitch!

    @IBOutlet weak var viewType200: UIView!
    @IBOutlet weak var viewType300: UIView!
    @IBOutlet weak var viewType400: UIView!
    @IBOutlet weak var viewType500: UIView!

    @IBAction func setFilter(_ sender: UISwitch) {
        switch sender.tag {
        case 0: LogCodeFilter.shared.code200 = sender.isOn
        case 1: LogCodeFilter.shared.code300 = sender.isOn
        case 2: LogCodeFilter.shared.code400 = sender.isOn
        case 3: LogCodeFilter.shared.code500 = sender.isOn
        default: break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        switch300.tag = 1
        switch400.tag = 2
        switch500.tag = 3
        viewType200.backgroundColor = LogCode.color(code: 200)
        viewType300.backgroundColor = LogCode.color(code: 300)
        viewType400.backgroundColor = LogCode.color(code: 400)
        viewType500.backgroundColor = LogCode.color(code: 500)
        switch200.onTintColor = LogCode.color(code: 200)
        switch300.onTintColor = LogCode.color(code: 300)
        switch400.onTintColor = LogCode.color(code: 400)
        switch500.onTintColor = LogCode.color(code: 500)

        switch200.isOn = LogCodeFilter.shared.code200
        switch300.isOn = LogCodeFilter.shared.code300
        switch400.isOn = LogCodeFilter.shared.code400
        switch500.isOn = LogCodeFilter.shared.code500
    }

    func resetFilter() {
        LogLevelFilter.shared.error = true
        LogLevelFilter.shared.warning = true
        LogLevelFilter.shared.info = true
        LogLevelFilter.shared.verbose = true
        switch200.isOn = true
        switch300.isOn = true
        switch400.isOn = true
        switch500.isOn = true
        LogNotificationApp.stopRequest.post(Void())
    }
}
