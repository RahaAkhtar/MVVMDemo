//
//  C-URL+Credentials.swift
//  Dhana
//
//  Created by Muhammad  Akhtar on 3/15/21.
//  Copyright © 2021 Akhtar. All rights reserved.
//

import Foundation

struct BaseUrl {
    static let DEV = "https://anytimesecuredev.stagingdesk.com"
    static let STAGING = "https://bbsapi.stagingdesk.com"
    static let LIVE = ""
}

struct SharingURL {
    static let DEEP_LINK_URL = "https://easypeasycards.com/go?id="
}

var APIBaseUrl : Int {
    return UserDefaults.standard.value(forKey: K.API_BASE_URL_TYPE) as? Int ?? APIUrlType.staging.rawValue
}

var apiURL : String {
    let value = APIBaseUrl
    switch value {
    case APIUrlType.dev.rawValue:
        return "\(BaseUrl.DEV)/api/v1"
    case APIUrlType.staging.rawValue:
        return "\(BaseUrl.STAGING)/api/v1"
    default:
        return "\(BaseUrl.LIVE)/api/v1"
    }
    
}

var buildStr : String {
    let value = APIBaseUrl
    switch value {
    case APIUrlType.dev.rawValue:
        return "Development"
    case APIUrlType.staging.rawValue:
        return "Client Staging"
    default:
        return "Live"
    }
}

struct API {
    
    struct Account {
        
        var checkEmail : String {
            return "\(apiURL)/AppAccount/checkemail"
        }
        
        var updatePassword : String {
            return "\(apiURL)/AppAccount/updatepassword"
        }
        
        var resendEmail : String {
            return "\(apiURL)/AppAccount/resendemail"
        }
        
        var codeVerification : String {
            return "\(apiURL)/AppAccount/codeverification"
        }
                
        var login : String {
            return "\(apiURL)/AppAccount/login"
        }
        
        var saveuser : String {
            return "\(apiURL)/AppAccount/saveuser"
        }
        
        var getprofile : String {
            return "\(apiURL)/AppAccount/getprofile"
        }
        
        var logout : String {
            return "\(apiURL)/AppAccount/logout"
        }
        
        var enablepush : String {
            return "\(apiURL)/AppAccount/enablepush"
        }
        
        var updatePhoneNumber : String {
            return "\(apiURL)/AppAccount/updatephonenumber"
        }
        
        
    }
    
    struct Locate {
        
        var locateuser : String {
            return "\(apiURL)/Locate/locateuser"
        }
        
    }
    
    struct AppCommon {
        
        var getcontent : String {
            return "\(apiURL)/AppCommon/getcontent"
        }
        
        var getcountries : String {
            return "\(apiURL)/AppCommon/getcountries"
        }
        
        var getstates : String {
            return "\(apiURL)/AppCommon/getstates"
        }
        
        var getcities : String {
            return "\(apiURL)/AppCommon/getcities"
        }
        
        var getstaticdata : String {
            return "\(apiURL)/AppCommon/getstaticdata"
        }
        
    }
        
    struct AppMeeting {
                
        var getroomtypes : String {
            return "\(apiURL)/AppMeeting/getroomtypes"
        }
        
        var getavailablebuildings : String {
            return "\(apiURL)/AppMeeting/getavailablebuildings"
        }
        
        var getavailablerooms : String {
            return "\(apiURL)/AppMeeting/getavailablerooms"
        }
    
        var createmeeting : String {
            return "\(apiURL)/AppMeeting/createmeeting"
        }
        
        var getattendees : String {
            return "\(apiURL)/AppMeeting/getattendees"
        }
        
        var saveattendee : String {
            return "\(apiURL)/AppMeeting/saveattendee"
        }
        
        var getdashboard : String {
            return "\(apiURL)/AppMeeting/getdashboard"
        }
        
        var getmeetingtime : String {
            return "\(apiURL)/AppMeeting/getmeetingtime"
        }
        
        var updatemeetingtime : String {
            return "\(apiURL)/AppMeeting/updatemeetingtime"
        }
        
        var updatemeetingdescription : String {
            return "\(apiURL)/AppMeeting/updatemeetingdescription"
        }
        
        var updatemeetingtitle : String {
            return "\(apiURL)/AppMeeting/updatemeetingtitle"
        }
        
        var getmeetingdetail : String {
            return "\(apiURL)/AppMeeting/getmeetingdetail"
        }
        
        var cancelmeeting : String {
            return "\(apiURL)/AppMeeting/cancelmeeting"
        }
        
        var updateMeetingSpecifications : String {
            return "\(apiURL)/AppMeeting/updatemeetingspecifications"
        }
        
        var uploadattendeeimage : String {
            return "\(apiURL)/AppMeeting/uploadattendeeimage"
        }
       
        var checkout : String {
            return "\(apiURL)/AppMeeting/checkout"
        }
        
        var getMeetingByDate : String {
            return "\(apiURL)/AppMeeting/getmeetingbydate"
        }
        
        var attachcovidreport : String {
            return "\(apiURL)/AppMeeting/attachcovidreport"
        }
        
    }
    
    struct Laboratory {
        var getLaboratories : String {
            return "\(apiURL)/Laboratory/getlaboratories"
        }

        var getTestResult : String {
            return "\(apiURL)/Laboratory/gettestresult"
        }
        
        var getmytest : String {
            return "\(apiURL)/Laboratory/getmytest"
        }

    }
    
    struct Notification {
        
        var getNotifications : String {
            return "\(apiURL)/Notification/getnotifications"
        }
        
    }
}
