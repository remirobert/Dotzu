//
//  LogTableViewCell.swift
//  exampleWindow
//
//  Created by Remi Robert on 06/12/2016.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit

class LogTableViewCell: UITableViewCell, LogCellProtocol {

    @IBOutlet weak var labelContent: UITextView!
    @IBOutlet weak var viewTypeLogColor: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        viewTypeLogColor.layer.cornerRadius = 3
    }

    func configure(log: LogProtocol) {
        guard let log = log as? Log else { return }
        labelContent.text = nil
        let format = LoggerFormat.format(log: log)
        labelContent.text = format.str
        labelContent.attributedText = format.attr
        viewTypeLogColor.backgroundColor = log.level.color
    }
}
