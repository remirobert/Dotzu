//
//  LogManager.swift
//  exampleWindow
//
//  Created by Remi Robert on 17/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation

enum StoreManagerType: String {
    case log = "logs"
    case network = "network"
    case crash = "crashs"
}

class StoreManager<T> where T: NSCoding {

    private let store: StoreManagerType

    init(store: StoreManagerType) {
        self.store = store
    }

    private func archiveLogs(logs: [T]) {
        let dataArchive = NSKeyedArchiver.archivedData(withRootObject: logs)
        UserDefaults.standard.set(dataArchive, forKey: store.rawValue)
        UserDefaults.standard.synchronize()
    }

    func add(log: T) {
        var logs = self.logs()
        logs.append(log)
        archiveLogs(logs: logs)
    }

    func save(logs: [T]) {
        archiveLogs(logs: logs)
    }

    func logs() -> [T] {
        guard let data = UserDefaults.standard.object(forKey: store.rawValue) as? NSData else {return []}
        do {
            let dataArchive = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
            return dataArchive as? [T] ?? []
        } catch {
            return []
        }
    }

    func reset() {
        UserDefaults.standard.removeObject(forKey: store.rawValue)
        UserDefaults.standard.synchronize()
    }
}
