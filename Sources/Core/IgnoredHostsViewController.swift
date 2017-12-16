//
//  IgnoredHostsViewController.swift
//  PhiHome
//
//  Created by liman on 28/11/2017.
//  Copyright © 2017 Phicomm. All rights reserved.
//

import Foundation
import UIKit

class IgnoredHostsViewController: UITableViewController {
    
    var models: Array<String>?
    
    static func instanceFromStoryBoard() -> IgnoredHostsViewController {
        let storyboard = UIStoryboard(name: "App", bundle: Bundle(for: DebugMan.self))
        return storyboard.instantiateViewController(withIdentifier: "IgnoredHostsViewController") as! IgnoredHostsViewController
    }
    
    //MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()

        models = LogsSettings.shared.ignoredHosts
    }
    
    //MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = models?[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.contentView.backgroundColor = UIColor.black
        cell.selectionStyle = .none
        
        return cell
    }
}
