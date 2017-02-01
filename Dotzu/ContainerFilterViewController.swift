//
//  ContainerFilterViewController.swift
//  exampleWindow
//
//  Created by Remi Robert on 22/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class ContainerFilterViewController: UIViewController {

    private var currentFilterController: FilterViewControllerProtocol?
    var state: ManagerListLogState!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var toolbar: UIToolbar!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.5, delay: 0.3, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        }, completion: nil)
    }

    @IBAction func resetFilter(_ sender: Any) {
        currentFilterController?.resetFilter()
        exitFilter()
    }

    @IBAction func exitFilter(_ sender: Any) {
        exitFilter()
    }

    @IBAction func exit(_ sender: Any) {
        exitFilter()
    }

    private func exitFilter() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let controller = state.controller as? UIViewController else {return}
        currentFilterController = controller as? FilterViewControllerProtocol
        addChildViewController(controller)
        controller.view.frame = view.bounds
        containerView.addSubview(controller.view)
        controller.didMove(toParentViewController: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.bringSubview(toFront: toolbar)
    }
}
