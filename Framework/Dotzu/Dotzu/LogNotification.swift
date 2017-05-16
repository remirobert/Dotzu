//
//  LogNotification.swift
//  exampleWindow
//
//  Created by Remi Robert on 20/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation

enum LogNotificationApp {
    case newLog
    case refreshLogs
    case settingsChanged
    case resetCountBadge
    case newRequest
    case stopRequest
}

extension LogNotificationApp: NotificationProtocol {
    var name: String {
        switch self {
        case .newLog:
            return "newLogs"
        case .refreshLogs:
            return "refreshLogs"
        case .settingsChanged:
            return "settingsChanged"
        case .resetCountBadge:
            return "resetCountBadge"
        case .newRequest:
            return "newRequest"
        case .stopRequest:
            return "stopRequest"
        }
    }
}
