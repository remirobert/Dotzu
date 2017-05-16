//
//  RequestDataHttpBodyTableViewCell.swift
//  Dotzu
//
//  Created by Remi Robert on 10/02/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class RequestDataHttpBodyTableViewCell: UITableViewCell, LogCellProtocol {

    @IBOutlet weak var textview: UITextView!


    override func awakeFromNib() {
        super.awakeFromNib()
        textview.isUserInteractionEnabled = false
        textview.textColor = UIColor.white
    }

    func configure(log: LogProtocol) {
        guard let request = log as? LogRequest else {return}
        guard let data = request.httpBody else {return}
        textview.text = "\(NSData(data:data).length) bytes"
    }
}
