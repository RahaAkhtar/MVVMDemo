//
//  CustomAlertPopupVC.swift
//  Dhana
//
//  Created by Muhammad  Akhtar on 3/15/21.
//  Copyright © 2021 Akhtar. All rights reserved.
//

import UIKit

class CustomAlertPopupVC: UIViewController {
    
   
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet var horizontalSeperatorView: UIView!
    @IBOutlet var verticalSepratorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoDetailLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!

    @IBOutlet weak var cancelButton: UIButton!
    var titleString:String = ""
    var message:String?
    var attributedMessage = NSAttributedString.init(string: "")
    var cancelButtonTitle:String = "Cancel"
    var okButtonTitle:String = "Ok"
    var hideCancelButton:Bool = true
    var okAction:(() -> Void)?
    var cancelAction:(() -> Void)?
    var isSwitchColors = false

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleString
        if let message = message {
            infoDetailLabel.text = message
        }else{
            infoDetailLabel.attributedText = attributedMessage
        }
        if isSwitchColors {
            okButton.setTitleColor(.red, for: .normal)
            cancelButton.setTitleColor(.black, for: .normal)
        }else{
            okButton.setTitleColor(.black, for: .normal)
            cancelButton.setTitleColor(.red, for: .normal)
        }
        okButton.setTitle(okButtonTitle, for: .normal)
        cancelButton.setTitle(cancelButtonTitle, for: .normal)
        cancelButton.isHidden = hideCancelButton
        verticalSepratorView.isHidden = hideCancelButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        horizontalSeperatorView.backgroundColor = .lightGray
        verticalSepratorView.backgroundColor = .lightGray
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.bgView.backgroundColor = .black
            
        }, completion: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
            self.bgView.backgroundColor = .black //ThemeManager.shared.appTheme.BLACK_COLOR.withAlphaComponent(0.0)
        }, completion: nil)
    }
    
    @IBAction func okButtonWasPressed(_ sender: UIButton) {
        dismiss(animated: true) {
             self.okAction?()
        }
    }
    
    @IBAction func cancelButtonWasPressed(_ sender: UIButton) {
        dismiss(animated: true) {
            self.cancelAction?()
        }
    }
}
