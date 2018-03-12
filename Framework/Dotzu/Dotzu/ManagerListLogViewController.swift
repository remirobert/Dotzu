//
//  ManagerListLogViewController.swift
//  exampleWindow
//
//  Created by Remi Robert on 06/12/2016.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit
import MessageUI

class ManagerListLogViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var labelEmptyState: UILabel!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var buttonScrollDown: UIButton! {
        didSet {
            buttonScrollDown.isHidden = true
            buttonScrollDown.layer.cornerRadius = 25
        }
    }

    fileprivate let dataSourceLogs = ListLogDataSource<Log>()
    fileprivate let dataSourceNetwork = ListLogDataSource<LogRequest>()

    private var firstLaunch = true
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

    @IBAction func scrollDown(_ sender: Any) {
        let lastPath = state == .logs ? dataSourceLogs.lastPath : dataSourceNetwork.lastPath
        tableview.scrollToRow(at: lastPath, at: .top, animated: true)
    }

    @IBAction func didChangeState(_ sender: Any) {
        state = ManagerListLogState(rawValue: segment.selectedSegmentIndex) ?? .logs
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let count = state == .logs ? dataSourceLogs.count : dataSourceNetwork.count
        if count > 0 {
            if firstLaunch {
                firstLaunch = false
                let lastPath = state == .logs ? dataSourceLogs.lastPath : dataSourceNetwork.lastPath
                tableview.scrollToRow(at: lastPath, at: .top, animated: false)
            } else {
                changeStateButtonScrollDown(show: isScrollable(scrollView: tableview))
            }
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

    @IBAction func showActions() {

        let alertController = UIAlertController(title: "More actions",
                                                message: nil,
                                                preferredStyle: .actionSheet)

        let sendLogsButton = UIAlertAction(title: "Email logs",
                                           style: .default,
                                           handler: { [weak self] (action) in self?.emailLogs() })
        alertController.addAction(sendLogsButton)

        let resetLogsButton = UIAlertAction(title: "Reset logs & network",
                                            style: .destructive,
                                            handler: { [weak self] (action) in self?.resetLogs() })
        alertController.addAction(resetLogsButton)

        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler:nil)
        alertController.addAction(cancelButton)

        self.navigationController?.present(alertController, animated: true, completion: nil)

    }

    private func emailLogs() {

        if MFMailComposeViewController.canSendMail() {

            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self;
            let appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
            mail.setSubject("\(appName ?? "App") Log")

            var formattedData = Data()
            for itemIndex in 0...self.dataSourceLogs.count {
                if let log = self.dataSourceLogs[itemIndex] {
                    let format = LoggerFormat.format(log: log)
                    let data = Data(("Log Index:\(itemIndex)\n \(format.str) \n\n").utf8)
                    formattedData.append(data)
                }
            }

            mail.addAttachmentData(formattedData, mimeType: "text/plain", fileName: "log-\(Date())")

            self.present(mail, animated: true, completion: nil)
        }
    }

    private func resetLogs() {
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

extension ManagerListLogViewController: UIScrollViewDelegate {
    fileprivate func changeStateButtonScrollDown(show: Bool) {
        if show {
            buttonScrollDown.isHidden = false
        }
        let widthScreen = UIScreen.main.bounds.size.width
        UIView.animate(withDuration: 1, delay: show ? 0.5 : 0, usingSpringWithDamping: show ? 0.5 : 0, initialSpringVelocity: show ? 6 : 0, options: .curveEaseOut, animations: {
            self.buttonScrollDown.frame.origin.x = show ? widthScreen - 60 : widthScreen
        }, completion: nil)
    }

    fileprivate func isScrollable(scrollView: UIScrollView) -> Bool {
        let ratio = scrollView.contentSize.height - scrollView.contentOffset.y
        return !(ratio <= scrollView.frame.size.height)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        changeStateButtonScrollDown(show: isScrollable(scrollView: scrollView))
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        changeStateButtonScrollDown(show: isScrollable(scrollView: scrollView))
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

extension ManagerListLogViewController: MFMailComposeViewControllerDelegate {

    public func mailComposeController(_ controller: MFMailComposeViewController,
                                      didFinishWith result: MFMailComposeResult,
                                      error: Error?) {

        controller.dismiss(animated: true, completion: nil)
    }
}

extension ManagerListLogViewController {
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return state == .logs
    }
    
    func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return action == #selector(copy(_:))
    }
    
    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        guard let log = dataSourceLogs[indexPath.row] else {return}
        let format = LoggerFormat.format(log: log)
        UIPasteboard.general.string = format.attr.string
    }
}
