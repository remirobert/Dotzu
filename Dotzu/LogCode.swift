//
//  LogCode.swift
//  exampleWindow
//
//  Created by Remi Robert on 27/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

enum LogCode: Int {
    case code200 = 200
    case code300 = 300
    case code400 = 400
    case code500 = 500

    static func color(code: Int) -> UIColor {
        switch code {
        case 200...299: return UIColor.green
        case 300...399: return UIColor.cyan
        case 400...499: return UIColor.orange
        case 500...600: return UIColor.red
        default: return UIColor.gray
        }
    }

    var color: UIColor {
        return LogCode.color(code: self.rawValue)
    }
}
