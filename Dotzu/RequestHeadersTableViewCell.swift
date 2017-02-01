//
//  RequestHeadersTableViewCell.swift
//  exampleWindow
//
//  Created by Remi Robert on 25/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class RequestHeadersTableViewCell: UITableViewCell, LogCellProtocol {

    @IBOutlet weak var textview: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        textview.isUserInteractionEnabled = false
    }

    func configure(log: LogProtocol) {
        guard let log = log as? LogRequest else {return}
        textview.text = nil
        guard let headers = log.headers else {return}

        let string = NSMutableString()
        string.append("[\n")
        for (key, value) in headers {
            string.append("  \(key) : \(value)\n")
        }
        string.append("]")
        textview.text = string as String
    }
}
