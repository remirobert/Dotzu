//
//  LogsSettings.swift
//  exampleWindow
//
//  Created by Remi Robert on 18/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation

public class LogsSettings {

    public static let shared = LogsSettings()

    public var overridePrint: Bool {
        didSet {
            UserDefaults.standard.set(overridePrint, forKey: "enableOverridePrint")
        }
    }
    public var resetLogsStart: Bool {
        didSet {
            UserDefaults.standard.set(resetLogsStart, forKey: "resetLogsStart")
        }
    }
    public var fileInfo: Bool {
        didSet {
            UserDefaults.standard.set(fileInfo, forKey: "fileInfoDsisplayed")
        }
    }
    public var date: Bool {
        didSet {
            UserDefaults.standard.set(fileInfo, forKey: "dateDisplayed")
        }
    }
    public var network: Bool {
        didSet {
            UserDefaults.standard.set(fileInfo, forKey: "networkLoggerEnabled")
        }
    }
    public var showBubbleHead: Bool {
        didSet {
            UserDefaults.standard.set(showBubbleHead, forKey: "showBubbleHead")
        }
    }
    public var consoleLevel: LogLevel {
        didSet {
            UserDefaults.standard.set(consoleLevel.rawValue, forKey: "consoleLevel")
        }
    }

    init() {
        overridePrint = UserDefaults.standard.bool2(forKey: "enableOverridePrint")
        resetLogsStart = UserDefaults.standard.bool2(forKey: "resetLogsStart", defaultValue: false)
        fileInfo = UserDefaults.standard.bool2(forKey: "fileInfoDisplayed")
        date = UserDefaults.standard.bool2(forKey: "dateDisplayed")
        network = UserDefaults.standard.bool2(forKey: "networkLoggerEnabled")
        showBubbleHead = UserDefaults.standard.bool2(forKey: "showBubbleHead")
        consoleLevel = LogLevel(rawValue: UserDefaults.standard.integer(forKey: "consoleLevel")) ?? .verbose
    }
}
