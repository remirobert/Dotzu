//
//  ListCrashesViewController.swift
//  exampleWindow
//
//  Created by Remi Robert on 31/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class ListCrashesViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var labelEmpty: UILabel!
    let datasource = ListLogDataSource<LogCrash>()

    @objc func deleteCrashes() {
        let _ = StoreManager<LogCrash>(store: .crash).reset()
        datasource.reset()
        datasource.reloadData()
        tableview.reloadData()
        labelEmpty.isHidden = datasource.count > 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.trash,
                                                            target: self,
                                                            action: #selector(ListCrashesViewController.deleteCrashes))

        LogViewNotification.countCrash = 0

        title = "Crash sessions"
        tableview.registerCellWithNib(cell: CrashListTableViewCell.self)
        tableview.estimatedRowHeight = 50
        tableview.rowHeight = UITableViewAutomaticDimension
        tableview.delegate = self
        tableview.dataSource = datasource
        tableview.tableFooterView = UIView()
        datasource.reloadData()
        labelEmpty.isHidden = datasource.count > 0
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? DetailCrashTableViewController,
            let crash = sender as? LogCrash else {return}
        controller.crash = crash
    }
}

extension ListCrashesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let crash = datasource[indexPath.row] else {return}
        performSegue(withIdentifier: "detailCrashSegue", sender: crash)
    }
}
