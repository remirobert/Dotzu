//
//  LoggerFormat.swift
//  exampleWindow
//
//  Created by Remi Robert on 23/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class LoggerFormat {

    static func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }

    static func format(_ log: Log) -> (str: String, attr: NSMutableAttributedString) {
        var startIndex = 0
        var lenghtDate: Int?
        let stringContent = NSMutableString()
        
        
//        stringContent.append("\(log.level.logColorConsole) ")
        if let date = log.date {
            stringContent.append("[\(formatDate(date: date))] ")
            lenghtDate = stringContent.length
            startIndex = stringContent.length
        }
        if let fileInfoString = log.fileInfo {
            stringContent.append("\(fileInfoString)\(log.content)")
        } else {
            stringContent.append("\(log.content)")
        }
        
        let attstr = NSMutableAttributedString(string: stringContent as String)
        attstr.addAttribute(NSAttributedStringKey.foregroundColor,
                            value: log.color ?? UIColor.white,
                            range: NSMakeRange(0, stringContent.length))
        if let dateLenght = lenghtDate {
            let range = NSMakeRange(0, dateLenght)
            attstr.addAttribute(NSAttributedStringKey.foregroundColor, value: Color.mainGreen, range: range)
            attstr.addAttribute(NSAttributedStringKey.font, value: UIFont.boldSystemFont(ofSize: 12), range: range)
        }
        if let fileInfoString = log.fileInfo {
            let range = NSMakeRange(startIndex, fileInfoString.count)
            attstr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.gray, range: range)
            attstr.addAttribute(NSAttributedStringKey.font, value: UIFont.boldSystemFont(ofSize: 12), range: range)
        }
        return (stringContent as String, attstr)
    }
}
