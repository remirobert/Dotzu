//
//  DetailResponseBodyViewController.swift
//  exampleWindow
//
//  Created by Remi Robert on 29/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class DetailResponseBodyViewController: UIViewController {

    var viewmodel: LogResponseBodyViewModel?
    @IBOutlet weak var textview: UITextView!

    @IBAction func exit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func shareData(_ sender: Any) {
        guard let data = viewmodel?.format else {return}
        let controller = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        present(controller, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        textview.text = viewmodel?.format
    }
}
