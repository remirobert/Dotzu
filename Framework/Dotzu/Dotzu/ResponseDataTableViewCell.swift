//
//  DetailContentTableViewCell.swift
//  exampleWindow
//
//  Created by Remi Robert on 25/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class ResponseDataTableViewCell: UITableViewCell, LogCellProtocol {

    @IBOutlet weak var textview: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        textview.isUserInteractionEnabled = false
        textview.textColor = UIColor.white
    }

    func configure(log: LogProtocol) {
        guard let request = log as? LogRequest else {return}
        guard let data = request.dataResponse else {return}
        textview.text = "\(data.length) bytes"
    }
}
