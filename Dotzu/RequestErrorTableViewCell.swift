//
//  RequestErrorTableViewCell.swift
//  exampleWindow
//
//  Created by Remi Robert on 25/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class RequestErrorTableViewCell: UITableViewCell, LogCellProtocol {

    @IBOutlet weak var textview: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        textview.isUserInteractionEnabled = false
    }

    func configure(log: LogProtocol) {
        guard let log = log as? LogRequest else {return}
        textview.text = log.errorClientDescription
    }
}
