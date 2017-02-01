//
//  CrashListTableViewCell.swift
//  exampleWindow
//
//  Created by Remi Robert on 31/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class CrashListTableViewCell: UITableViewCell, LogCellProtocol {

    @IBOutlet weak var textview: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        textview.isUserInteractionEnabled = false
    }

    func configure(log: LogProtocol) {
        guard let crash = log as? LogCrash else {return}
        let formatDate = LogsSettings.shared.date ? LoggerFormat.formatDate(date: crash.date) : ""
        let content = "\(LogsSettings.shared.date ? "\(formatDate)\n" : "")\(crash.name ?? "Unknow crash")"

        textview.text = content
        let attstr = NSMutableAttributedString(string: content)

        attstr.addAttribute(NSForegroundColorAttributeName,
                            value: UIColor.white, range: NSMakeRange(0, content.characters.count))
        if LogsSettings.shared.date {
            let range = NSMakeRange(0, formatDate.characters.count)
            attstr.addAttribute(NSForegroundColorAttributeName, value: Color.mainGreen, range: range)
            attstr.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFont(ofSize: 12), range: range)
        }
        textview.attributedText = attstr
    }
}
