//
//  UIView+Extension.swift
//  Dhana
//
//  Created by Muhammad  Akhtar on 3/15/21.
//  Copyright © 2021 Akhtar. All rights reserved.
//

import UIKit

extension UIView {
    
    func roundWithCorners(corners:CACornerMask, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = corners
        } else {
            print("not able to round specific corner")
        }
    }
    
    func addShadow(color:UIColor, opacity:Float, radius:CGFloat) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }
    
    func roundedUIView(withRadius radius: CGFloat){
        layer.cornerRadius = radius
        clipsToBounds = true
        layer.masksToBounds = true
    }
    
    func simpleRound() -> Void {
        layer.cornerRadius = self.frame.height/2
        clipsToBounds = true
    }
    
    func roundedUIView(withRadius radius: CGFloat,withBorderColor color:UIColor,borderWidth:CGFloat = 1){
        layer.cornerRadius = radius
        clipsToBounds = true
        layer.borderColor = color.cgColor
        layer.borderWidth = borderWidth
    }
    
    func rotateWithAnimation(circleTime: Double) {
        UIView.animate(withDuration: circleTime/2, delay: 0.0, options: .curveLinear, animations: {
            self.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }, completion: { finished in
            UIView.animate(withDuration: circleTime/2, delay: 0.0, options: .curveLinear, animations: {
                self.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi*2))
            }, completion: { finished in
                self.rotateWithAnimation(circleTime: circleTime)
            })
        })
    }

}
