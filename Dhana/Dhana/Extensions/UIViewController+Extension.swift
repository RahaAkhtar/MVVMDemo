//
//  UIViewController+Extension.swift
//  Dhana
//
//  Created by Muhammad  Akhtar on 3/15/21.
//  Copyright © 2021 Akhtar. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation
import CoreLocation
import MapKit


let notificationButton: UIButton = UIButton (type: UIButton.ButtonType.custom)
let notificationBarButton = UIBarButtonItem(customView: notificationButton)

extension UIViewController {
    
    
    var hasTopNotch: Bool {
        var result = false
        if #available(iOS 13.0,  *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let delegate = windowScene.delegate as? SceneDelegate {
                    if let window = delegate.window {
                        result = window.safeAreaInsets.top > 20
                    }
                }
            }
//            result = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0 > 20
//            result = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0 > 20
        }else{
            if #available(iOS 11.0, *) {
                result = UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
            } else {
                // Fallback on earlier versions
                result = false
            }
        }
        return result
    }
    
    var hasBottomNotch: Bool {
        var result = false
        if #available(iOS 13.0,  *) {
            result = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0 > 20
        }else{
            if #available(iOS 11.0, *) {
                result = UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0 > 20
            } else {
                // Fallback on earlier versions
                result = false
            }
        }
        return result
    }
    
    var topMostViewController: UIViewController {
        switch self {
        case is UINavigationController:
            return (self as! UINavigationController).visibleViewController?.topMostViewController ?? self
        case is UITabBarController:
            return (self as! UITabBarController).selectedViewController?.topMostViewController ?? self
        default:
            return presentedViewController?.topMostViewController ?? self
        }
    }
    
    var isModal: Bool {
        
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
    
//    func showProgressHud(title:String = K.LOADING_KEY) -> Void {
//        let progressHud = MBProgressHUD.showAdded(to: view, animated: true)
//        progressHud.label.text = title
//    }
//
//    func hideProgressHud() -> Void {
//        DispatchQueue.main.async {
//            MBProgressHUD.hide(for: self.view , animated: true)
//        }
//    }
    
    func addBackButtonOnly(){
        let button: UIButton = UIButton (type: UIButton.ButtonType.custom)
        
        //button.leftImage(image: Icons.RECTANGLE_PLACEHOLDER, renderMode: UIImage.RenderingMode.alwaysTemplate)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 40)
        button.tintColor = .black
        
        button.contentMode = .left
        button.addTarget(self, action: #selector(backButtonPressed(btn:)), for: UIControl.Event.touchUpInside)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: button.imageView!.image!.size.width / 2)
        button.contentHorizontalAlignment = .left
        button.imageView?.contentMode = .scaleAspectFit
        
        let barButton = UIBarButtonItem(customView: button)
        if let navcontroller = self.navigationController{
            navcontroller.navigationItem.leftBarButtonItem = barButton
        }else{
            self.navigationItem.leftBarButtonItem = barButton
        }
    }
    
    func openMapForPlace(latitude:CLLocationDegrees,longitude:CLLocationDegrees,placename:String) {
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion.init(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = placename
        mapItem.openInMaps(launchOptions: options)
        
    }
    
    func openGoogleMap(lat:Double, long:Double) {
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.open(URL(string:"comgooglemaps://?center=\(lat),\(long)&zoom=14&views=traffic&q=\(lat),\(long)")!, options: [:], completionHandler: nil)
        } else {
            if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(lat),\(long)&directionsmode=driving") {
                UIApplication.shared.open(urlDestination)
            }
        }
    }
    
    func openMapSelectionOption(latitude:Double, longitude:Double) {
        let appleURL = "http://maps.apple.com/?daddr=\(latitude),\(longitude)"
        let googleURL = "comgooglemaps://?daddr=\(latitude),\(longitude)&directionsmode=driving"
        
        let googleItem = ("Google Map", URL(string:googleURL)!)
        let appleItem = ("Apple Maps", URL(string:appleURL)!)
        var installedNavigationApps = [appleItem]
        
        if UIApplication.shared.canOpenURL(googleItem.1) {
            installedNavigationApps.append(googleItem)
        }
        
        if installedNavigationApps.count == 1 {
            UIApplication.shared.open(appleItem.1, options: [:], completionHandler: nil)
        }else{
            let alert = UIAlertController(title: "Selection", message: "Select Navigation App", preferredStyle: .actionSheet)
            for app in installedNavigationApps {
                let button = UIAlertAction(title: app.0, style: .default, handler: { _ in
                    UIApplication.shared.open(app.1, options: [:], completionHandler: nil)
                })
                alert.addAction(button)
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancel)
            present(alert, animated: true)
        }
    }
        
    
    @objc func backButtonPressed(btn:UIButton) {
        if let navController = navigationController {
            if navController.viewControllers.count > 1 {
                self.navigationController?.popViewController(animated: true)
            } else if isModal {
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func alertMessage(title: String, alertMessage:String, action: (() -> Void)?)
    {
        if alertMessage.lowercased().contains("cancelled") || alertMessage.lowercased().contains("caused connection abort") || alertMessage.contains("The Internet connection appears to be offline."){
            return
        }
        
        DispatchQueue.main.async {
//            self.hideProgressHud()
            self.confirmationMessage(title: title, message: alertMessage, buttonYesTitle: "Ok", buttonCancelTitle: "", hideCancelButton: true, actionYes: {
                action?()
            }, actionCancel: {})
//            let myAlert = UIAlertController(title:title, message:alertMessage, preferredStyle: UIAlertController.Style.alert)
//            let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
//                UIAlertAction in
//                action?()
//            }
//            myAlert.addAction(okAction);
//            self.present(myAlert, animated:true, completion:nil)
        }
    }
    
    func showToast(message : String, font: UIFont = .systemFont(ofSize: 12.0)) {
//        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        let toastLabel = UILabel(frame: CGRect(x: 10, y: self.view.frame.size.height-120, width: self.view.frame.width - 20, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1, delay: 3.0, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func openShareSheet(text:String?,image:UIImage?,link:String?, controller:UIViewController?) -> Void {
        
        var shareAll = Array<Any>()
        if let message = text{
            shareAll.append(message)
        }
        if let img = image {
            shareAll.append(img)
        }
        if let lnk = link{
            if let url = NSURL(string: lnk){
                shareAll.append(url)
            }
        }
        
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
//            self.sharingDone(controller: controller)
        }
        activityViewController.popoverPresentationController?.sourceView = self.view
        present(activityViewController, animated: true, completion: nil)
    }
    
    func openCameraWithPermision(type: cameraType = .image, isFront : Bool = false, delegateController:UIViewController) -> Void {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            
            let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            switch (authStatus){
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted {
                        
                        DispatchQueue.main.async {
                            let imagePicker = UIImagePickerController()
                            imagePicker.delegate = delegateController.self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                            imagePicker.allowsEditing = true
                            imagePicker.videoMaximumDuration = TimeInterval(20.0)
                            imagePicker.sourceType = .camera
                            if isFront {
                                imagePicker.cameraDevice = .front
                            } else {
                                imagePicker.cameraDevice = .rear
                            }
                            imagePicker.sourceType = UIImagePickerController.SourceType.camera
                            if type == .image {
                                imagePicker.mediaTypes = [kUTTypeImage as String]
                            } else {
                                imagePicker.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String,kUTTypeVideo as String,kUTTypeAVIMovie as String,kUTTypeMPEG as String,kUTTypeMPEG4 as String]
                            }
                            imagePicker.modalPresentationStyle = .overFullScreen
                            delegateController.present(imagePicker, animated: true, completion: nil)
                        }
                        
                        
                    }
                }
            case .restricted:
                confirmationMessage(title: "Unable to access the Camera", message: Alerts.CAMERA_PRIVACY_SETTINGS_TEXT, buttonYesTitle: K.SETTINGS_TEXT, buttonCancelTitle: K.CANCEL_TEXT, actionYes: {
                    
                    if let url = URL(string:UIApplication.openSettingsURLString) {
                        if UIApplication.shared.canOpenURL(url) {
                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            } else {
                                UIApplication.shared.open(url)
                            }
                        }
                    }
                }) {
                }
            case .denied:
                confirmationMessage(title: "Unable to access the Camera", message: Alerts.CAMERA_PRIVACY_SETTINGS_TEXT, buttonYesTitle: K.SETTINGS_TEXT, buttonCancelTitle: K.CANCEL_TEXT, actionYes: {
                    
                    if let url = URL(string:UIApplication.openSettingsURLString) {
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    }
                }) {
                }
            case .authorized:
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = delegateController.self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                imagePicker.allowsEditing = true
                imagePicker.videoMaximumDuration = TimeInterval(20.0)
                imagePicker.sourceType = .camera
                if isFront {
                    imagePicker.cameraDevice = .front
                } else {
                    imagePicker.cameraDevice = .rear
                }
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                if type == .image {
                    imagePicker.mediaTypes = [kUTTypeImage as String]
                } else {
                    imagePicker.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String,kUTTypeVideo as String,kUTTypeAVIMovie as String,kUTTypeMPEG as String,kUTTypeMPEG4 as String]
                }
                imagePicker.modalPresentationStyle = .overFullScreen
                delegateController.present(imagePicker, animated: true, completion: nil)
            }
        }else{
            alertMessage(title: K.ALERT, alertMessage: Alerts.CAMERA_NOT_SUPPORTED_TEXT, action: {})
        }
    }
    
    func confirmationMessage(title: String, message: String?,attributedMessage:NSAttributedString = NSAttributedString(string: ""), buttonYesTitle: String, buttonCancelTitle: String, hideCancelButton:Bool = false, isSwitchColors:Bool = false, actionYes: @escaping (() -> Void), actionCancel: @escaping (() -> Void)) {
        
        let control = Storyboards.POPUPS.instantiateViewController(withIdentifier: CustomAlertPopupVC.className) as! CustomAlertPopupVC
        control.titleString = title
        control.message = message
        control.attributedMessage = attributedMessage
        control.okButtonTitle = buttonYesTitle
        control.cancelButtonTitle = buttonCancelTitle
        control.hideCancelButton = hideCancelButton
        control.isSwitchColors = isSwitchColors
        control.okAction = {
            actionYes()
        }
        
        control.cancelAction = {
            actionCancel()
        }
        control.modalPresentationStyle = .overFullScreen
        self.present(control, animated: false, completion: nil)
        
    }
    
//    func openCountryPicker(completion: @escaping (String,String,String) -> Void) -> Void {
//        let picker = ADCountryPicker(style: .grouped)
//        picker.showCallingCodes = true
//        picker.showFlags = true
//        picker.pickerTitle = "Select a Country"
//        picker.defaultCountryCode = "US"
//        picker.alphabetScrollBarTintColor = ThemeManager.shared.appTheme.BLACK_COLOR
//        picker.alphabetScrollBarBackgroundColor = UIColor.clear
//        picker.closeButtonTintColor = ThemeManager.shared.appTheme.BLACK_COLOR
//        picker.font = Fonts.HELVETICA_REGULAR_16
//        picker.flagHeight = 40
//        picker.hidesNavigationBarWhenPresentingSearch = false
//        picker.searchBarBackgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        picker.didSelectCountryWithCallingCodeClosure = { name, code, dialCode in
//            completion(name, code, dialCode)
//        }
//        self.navigationController?.pushViewController(picker, animated: true)
//    }
}
