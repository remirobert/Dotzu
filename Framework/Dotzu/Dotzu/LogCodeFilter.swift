//
//  LogCodeFilter.swift
//  exampleWindow
//
//  Created by Remi Robert on 27/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class LogCodeFilter {

    static let shared = LogCodeFilter()

    var enabled: [LogCode] {
        return [code200 ? .code200 : nil,
                code300 ? .code300 : nil,
                code400 ? .code400 : nil,
                code500 ? .code500 : nil].flatMap {$0}
    }

    var code200: Bool {
        didSet {
            setFilter(value: code200, key: "codeFilter200")
        }
    }
    var code300: Bool {
        didSet {
            setFilter(value: code300, key: "codeFilter300")
        }
    }
    var code400: Bool {
        didSet {
            setFilter(value: code400, key: "codeFilter400")
        }
    }
    var code500: Bool {
        didSet {
            setFilter(value: code500, key: "codeFilter500")
        }
    }

    private func setFilter(value: Bool, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        LogNotificationApp.stopRequest.post(Void())
    }

    init() {
        code200 = UserDefaults.standard.bool2(forKey: "codeFilter200")
        code300 = UserDefaults.standard.bool2(forKey: "codeFilter300")
        code400 = UserDefaults.standard.bool2(forKey: "codeFilter400")
        code500 = UserDefaults.standard.bool2(forKey: "codeFilter500")
    }
}
