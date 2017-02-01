//
//  ListLogViewModel.swift
//  exampleWindow
//
//  Created by Remi Robert on 23/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class ListLogDataSource<T>: NSObject, UITableViewDataSource where T: LogProtocol {

    fileprivate var logs = [T]()

    subscript(index: Int) -> T? {
        get {
            if index >= logs.count {
                return nil
            }
            return logs[index]
        }
    }

    var count: Int {
        return logs.count
    }

    var lastPath: IndexPath {
        return IndexPath(row: logs.count > 0 ? logs.count - 1 : 0, section: 0)
    }

    func reset() {
        logs.removeAll()
    }

    func reloadData() {
        logs = T.source() as? [T] ?? []
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = logs[indexPath.row]
        guard let cell = tableView.dequeueCell(cell: model.cell) as? LogCellProtocol else {
            return UITableViewCell()
        }
        cell.configure(log: model)
        return cell as? UITableViewCell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logs.count
    }
}
