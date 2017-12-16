//
//  LogTableViewCell.swift
//  exampleWindow
//
//  Created by Remi Robert on 06/12/2016.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit

class LogTableViewCell: UITableViewCell {

    @IBOutlet weak var labelContent: UITextView!
    @IBOutlet weak var viewTypeLogColor: UIView!
    @IBOutlet weak var tagView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewTypeLogColor.layer.cornerRadius = 3
    }
    
    var model: Log? {
        didSet {
            guard let model = model else { return }
            
            labelContent.text = nil
            let format = LoggerFormat.format(log: model)
            labelContent.text = format.str
            labelContent.attributedText = format.attr
            viewTypeLogColor.backgroundColor = model.level.color
            
            //tag
            if model.isTag == true {
                tagView.isHidden = false
            }else{
                tagView.isHidden = true
            }
        }
    }
}
