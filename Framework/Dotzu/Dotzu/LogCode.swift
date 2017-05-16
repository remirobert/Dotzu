//
//  LogCode.swift
//  exampleWindow
//
//  Created by Remi Robert on 27/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

enum LogCode {
    case code200
    case code300
    case code400
    case code500

    static func codeFrom(code: Int) -> LogCode {
        switch code {
        case 200...299: return .code200
        case 300...399: return .code300
        case 400...499: return .code400
        case 500...600: return .code500
        default: return .code200
        }
    }

    static func color(code: Int) -> UIColor {
        switch code {
        case 200...299: return UIColor.green
        case 300...399: return UIColor.cyan
        case 400...499: return UIColor.orange
        case 500...600: return UIColor.red
        default: return UIColor.gray
        }
    }
}
