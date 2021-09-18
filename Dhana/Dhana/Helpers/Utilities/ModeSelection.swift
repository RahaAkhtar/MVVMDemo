//
//  ModeSelection.swift
//  Dhana
//
//  Created by Muhammad  Akhtar on 3/15/21.
//  Copyright © 2021 Akhtar. All rights reserved.
//

import Foundation
import UIKit

class ModeSelection {
    static let instance = ModeSelection()
    
    
    func loginMode() -> Void {
        if #available(iOS 13.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let delegate = windowScene.delegate as? SceneDelegate {
                    if let window = delegate.window {
                        let rootVC = Storyboards.MAIN.instantiateViewController(withIdentifier: DashboardNavigationController.className)
                        window.rootViewController = rootVC
                        window.makeKeyAndVisible()
                    }
                }
            }
        }
    }
    
    func signupMode() -> Void {
        if #available(iOS 13.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let delegate = windowScene.delegate as? SceneDelegate {
                    if let window = delegate.window {
                        let rootVC = Storyboards.SIGNUP.instantiateViewController(withIdentifier: SignUpNavigationController.className)
                        window.rootViewController = rootVC
                        window.makeKeyAndVisible()
                    }
                }
            }
        }
    }
    
}





//if let delegate = UIApplication.shared.delegate as? AppDelegate {
//    if let window = delegate.window {
//        let rootVC = Storyboards.SIGNUP.instantiateViewController(withIdentifier: "TourPageViewController")
//        window.rootViewController = rootVC
//        window.makeKeyAndVisible()
//    }
//}
