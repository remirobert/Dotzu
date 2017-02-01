//
//  ManagerListLogViewController.swift
//  exampleWindow
//
//  Created by Remi Robert on 06/12/2016.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit

class ManagerListLogViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var labelEmptyState: UILabel!
    @IBOutlet weak var segment: UISegmentedControl!

    private let dataSourceLogs = ListLogDataSource<Log>()
    fileprivate let dataSourceNetwork = ListLogDataSource<LogRequest>()

    private var obsLogs: NotificationObserver<Void>!
    private var obsSettings: NotificationObserver<Void>!
    private var obsNetwork: NotificationObserver<Void>!

    fileprivate var state: ManagerListLogState = .logs {
        didSet {
            if state == .logs {
                tableview.dataSource = dataSourceLogs
                dataSourceLogs.reloadData()
            } else {
                tableview.dataSource = dataSourceNetwork
                dataSourceNetwork.reloadData()
            }
            let count = state == .logs ? dataSourceLogs.count : dataSourceNetwork.count
            let lastPath = state == .logs ? dataSourceLogs.lastPath : dataSourceNetwork.lastPath
            tableview.reloadData()
            if count > 0 {
                tableview.scrollToRow(at: lastPath, at: .top, animated: false)
            }
            labelEmptyState.isHidden = count > 0
        }
    }

    @IBAction func didChangeState(_ sender: Any) {
        state = ManagerListLogState(rawValue: segment.selectedSegmentIndex) ?? .logs
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let lastPath = state == .logs ? dataSourceLogs.lastPath : dataSourceNetwork.lastPath
        let count = state == .logs ? dataSourceLogs.count : dataSourceNetwork.count
        if count > 0 {
            tableview.scrollToRow(at: lastPath, at: .top, animated: false)
        }
        labelEmptyState.isHidden = count > 0
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LogNotificationApp.resetCountBadge.post(Void())
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        LogNotificationApp.resetCountBadge.post(Void())
    }

    @IBAction func resetLogs(_ sender: Any) {
        dataSourceLogs.reset()
        dataSourceNetwork.reset()
        let storeLogs = StoreManager<Log>(store: .log)
        let storeNetwork = StoreManager<LogRequest>(store: .network)
        storeLogs.reset()
        storeNetwork.reset()
        labelEmptyState.isHidden = false
        tableview.reloadData()
    }

    private func initTableView() {
        labelEmptyState.isHidden = true
        tableview.registerCellWithNib(cell: LogTableViewCell.self)
        tableview.registerCellWithNib(cell: LogNetworkTableViewCell.self)
        tableview.estimatedRowHeight = 50
        tableview.rowHeight = UITableViewAutomaticDimension
        tableview.dataSource = dataSourceLogs
        tableview.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        segment.tintColor = Color.mainGreen
        initTableView()
        dataSourceNetwork.reloadData()
        dataSourceLogs.reloadData()

        obsSettings = NotificationObserver(notification: LogNotificationApp.settingsChanged, block: { [weak self] _ in
            guard let weakSelf = self else { return }
            weakSelf.tableview.reloadData()
        })

        obsNetwork = NotificationObserver(notification: LogNotificationApp.stopRequest, block: { [weak self] _ in
            guard let weakSelf = self, weakSelf.state == .network else { return }
            DispatchQueue.main.async {
                weakSelf.dataSourceNetwork.reloadData()
                weakSelf.tableview.reloadData()
                weakSelf.labelEmptyState.isHidden = weakSelf.dataSourceNetwork.count > 0
                let lastPath = weakSelf.dataSourceNetwork.lastPath
                let lastVisiblePath = weakSelf.tableview.indexPathsForVisibleRows?.last
                if let lastVisiblePath = lastVisiblePath {
                    if lastVisiblePath.row + 1 >= lastPath.row {
                        weakSelf.tableview.scrollToRow(at: lastPath, at: .top, animated: false)
                    }
                }
            }
        })

        obsLogs = NotificationObserver(notification: LogNotificationApp.refreshLogs, block: { [weak self] _ in
            guard let weakSelf = self, weakSelf.state == .logs else { return }
            DispatchQueue.main.async {
                weakSelf.dataSourceLogs.reloadData()
                weakSelf.tableview.reloadData()
                weakSelf.labelEmptyState.isHidden = weakSelf.dataSourceLogs.count > 0
                let lastPath = weakSelf.dataSourceLogs.lastPath
                let lastVisiblePath = weakSelf.tableview.indexPathsForVisibleRows?.last
                if let lastVisiblePath = lastVisiblePath {
                    if lastVisiblePath.row + 1 >= lastPath.row {
                        weakSelf.tableview.scrollToRow(at: lastPath, at: .top, animated: false)
                    }
                }
            }
        })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? DetailRequestViewController,
            let req = sender as? LogRequest {
            controller.log = req
        } else if let controller = segue.destination as? ContainerFilterViewController {
            controller.state = state
        }
    }
}

extension ManagerListLogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if state == .logs {
            return
        }
        guard let LogRequest = dataSourceNetwork[indexPath.row] else {return}
        performSegue(withIdentifier: "detailRequestSegue", sender: LogRequest)
    }
}
