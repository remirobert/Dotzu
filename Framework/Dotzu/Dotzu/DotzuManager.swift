//
//  Manager.swift
//  exampleWindow
//
//  Created by Remi Robert on 02/12/2016.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit

public class DotzuConfig: NSObject {
    public var showManagerView = true
}

public class Dotzu: NSObject {
    public static let sharedManager = Dotzu()
    private var config: DotzuConfig = DotzuConfig()
    private var window: ManagerWindow?
    fileprivate var controller: ManagerViewController?
    private let cache = NSCache<AnyObject, AnyObject>()
    private let userDefault = UserDefaults.standard
    var displayedList = false

    func initLogsManager() {
        if LogsSettings.shared.resetLogsStart {
            let _ = StoreManager<Log>(store: .log).reset()
            let _ = StoreManager<LogRequest>(store: .network).reset()
        }
    }

    public func enable() {
        initLogsManager()
        if self.config.showManagerView {
            self.window = ManagerWindow(frame: UIScreen.main.bounds)
            self.controller = ManagerViewController()
        }
        self.window?.rootViewController = self.controller
        self.window?.makeKeyAndVisible()
        self.window?.delegate = self
        LoggerNetwork.shared.enable = LogsSettings.shared.network
        Logger.shared.enable = true
        LoggerCrash.shared.enable = true
    }

    public func disable() {
        self.window?.rootViewController = nil
        self.window?.resignKey()
        self.window?.removeFromSuperview()
        Logger.shared.enable = false
        LoggerCrash.shared.enable = false
        LoggerNetwork.shared.enable = false
    }

    public func addLogger(session: URLSessionConfiguration) {
        session.protocolClasses?.insert(LoggerNetwork.self, at: 0)
    }

    public class func setUp(config: DotzuConfig) {
        sharedManager.config = config
    }

    public func managerViewController () -> UIViewController? {
        let storyboard = UIStoryboard(name: "Manager", bundle: Bundle(for: ManagerViewController.self))
        return storyboard.instantiateInitialViewController()
    }
    
    override init() {
        super.init()
    }
}

extension Dotzu: ManagerWindowDelegate {
    func isPointEvent(point: CGPoint) -> Bool {
        return self.controller?.shouldReceive(point: point) ?? false
    }
}
