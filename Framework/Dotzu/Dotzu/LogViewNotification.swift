//
//  LogViewNotification.swift
//  exampleWindow
//
//  Created by Remi Robert on 31/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class LogViewNotification {

    static var countCrash: Int {
        get {
            return UserDefaults.standard.integer(forKey: "lognotificationcount")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "lognotificationcount")
        }
    }
}
