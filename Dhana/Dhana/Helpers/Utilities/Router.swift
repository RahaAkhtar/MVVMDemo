//
//  Router.swift
//  Dhana
//
//  Created by Muhammad  Akhtar on 3/15/21.
//  Copyright © 2021 Akhtar. All rights reserved.
//

import UIKit
import AVFoundation

class Router {
    
    static let shared = Router()
    
    func openNotificationViewController(controller:UIViewController) -> Void {
        let control = Storyboards.SIGNUP.instantiateViewController(withIdentifier: SignupViewController.className) as! SignupViewController
        control.addBackButtonOnly()
        controller.show(control, sender: self)
    }
    
    
//    func openQRGenerationWaitPopupVC(profileImage: UIImage?, controller:UIViewController) -> Void {
//        let control = Storyboards.POPUPS.instantiateViewController(withIdentifier: QRGenerationWaitPopupVC.className) as! QRGenerationWaitPopupVC
//        control.delegate = controller.self as? QRGenerationWaitPopupVCDelegate
//        control.profileImage = profileImage
//        controller.present(getNavigationController(controller: control), animated: true, completion: nil)
//    }
    
    
}
