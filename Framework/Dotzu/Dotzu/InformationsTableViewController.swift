//
//  InformationsTableViewController.swift
//  exampleWindow
//
//  Created by Remi Robert on 18/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class InformationsTableViewController: UITableViewController {

    @IBOutlet weak var labelVersionNumber: UILabel!
    @IBOutlet weak var labelBuildNumber: UILabel!
    @IBOutlet weak var labelBundleName: UILabel!
    @IBOutlet weak var labelScreenResolution: UILabel!
    @IBOutlet weak var labelScreenSize: UILabel!
    @IBOutlet weak var labelDeviceModel: UILabel!
    @IBOutlet weak var labelCrashCount: UILabel!

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let store = StoreManager<LogCrash>(store: .crash)
        let count = store.logs().count
        labelCrashCount.text = "\(count)"
        labelCrashCount.textColor = count > 0 ? UIColor.red : UIColor.white
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        labelCrashCount.frame.size = CGSize(width: 30, height: 20)

        labelVersionNumber.text = ApplicationInformation.versionNumber
        labelBuildNumber.text = ApplicationInformation.buildNumber
        labelBundleName.text = ApplicationInformation.bundleName

        labelScreenResolution.text = Device.screenResolution
        labelScreenSize.text = "\(Device.screenSize)"
        labelDeviceModel.text = "\(Device.deviceModel)"
    }
}
