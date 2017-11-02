//
//  LogNetworkTableViewCell.swift
//  exampleWindow
//
//  Created by Remi Robert on 24/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class LogNetworkTableViewCell: UITableViewCell, LogCellProtocol {

    @IBOutlet weak var labelCode: UILabel!
    @IBOutlet weak var textViewContent: UITextView!
    @IBOutlet weak var viewStatus: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        textViewContent.isUserInteractionEnabled = false
        viewStatus.layer.cornerRadius = 3
    }

    func configure(log: LogProtocol) {
        guard let request = log as? LogRequest else {return}
        let formatDate = LogsSettings.shared.date ? LoggerFormat.formatDate(date: request.date) : ""
        let stringContent = "\(LogsSettings.shared.date ? "\(formatDate)\n" : "")[\(request.method)] \(request.url)"
        textViewContent.text = stringContent

        let attstr = NSMutableAttributedString(string: stringContent)

        attstr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white,
                            range: NSMakeRange(0, stringContent.characters.count))
        if LogsSettings.shared.date {
            let range = NSMakeRange(0, formatDate.characters.count)
            attstr.addAttribute(NSAttributedStringKey.foregroundColor, value: Color.mainGreen, range: range)
            attstr.addAttribute(NSAttributedStringKey.font, value: UIFont.boldSystemFont(ofSize: 12), range: range)
        }
        let range = NSMakeRange(formatDate.characters.count, request.method.characters.count + 2)
        attstr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.lightGray, range: range)
        attstr.addAttribute(NSAttributedStringKey.font, value: UIFont.boldSystemFont(ofSize: 17), range: range)
        textViewContent.attributedText = attstr

        labelCode.text = "\(request.code)"
        viewStatus.backgroundColor = request.colorCode
        labelCode.textColor = request.colorCode

        if request.errorClientDescription != nil && request.code == 0 {
            viewStatus.backgroundColor = UIColor.red
        }
    }
}
