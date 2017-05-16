//
//  ManagerListLogState.swift
//  exampleWindow
//
//  Created by Remi Robert on 27/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

enum ManagerListLogState: Int {
    case logs
    case network

    var controller: FilterViewControllerProtocol? {
        let storyboard = UIStoryboard(name: "Logs", bundle: Bundle(for: Dotzu.self))
        let controller: UIViewController
        switch self {
        case .logs:
            controller = storyboard.instantiateViewController(withIdentifier: "FilterLogTableViewController")
        case .network:
            controller = storyboard.instantiateViewController(withIdentifier: "FilterNetworkTableViewController")
        }
        return controller as? FilterViewControllerProtocol
    }
}
