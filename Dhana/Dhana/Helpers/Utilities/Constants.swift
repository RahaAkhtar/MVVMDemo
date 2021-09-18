//
//  Constants.swift
//  Dhana
//
//  Created by Muhammad  Akhtar on 3/15/21.
//  Copyright © 2021 Akhtar. All rights reserved.
//

import Foundation


import Foundation
import UIKit

typealias EmptyCompletionHandler = (()->())
typealias ImageCompletionHandler = ((UIImage)->())
//MARK: - STORYBOARDS

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height


var userId: String {
    if let profile = ProfileDetails.instance.getProfileDetails() {
        return profile.userId
    } else {
        return ""
    }
}


var isFirstLaunch : Bool {
    if let val = UserDefaults.standard.value(forKey: UserDefaultKeys.isFirstLaunch) as? Bool {
        return val
    }
    return true
}

var isUserLogin : Bool {
    if let val = UserDefaults.standard.value(forKey: UserDefaultKeys.isUserLogin) as? Bool {
        return val
    }
    return false
}


var isNetworkConnected: Bool {
    let isConnected = ReachabilityTest.isConnectedToNetwork()
    if isConnected {
        return true
    }else{
        return false
    }
}

//let CONSTANT_HOURS_LIST = ["1 hr","1.5 hr","2 hr","2.5 hr","3 hr","3.5 hr","4 hr","4.5 hr","5 hr","5.5 hr","6 hr"]


struct Storyboards {
    static let MAIN = UIStoryboard(name: "Main", bundle: nil)
    static let SIGNUP = UIStoryboard(name: "Signup", bundle: nil)
    static let POPUPS = UIStoryboard(name: "Popups", bundle: nil)
    static let PROFILE = UIStoryboard(name: "Profile", bundle: nil)
}

struct Fonts {
    static let HELVETICA_BOLD_12 = UIFont(name: "Helvetica-Bold", size: 12)!
    static let HELVETICA_BOLD_14  = UIFont(name: "Helvetica-Bold", size: 14)!
    static let HELVETICA_BOLD_15 = UIFont(name: "Helvetica-Bold", size: 15)!
    static let HELVETICA_BOLD_16 = UIFont(name: "Helvetica-Bold", size: 16)!
    static let HELVETICA_BOLD_17 = UIFont(name: "Helvetica-Bold", size: 17)!
    static let HELVETICA_BOLD_18 = UIFont(name: "Helvetica-Bold", size: 18)!
    static let HELVETICA_BOLD_19 = UIFont(name: "Helvetica-Bold", size: 19)!
    static let HELVETICA_BOLD_20 = UIFont(name: "Helvetica-Bold", size: 20)!
    static let HELVETICA_BOLD_30 = UIFont(name: "Helvetica-Bold", size: 30)!

    static let HELVETICA_REGULAR_12 = UIFont(name: "Helvetica", size: 12)!
    static let HELVETICA_REGULAR_14 = UIFont(name: "Helvetica", size: 14)!
    static let HELVETICA_REGULAR_15 = UIFont(name: "Helvetica", size: 15)!
    static let HELVETICA_REGULAR_16 = UIFont(name: "Helvetica", size: 16)!
    static let HELVETICA_REGULAR_17 = UIFont(name: "Helvetica", size: 17)!
    static let HELVETICA_REGULAR_18 = UIFont(name: "Helvetica", size: 18)!
    static let HELVETICA_REGULAR_19 = UIFont(name: "Helvetica", size: 19)!
    static let HELVETICA_REGULAR_20 = UIFont(name: "Helvetica", size: 20)!
    static let HELVETICA_REGULAR_21 = UIFont(name: "Helvetica", size: 21)!
    static let HELVETICA_REGULAR_22 = UIFont(name: "Helvetica", size: 22)!
    static let HELVETICA_REGULAR_23 = UIFont(name: "Helvetica", size: 23)!
    static let HELVETICA_REGULAR_24 = UIFont(name: "Helvetica", size: 24)!
    static let HELVETICA_REGULAR_25 = UIFont(name: "Helvetica", size: 25)!
    static let HELVETICA_REGULAR_26 = UIFont(name: "Helvetica", size: 26)!

    static let HELVETICA_LIGHT_15 = UIFont(name: "Helvetica-Light", size: 15)!
    
}

struct Icons {
    static let RECTANGLE_PLACEHOLDER = UIImage(named: "iconname")
}

