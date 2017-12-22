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
    @IBOutlet weak var labelBundleID: UILabel!
    @IBOutlet weak var labelIgnoredHosts: UILabel!
    @IBOutlet weak var labelMainHost: UILabel!
    @IBOutlet weak var labelIOSVersion: UILabel!
    
    //MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()

        //liman mark
        NotificationCenter.default.addObserver(self, selector: #selector(tapStatusBar), name: NSNotification.Name("tapStatusBar"), object: nil)

        
        labelCrashCount.frame.size = CGSize(width: 30, height: 20)

        labelVersionNumber.text = ApplicationInformation.versionNumber
        labelBuildNumber.text = ApplicationInformation.buildNumber
        labelBundleName.text = ApplicationInformation.bundleName

        labelScreenResolution.text = Device.screenResolution
        labelScreenSize.text = "\(Device.screenSize)"
        labelDeviceModel.text = "\(Device.deviceModel)"
        
        labelBundleID.text = Bundle.main.bundleIdentifier
        labelIgnoredHosts.text = String(LogsSettings.shared.ignoredHosts?.count ?? 0)
        
        labelMainHost.text = LogsSettings.shared.mainHost
        labelIOSVersion.text = UIDevice.current.systemVersion
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let count = UserDefaults.standard.integer(forKey: "crashCount")
        labelCrashCount.text = "\(count)"
        labelCrashCount.textColor = count > 0 ? UIColor.red : UIColor.white
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 1 && indexPath.row == 4 {
            if labelMainHost.text == nil || labelMainHost.text == "" {
                return 0
            }
        }
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 && indexPath.row == 3 {
            UIPasteboard.general.string = Bundle.main.bundleIdentifier
            
            let alert = UIAlertController.init(title: "copy bundle id to clipboard success", message: nil, preferredStyle: .alert)
            let action = UIAlertAction.init(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
        if indexPath.section == 1 && indexPath.row == 4 {
            if labelMainHost.text == nil || labelMainHost.text == "" {
                return
            }
            
            UIPasteboard.general.string = LogsSettings.shared.mainHost
            
            let alert = UIAlertController.init(title: "copy main host to clipboard success", message: nil, preferredStyle: .alert)
            let action = UIAlertAction.init(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
        if indexPath.section == 3 && indexPath.row == 0 {
            let vc = IgnoredHostsViewController.instanceFromStoryBoard()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //MARK: - notification
    @objc func tapStatusBar() {
        dispatch_main_async_safe { [weak self] in
            self?.tableView.setContentOffset( CGPoint(x: 0, y: 0) , animated: true)
        }
    }
}
