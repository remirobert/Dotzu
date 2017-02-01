//
//  LogPrintType.swift
//  exampleWindow
//
//  Created by Remi Robert on 19/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

enum LogLevel: Int {
    case verbose
    case info
    case warning
    case error
}

extension LogLevel {

    static func colorFor(type: LogLevel) -> UIColor {
        switch type {
        case .verbose: return UIColor.lightGray
        case .info: return UIColor.cyan
        case .warning: return UIColor.yellow
        case .error: return UIColor.red
        }
    }

    var notificationText: String {
        switch self {
        case .error: return "❌"
        case .warning: return "⚠️"
        default: return ""
        }
    }

    var color: UIColor {
        return LogLevel.colorFor(type: self)
    }
}
