//
//  LogBadgeView.swift
//  exampleWindow
//
//  Created by Remi Robert on 20/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class LogBadgeView: UILabel {

    private var count: Int = 0
    private var obsResetBadge: NotificationObserver<Void>!
    private var obsRefreshLogs: NotificationObserver<Void>!

    override func sizeToFit() {
        super.sizeToFit()
        frame.size.width += 15
        frame.size.height += 5
    }

    private func initText() {
        textColor = UIColor.white
        textAlignment = .center
        font = UIFont.boldSystemFont(ofSize: 17)
        text = "\(count)"
    }

    private func initBadge() {
        backgroundColor = UIColor.red
        layer.cornerRadius = (bounds.size.height + 5) / 2
        layer.masksToBounds = true
        isHidden = true
        initText()

        obsRefreshLogs = NotificationObserver(notification: LogNotificationApp.refreshLogs, block: { [weak self] _ in
            guard let weakSelf = self else { return }
            weakSelf.count += 1
            DispatchQueue.main.async {
                weakSelf.updateText()
            }
        })

        obsResetBadge = NotificationObserver(notification: LogNotificationApp.resetCountBadge, block: { [weak self] _ in
            guard let weakSelf = self else { return }
            weakSelf.count = 0
            DispatchQueue.main.async {
                weakSelf.updateText()
            }
        })
    }

    private func updateText() {
        if count == 0 {
            isHidden = true
            return
        }
        isHidden = false
        text = "\(count)"
        sizeToFit()
        layer.cornerRadius = frame.size.height / 2
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initBadge()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initBadge()
    }
}