struct IconString {
    static let TOUR_TOP_IMAGE1 = "tour_top_image1"
    static let TOUR_TOP_IMAGE2 = "tour_top_image2"
    static let TOUR_TOP_IMAGE3 = "tour_top_image3"
    static let TOUR_TOP_IMAGE4 = "tour_top_image4"
    static let TOUR_TOP_IMAGE5 = "tour_top_image5"
    static let TOUR_TOP_IMAGE6 = "tour_top_image6"
    static let TOUR_TOP_IMAGE7 = "tour_top_image7"
    static let TOUR_TOP_IMAGE8 = "tour_top_image8"
    static let TOUR_TOP_IMAGE9 = "tour_top_image9"
    static let TOUR_TOP_IMAGE10 = "tour_top_image10"
    static let TOUR_TOP_IMAGE11 = "tour_top_image11"

}

struct TourImages {
    static let TOP_IMAGE = UIImage(named: "tour_top_image")!
}


struct Alerts {
    static let EMPTY_PHONE_NUMBER = "Please Enter Phone Number."
    static let EMPTY_OLD_PHONE_NUMBER = "Please Enter Old Phone Number."
    static let EMPTY_NEW_PHONE_NUMBER = "Please Enter New Phone Number."
    static let SAME_PHONE_NUMBER = "Same Phone Number"

    static let EMPTY_COUNTRY_CODE = "Please Enter Country Code."
    static let EMPTY_VERIFICATION_CODE = "Please Enter Valid Code."
    static let EMPTY_PASSWORD = "Please Enter Password."
    static let PASSWORD_LENGTH_8 = "password must be 8 characters"
    static let CURRENT_PASSWORD_WRONG = "Your password is wrong."
    static let NEW_PASSWORD_LENGTH_8 = "New password must be 8 characters"
    static let CONFIRM_PASSWORD_LENGTH_8 = "confirm password must be 8 characters."
    static let EMPTY_CONFIRM_PASSWORD = "Please Enter Confirm Password."
    static let EMPTY_OLD_PASSWORD = "Please Enter old Password."
    static let EMPTY_NEW_PASSWORD = "Please Enter new Password."
    static let PASSWORD_NOT_MATCH = "Password not match."
    static let SAME_PASSWORD = "Password cannot be same."
    static let NUMBER_NOT_MATCH = "Phone Number not match."
    static let PASSWORD_LENGTH_VALIDATION = "Password Must Equal or Greater than 8 Characters."
    static let NUMBER_LENGTH_VALIDATION = "Please Enter Valid Number."
    static let EMPTY_FIRST_NAME = "Please Enter First Name."
    static let EMPTY_LAST_NAME = "Please Enter Last Name."
    static let EMPTY_COMPANY_NAME = "Please Enter Company Name."
    static let EMPTY_EMAIL_ADDRESS = "Please Enter Email."
    static let VERIFY_EMAIL_ADDRESS = "Please Verify Email."
    static let EMPTY_COUNTRY = "Please Select Country."
    static let EMPTY_STATE = "Please Select State."
    static let EMPTY_CITY = "Please Select City."
    static let EMPTY_ZIP = "Please Enter Zip code."
    static let EMPTY_ADDRESS = "Please Enter Address."
    static let INVALID_EMAIL_ADDRESS = "Please Enter Valid Email."
    static let EMPTY_GENDER = "Please Enter Gender."
    static let EMPTY_DOB = "Please Enter date of birth."
    static let EMPTY_COMPANY = "Please Enter Company name"
    static let UPLOAD_MEDIA_ERROR = "Please Upload photo"
    static let UPLOAD_MEDIA_UPLOAD_WAIT_ERROR = "Wait, your media is still uploading..."
    static let CAMERA_NOT_SUPPORTED_TEXT = "Camera not supported"
    static let CAMERA_PRIVACY_SETTINGS_TEXT = "To enable access, go to Settings > Privacy > Camera and turn on Camera access for this app."
    static let AGREE_TERMS_VALIDATION = "Please Agree Terms Before Continue."
    static let PACKAGE_ACTIVATED_STRING = "Your package has been activated."
    static let PULL_TO_REFRESH_STR = "Pull to refresh"
    static let PLEASE_ADD_MEETING_TITLE = "Please add meeting title"
    static let PLEASE_ADD_MEETING_TIME = "Please add meeting time"
    static let PLEASE_ADD_MEETING_DATE = "Please add meeting date"
    static let PLEASE_SELECT_ROOM_TYPE = "Please select room type"
    static let PLEASE_SELECT_NUMBERS_OF_SEATS = "Please select numbers of seats"
    static let EMPTY_CASE_CODE = "Please Enter Case Code."
}

