//
//  RequestLatencyTableViewCell.swift
//  Dotzu
//
//  Created by Remi Robert on 08/02/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class RequestLatencyTableViewCell: UITableViewCell, LogCellProtocol {
    @IBOutlet weak var labelLatency: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(log: LogProtocol) {
        guard let log = log as? LogRequest else {return}
        let interval = log.duration ?? 0
        let ms = Int((interval.truncatingRemainder(dividingBy: 1)) * 1000)
        labelLatency.text = "\(ms)ms"
    }
}
