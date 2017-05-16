//
//  LogsSettings.swift
//  exampleWindow
//
//  Created by Remi Robert on 18/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation

class LogsSettings {

    static let shared = LogsSettings()

    var overridePrint: Bool {
        didSet {
            UserDefaults.standard.set(overridePrint, forKey: "enableOverridePrint")
        }
    }
    var resetLogsStart: Bool {
        didSet {
            UserDefaults.standard.set(resetLogsStart, forKey: "resetLogsStart")
        }
    }
    var fileInfo: Bool {
        didSet {
            UserDefaults.standard.set(fileInfo, forKey: "fileInfoDsisplayed")
        }
    }
    var date: Bool {
        didSet {
            UserDefaults.standard.set(fileInfo, forKey: "dateDisplayed")
        }
    }
    var network: Bool {
        didSet {
            UserDefaults.standard.set(fileInfo, forKey: "networkLoggerEnabled")
        }
    }

    init() {
        overridePrint = UserDefaults.standard.bool2(forKey: "enableOverridePrint")
        resetLogsStart = UserDefaults.standard.bool2(forKey: "resetLogsStart", defaultValue: false)
        fileInfo = UserDefaults.standard.bool2(forKey: "fileInfoDisplayed")
        date = UserDefaults.standard.bool2(forKey: "dateDisplayed")
        network = UserDefaults.standard.bool2(forKey: "networkLoggerEnabled")
    }
}
