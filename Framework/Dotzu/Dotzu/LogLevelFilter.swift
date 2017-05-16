//
//  LogFilter.swift
//  exampleWindow
//
//  Created by Remi Robert on 22/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class LogLevelFilter {

    static let shared = LogLevelFilter()

    var enabled: [LogLevel] {
        return [error ? .error : nil,
                warning ? .warning : nil,
                info ? .info : nil,
                verbose ? .verbose : nil].flatMap {$0}
    }

    var error: Bool {
        didSet {
            setFilter(value: error, key: "errorDisplayed")
        }
    }
    var warning: Bool {
        didSet {
            setFilter(value: warning, key: "warningDisplayed")
        }
    }
    var info: Bool {
        didSet {
            setFilter(value: info, key: "infoDisplayed")
        }
    }
    var verbose: Bool {
        didSet {
            setFilter(value: verbose, key: "verboseDisplayed")
        }
    }

    private func setFilter(value: Bool, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        LogNotificationApp.refreshLogs.post(Void())
    }

    init() {
        error = UserDefaults.standard.bool2(forKey: "errorDisplayed")
        warning = UserDefaults.standard.bool2(forKey: "warningDisplayed")
        info = UserDefaults.standard.bool2(forKey: "infoDisplayed")
        verbose = UserDefaults.standard.bool2(forKey: "verboseDisplayed")
    }
}
