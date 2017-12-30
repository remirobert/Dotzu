//
//  ListCrashesViewController.swift
//  exampleWindow
//
//  Created by Remi Robert on 31/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class ListCrashesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var models: [LogCrash] = [LogCrash]()
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.trash, target: self, action:#selector(ListCrashesViewController.deleteCrashes))

        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        models = StoreManager.shared.crashArray
        tableView.reloadData()
    }

    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //否则偶尔crash
        if indexPath.row >= models.count {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CrashListTableViewCell", for: indexPath)
            as! CrashListTableViewCell
        cell.crash = models[indexPath.row]
        return cell
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "detailCrashSegue", sender: models[indexPath.row])
    }
  
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, sourceView, completionHandler) in
            guard let models = self?.models else {return}
            StoreManager.shared.removeCrash(models[indexPath.row])
            self?.models.remove(at: indexPath.row)
            self?.dispatch_main_async_safe { [weak self] in
                self?.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    //MARK: - only for ios8/ios9/ios10, not ios11
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            StoreManager.shared.removeCrash(models[indexPath.row])
            self.models.remove(at: indexPath.row)
            self.dispatch_main_async_safe { [weak self] in
                self?.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    //MARK: - prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? DetailCrashTableViewController,
            let crash = sender as? LogCrash else {return}
        controller.crash = crash
    }
    
    //MARK: - target action
    @objc func deleteCrashes() {
        models = []
        StoreManager.shared.resetCrashs()
        
        dispatch_main_async_safe { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
