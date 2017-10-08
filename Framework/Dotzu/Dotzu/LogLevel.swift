//
//  LogPrintType.swift
//  exampleWindow
//
//  Created by Remi Robert on 19/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

public enum LogLevel: Int {
    case verbose
    case info
    case warning
    case error
    case none
}

extension LogLevel {

    static func colorFor(type: LogLevel) -> UIColor {
        switch type {
        case .verbose: return UIColor.lightGray
        case .info: return UIColor.cyan
        case .warning: return UIColor.yellow
        case .error: return UIColor.red
        case .none: return UIColor.clear
        }
    }

    var notificationText: String {
        switch self {
        case .error: return "❌"
        case .warning: return "⚠️"
        default: return ""
        }
    }

    var logColorConsole: String {
        switch self {
        case .verbose: return "◽️"
        case .info: return "🔷"
        case .warning: return "⚠️"
        case .error: return "❌"
        case .none: return ""
        }
    }

    var color: UIColor {
        return LogLevel.colorFor(type: self)
    }
}
