//
//  DetailCrashTableViewController.swift
//  exampleWindow
//
//  Created by Remi Robert on 31/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class DetailCrashTableViewController: UITableViewController {

    @IBOutlet weak var textviewName: UITextView!
    @IBOutlet weak var textviewReason: UITextView!
    @IBOutlet weak var textviewStackTraces: UITextView!
    var crash: LogCrash!

    @objc func shareCrashReport() {
        let controller = UIActivityViewController(activityItems: [crash.toString()], applicationActivities: nil)
        present(controller, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let selector = #selector(DetailCrashTableViewController.shareCrashReport)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                            target: self,
                                                            action: selector)

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.delegate = self

        textviewName.text = "\(crash.name ?? "N/A")"
        textviewReason.text = "\(crash.reason ?? "N/A")"

        let contentStack = crash.callStacks?.reduce("", {
            $0 == "" ? $1 : $0 + "\n" + $1
        })
        textviewStackTraces.text = contentStack
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
