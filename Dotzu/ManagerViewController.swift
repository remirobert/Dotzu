//
//  ManagerViewController.swift
//  exampleWindow
//
//  Created by Remi Robert on 02/12/2016.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit

class ManagerViewController: UIViewController, LogHeadViewDelegate {

    var button = LogHeadView(frame: CGRect(origin: LogHeadView.originalPosition, size: LogHeadView.size))

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.view.addSubview(self.button)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.button.updateOrientation(newSize: size)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.button.delegate = self
        self.view.backgroundColor = UIColor.clear
        let selector = #selector(ManagerViewController.panDidFire(panner:))
        let panGesture = UIPanGestureRecognizer(target: self, action: selector)
        button.addGestureRecognizer(panGesture)
    }

    func didTapButton() {
        Dotzu.sharedManager.displayedList = true
        let storyboard = UIStoryboard(name: "Manager", bundle: Bundle(for: ManagerViewController.self))
        guard let controller = storyboard.instantiateInitialViewController() else {
            return
        }
        self.present(controller, animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        Dotzu.sharedManager.displayedList = false
    }

    @objc func panDidFire(panner: UIPanGestureRecognizer) {

        if panner.state == .began {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
                self.button.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }, completion: nil)
        }

        let offset = panner.translation(in: view)
        panner.setTranslation(CGPoint.zero, in: view)
        var center = button.center
        center.x += offset.x
        center.y += offset.y
        button.center = center

        if panner.state == .ended || panner.state == .cancelled {

            let location = panner.location(in: view)
            let velocity = panner.velocity(in: view)

            var finalX: Double = 30
            var finalY: Double = Double(location.y)

            if location.x > UIScreen.main.bounds.size.width / 2 {
                finalX = Double(UIScreen.main.bounds.size.width) - 30.0
                self.button.changeSideDisplay(left: false)
            } else {
                self.button.changeSideDisplay(left: true)
            }

            let horizentalVelocity = abs(velocity.x)
            let positionX = abs(finalX - Double(location.x))

            let velocityForce = sqrt(pow(velocity.x, 2) * pow(velocity.y, 2))

            let durationAnimation = (velocityForce > 1000.0) ? min(0.3, positionX / Double(horizentalVelocity)) : 0.3

            if velocityForce > 1000.0 {
                finalY += Double(velocity.y) * durationAnimation
            }

            if finalY > Double(UIScreen.main.bounds.size.height) - 50 {
                finalY = Double(UIScreen.main.bounds.size.height) - 50
            } else if finalY < 50 {
                finalY = 50
            }

            UIView.animate(withDuration: durationAnimation * 5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 6,
                           options: UIViewAnimationOptions.allowUserInteraction,
                           animations: {
                            self.button.center = CGPoint(x: finalX, y: finalY)
                            self.button.transform = CGAffineTransform.identity
                }, completion: nil)
        }
    }

    func shouldReceive(point: CGPoint) -> Bool {
        if Dotzu.sharedManager.displayedList {
            return true
        }
        return self.button.frame.contains(point)
    }
}
