//
//  Manager.swift
//  exampleWindow
//
//  Created by Remi Robert on 02/12/2016.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit

public class Dotzu: NSObject {
    public static let sharedManager = Dotzu()
    private var window: ManagerWindow
    fileprivate let controller = ManagerViewController()
    private let cache = NSCache<AnyObject, AnyObject>()
    private let userDefault = UserDefaults.standard
    var displayedList = false

    func initLogsManager() {
        if LogsSettings.shared.resetLogsStart {
            let _ = StoreManager<Log>(store: .log).reset()
            let _ = StoreManager<LogRequest>(store: .network).reset()
        }
    }

    public func displayWindow() {
        initLogsManager()
        self.window.rootViewController = self.controller
        self.window.makeKeyAndVisible()
        self.window.delegate = self
        if LogsSettings.shared.network {
            LoggerNetwork.register()
        }
        LoggerCrash.register()
    }

    public func addLogger(session: URLSessionConfiguration) {
        session.protocolClasses?.insert(LoggerNetwork.self, at: 0)
    }

    override init() {
        self.window = ManagerWindow(frame: UIScreen.main.bounds)
        super.init()
    }
}

extension Dotzu: ManagerWindowDelegate {
    func isPointEvent(point: CGPoint) -> Bool {
        return self.controller.shouldReceive(point: point)
    }
}
