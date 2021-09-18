//
//  SignUpNavigationController.swift
//  Dhana
//
//  Created by Muhammad  Akhtar on 3/15/21.
//  Copyright © 2021 Akhtar. All rights reserved.
//

import UIKit

class SignUpNavigationController: UINavigationController,UIGestureRecognizerDelegate,UINavigationControllerDelegate {

    var isPushingViewController = false

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        interactivePopGestureRecognizer?.delegate = self
        interactivePopGestureRecognizer?.isEnabled = true
        navigationBar.shadowImage = UIImage()

    }

    override var shouldAutorotate : Bool {
        return true
    }

    override var prefersStatusBarHidden : Bool {
        return UIApplication.shared.statusBarOrientation.isLandscape && UI_USER_INTERFACE_IDIOM() == .phone
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }

    override var preferredStatusBarUpdateAnimation : UIStatusBarAnimation {
        return .fade
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        isPushingViewController = true
        super.pushViewController(viewController, animated: animated)
    }

    //MARK: UIGestureRecognizerDelegate
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if viewControllers.count > 1 {
            return true
        } else {
            return false
        }
    }

    //MARK: UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        isPushingViewController = false
    }
}
