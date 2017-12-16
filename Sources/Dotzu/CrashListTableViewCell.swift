//
//  CrashListTableViewCell.swift
//  exampleWindow
//
//  Created by Remi Robert on 31/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class CrashListTableViewCell: UITableViewCell {

    @IBOutlet weak var textview: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        textview.isUserInteractionEnabled = false
    }

    var crash: LogCrash? {
        didSet {
            guard let crash = crash else {return}
            let formatDate = LoggerFormat.formatDate(date: crash.date)
            let content = "\("\(formatDate)\n")\(crash.name ?? "Unknow crash")"
            
            textview.text = content
            let attstr = NSMutableAttributedString(string: content)
            
            attstr.addAttribute(NSForegroundColorAttributeName,
                                value: UIColor.white, range: NSMakeRange(0, content.characters.count))
            
            let range = NSMakeRange(0, formatDate.characters.count)
            attstr.addAttribute(NSForegroundColorAttributeName, value: Color.mainGreen, range: range)
            attstr.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFont(ofSize: 12), range: range)
            
            textview.attributedText = attstr
        }
    }
}
