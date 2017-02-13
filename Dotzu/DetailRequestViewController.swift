//
//  DetailRequestViewController.swift
//  exampleWindow
//
//  Created by Remi Robert on 25/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

enum DetailRequestSection: String {
    case detail = ""
    case headers = "Headers"
    case httpBody = "HTTP post data sent"
    case bodyResponse = "Body Response"
    case error = "error"

    func cell(row: Int) -> UITableViewCell.Type {
        switch self {
        case .detail:
            return row == 0 ? LogNetworkTableViewCell.self : RequestLatencyTableViewCell.self
        case .headers:
            return RequestHeadersTableViewCell.self
        case .httpBody:
            return RequestDataHttpBodyTableViewCell.self
        case .bodyResponse:
            return ResponseDataTableViewCell.self
        case .error:
            return RequestErrorTableViewCell.self
        }
    }

    static func section(index: Int) -> DetailRequestSection {
        switch index {
        case 1:
            return .headers
        case 2:
            return .httpBody
        case 3:
            return .bodyResponse
        case 4:
            return .error
        default:
            return .detail
        }
    }

    static var count: Int {return 4}

    static func availableSections(log: LogRequest) -> [DetailRequestSection] {
        var sections = [DetailRequestSection]()

        sections.append(.detail)
        if log.errorClientDescription != nil {
            sections.append(.error)
        }
        if let headers = log.headers, headers.count > 0 {
            sections.append(.headers)
        }
        if log.httpBody != nil {
            sections.append(.httpBody)
        }
        if log.dataResponse != nil {
            sections.append(.bodyResponse)
        }
        return sections
    }
}

class DetailRequestViewController: UIViewController {

    var log: LogRequest!
    fileprivate var sections = [DetailRequestSection]()

    @IBOutlet weak var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        sections = DetailRequestSection.availableSections(log: log)

        tableview.registerCellWithNib(cell: LogNetworkTableViewCell.self)
        tableview.registerCellWithNib(cell: ResponseDataTableViewCell.self)
        tableview.registerCellWithNib(cell: RequestHeadersTableViewCell.self)
        tableview.registerCellWithNib(cell: RequestErrorTableViewCell.self)
        tableview.registerCellWithNib(cell: RequestLatencyTableViewCell.self)
        tableview.registerCellWithNib(cell: RequestDataHttpBodyTableViewCell.self)

        tableview.estimatedRowHeight = 50
        tableview.rowHeight = UITableViewAutomaticDimension
        tableview.dataSource = self
        tableview.delegate = self
    }

    fileprivate func initCellContent(cellType: UITableViewCell.Type) -> UITableViewCell {
        guard let cell = tableview.dequeueCell(cell: cellType) as? LogCellProtocol else {
            return UITableViewCell()
        }
        cell.configure(log: log!)
        return cell as? UITableViewCell ?? UITableViewCell()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? DetailResponseBodyViewController {
            guard let section = sender as? DetailRequestSection else {return}
            let viewmodel: LogResponseBodyViewModel!
            if section == .bodyResponse {
                guard let data = log.dataResponse else {return}
                viewmodel = LogResponseBodyViewModel(data: data as Data)
            } else {
                guard let data = log.httpBody else {return}
                viewmodel = LogResponseBodyViewModel(data: data as Data)
            }
            controller.viewmodel = viewmodel
        }
    }
}

extension DetailRequestViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let currentSection = sections[section]
        return currentSection.rawValue
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentSection = sections[indexPath.section]
        return initCellContent(cellType: currentSection.cell(row: indexPath.row))
    }
}

extension DetailRequestViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentSection = sections[indexPath.section]
        if currentSection == .bodyResponse || currentSection == .httpBody {
            performSegue(withIdentifier: "detailBodySegue", sender: currentSection)
        }
    }
}
