//
//  EditViewController.swift
//  PhiHome
//
//  Created by liman on 09/12/2017.
//  Copyright © 2017 Phicomm. All rights reserved.
//

enum EditType {
    case url
    case request
    case header
}

import Foundation
import UIKit

class EditViewController: UITableViewController, UITextViewDelegate {
    
    @IBOutlet weak var saveItem: UIBarButtonItem!
    @IBOutlet weak var tableHeaderView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var textView: UITextView!
    
    let keyboardMan = KeyboardMan()
    
    var editType: EditType = .url//默认类型URL
    var httpModel: JxbHttpModel?
    var detailModel: NetworkDetailModel?
    
    //编辑过的url
    var editedURLString: String?
    //编辑过的content (request/header)
    var editedContent: String?
    
    var saveCallback:((JxbHttpModel?, NetworkDetailModel?) -> Void)?
    
    static func instanceFromStoryBoard() -> EditViewController {
        let storyboard = UIStoryboard(name: "Network", bundle: Bundle(for: DebugMan.self))
        return storyboard.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
    }
    
    //MARK: - tool
    
    //确定request格式(JSON/Form)
    func detectRequestSerializer() {
        guard let content = detailModel?.content else {
            detailModel?.requestSerializer = RequestSerializer(rawValue: 0)//默认JSON格式
            return
        }
        
        if let _ = content.stringToDictionary() {
            //JSON格式
            detailModel?.requestSerializer = RequestSerializer(rawValue: 0)
            segmentedControl.selectedSegmentIndex = 0
        }else{
            //Form格式
            detailModel?.requestSerializer = RequestSerializer(rawValue: 1)
            segmentedControl.selectedSegmentIndex = 1
        }
    }
    
    //MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = tableHeaderView
        saveItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: Color.mainGreen], for: .normal)
        textView.delegate = self
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        
        //判断类型 (默认类型URL)
        if detailModel?.title == "REQUEST" {
            editType = .request
        }
        if detailModel?.title == "HEADER" {
            editType = .header
        }
        
        //设置UI
        if editType == .request
        {
            self.title = "Edit REQUEST"
            tableView.tableHeaderView?.frame.size.height = 28
            tableView.tableHeaderView?.isHidden = false
            textView.text = detailModel?.content
            detectRequestSerializer()//确定request格式(JSON/Form)
        }
        if editType == .header
        {
            self.title = "Edit HEADER"
            tableView.tableHeaderView?.frame.size.height = 0
            tableView.tableHeaderView?.isHidden = true
            textView.text = detailModel?.headerFields?.dictionaryToString()
        }
        if editType == .url
        {
            self.title = "Edit URL"
            tableView.tableHeaderView?.frame.size.height = 0
            tableView.tableHeaderView?.isHidden = true
            textView.text = httpModel?.url.absoluteString
        }
        
        //键盘
        keyboardMan.postKeyboardInfo = { keyboardMan, keyboardInfo in
            switch keyboardInfo.action {
            case .show: break

            case .hide: break

            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textView.resignFirstResponder()
    }
    
    //MARK: - UITextViewDelegate
    func textViewDidChange(_ textView: UITextView)
    {
        tableView.beginUpdates()
        tableView.endUpdates()
        
        if editType == .url {
            editedURLString = textView.text
        }else{
            editedContent = textView.text
            detailModel?.content = textView.text
        }
    }
    
    //MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1000
    }
    
    //MARK: - target action
    @IBAction func save(_ sender: UIBarButtonItem) {
        
        if editType == .url
        {
            //step 1.   //检查URL
            guard var editedURLString = editedURLString else {
                UIAlertController.showError(title: "Not edited yet", controller: self)
                return
            }
            if !editedURLString.contains("http://") && !editedURLString.contains("https://") {
                editedURLString.insert(contentsOf: "http://", at: editedURLString.startIndex)
            }
            
            if editedURLString.isValidURL() {
                httpModel?.url = URL.init(string: editedURLString)
            }else{
                UIAlertController.showError(title: "URL is illegal", controller: self)
                return
            }
        }
        else
        {
            //step 2.   //检查HEADER, 检查REQUEST
            guard let editedContent = editedContent else {
                UIAlertController.showError(title: "Not edited yet", controller: self)
                return
            }
            guard let requestSerializer = detailModel?.requestSerializer else {return}//code never go here
            
            if editType == .header
            {
                guard let headerFields = editedContent.stringToDictionary() else {
                    UIAlertController.showError(title: "Format is illegal", controller: self)
                    return
                }
                detailModel?.headerFields = headerFields
                detailModel?.content = headerFields.description
            }
            else if editType == .request
            {
                if Int(requestSerializer.rawValue) == 0 {
                    //2.1 JSON
                    if editedContent.isValidJsonString() {
                        detailModel?.content = editedContent
                    }else{
                        UIAlertController.showError(title: "Format is illegal", controller: self)
                        return
                    }
                }
                if Int(requestSerializer.rawValue) == 1 {
                    //2.2 Form
                    if editedContent.isValidFormString() {
                        detailModel?.content = editedContent
                    }else{
                        UIAlertController.showError(title: "Format is illegal", controller: self)
                        return
                    }
                }
            }
        }
        
        //step 3.
        self.navigationController?.popViewController(animated: true)
        if let saveCallback = saveCallback {
            saveCallback(httpModel, detailModel)
        }
    }
    
    
    //能点击segmentedControl, 说明一定是在编辑request
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        guard let requestSerializer = detailModel?.requestSerializer, let textView = textView else {return}//code never go here
        
        
        if Int(requestSerializer.rawValue) == 0 {//原格式为JSON
            if sender.selectedSegmentIndex == 1 {//转换为Form
                
                if let formString = detailModel?.content?.jsonStringToFormString() {
                    textView.text = formString
                    self.textViewDidChange(textView)
                    detailModel?.requestSerializer = RequestSerializer(rawValue: 1)
                    detailModel?.content = textView.text
                }else{
                    sender.selectedSegmentIndex = 0
                    UIAlertController.showError(title: "Format is illegal", controller: self)
                    return
                }
            }
        }
        
        
        if Int(requestSerializer.rawValue) == 1 {//原格式为Form
            if sender.selectedSegmentIndex == 0 {//转换为JSON
                
                if let jsonString = detailModel?.content?.formStringToJsonString() {
                    textView.text = jsonString
                    self.textViewDidChange(textView)
                    detailModel?.requestSerializer = RequestSerializer(rawValue: 0)
                    detailModel?.content = textView.text
                }else{
                    sender.selectedSegmentIndex = 1
                    UIAlertController.showError(title: "Format is illegal", controller: self)
                    return
                }
            }
        }
    }
}