extension Notification.Name {
    static let NETWORK_ARRIVE = NSNotification.Name.init(rawValue: "networkArrive")
    static let UPDATE_TOP_SLIDER_BACKGROUND = NSNotification.Name("UPDATE_TOP_SLIDER_BACKGROUND")
    static let UPDATE_TOP_BAR_TINT_COLOR = NSNotification.Name("UPDATE_TOP_BAR_TINT_COLOR")
    static let NOTIFICATION_CLICK = NSNotification.Name("NOTIFICATION_CLICK")
    static let NOTIFICATION_ICON_UPDATE = Notification.Name("NotificationIconUpdate")
    static let NOTIFICATION_QRCODE_GENRATED = Notification.Name("NotificationQRCodeGenrated")
    
    static let RESPOND_REQUEST = NSNotification.Name("RESPOND_REQUEST")
    static let REQUEST_ACCEPTED = NSNotification.Name("REQUEST_ACCEPTED")
    static let REQUEST_DECLINED = NSNotification.Name("REQUEST_DECLINED")
    static let REQUEST_CANCELED = NSNotification.Name("REQUEST_CANCELED")
}

struct DateFormats {
    static let yyyyMMdd = "yyyy/MM/dd"
    static let MMMMdyyyy = "MMMM d, yyyy"
    static let MMMddyyyy = "MMM dd, yyyy"
    static let EMMMdyyyy = "E, MMM d, yyyy"
    static let MMMdyyyy = "MMM d, yyyy"
    static let MMMd = "MMM d"
    static let dMMMMyyy = "d MMMM yyyy"
    static let NOTIFICATION_TIME_FORMAT = "MMMM dd, yyyy - hh:mm a"
    static let TIME_FORMAT = "h:mm a"
    static let DATE_TIME_FORMAT = "yyyy-MM-dd'T'HH:mm:ss"
    static let CALENDAR_DATE_TIME_FORMAT = "yyyy-MM-dd"
    static let MY_CARDS_DATE_FORMAT = "MMM dd, yyyy - hh:mm a"
    static let EN_US_POSIX = Locale(identifier: "en_US_POSIX")
    static let UTC_TIME_ZONE = TimeZone(abbreviation: "UTC")
}

struct UserDefaultKeys {
    static let isUserLogin = "isUserLogin"
    static let isFirstLaunch = "isFirstLaunch"    
}

struct K {
    static let MEDIA_FILE_KEY = "mediaFiles"
    static let URL_SCHEME_KEY = "com.epcards.ep.payments"
    static let LOADING_KEY = "loading..."
    static let ALERT = "Alert"
    static let ERROR = "Error"
    static let SUCCESS = "Success"
    static let API_BASE_URL_TYPE = "APIBaseURLType"
    static let DEVICE_TOKEN = "deviceToken"
    static let KFCM_TOKEN = "fcmToken"
    static let MESSAGE_ID = "gcm.message_ID"
    static let CANCEL_TEXT = "Cancel"
    static let SETTINGS_TEXT = "Settings"
    static let NOTIFICATION_COUNT_KEY = "NOTIFICATION_COUNT"
    static let NAME_KEY = "name"
    static let IMAGE_URL = "imageUrl"
    static let TEXT = "text"
    static let TYPE_KEY = "type"
    static let TYPE_ID_KEY = "typeId"
    static let DATA = "data"
    static let IS_READ = "isRead"
    static let SENDER_ID = "senderId"
    static let LATITUDE = "latitude"
    static let LONGITUDE = "longitude"
    static let COLOR = "color"
    static let FIRST_NAME = "firstname"
    static let LAST_NAME = "lastname"
    static let EGIFT_CARD_MODEL = "eGiftCardModel"
    static let NOTIFICATION_USERINFO = "notificationUserInfo"
    static let TRUE = "true"
    static let FALSE = "false"
    static let SELECTED_MY_CARDS_TAB = "selectedMyCardsTab"
    static let IS_CONNECTED = "isConnected"
    static let IS_DARK_THEME_KEY = "isDarkTheme"
    static let PROFILE_PICTURE = "profilePicture"

}
