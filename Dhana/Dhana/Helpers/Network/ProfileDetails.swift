//
//  ProfileConfig.swift
//
//  Created by Muhammad  Akhtar on 3/15/21.
//  Copyright © 2021 Akhtar. All rights reserved.
//

import Foundation
import os.log

struct ProfileKeys {
    
    static let userId = "userId"
    static let password = "password"
    static let accessToken = "accessToken"
    static let firstName = "firstName"
    static let lastName = "lastName"
    static let email = "email"
    static let profileThumbnail = "profileThumbnail"
    static let profilePicture = "profilePicture"
    static let dialCode = "dialCode"
    static let phoneNumber = "phoneNumber"
    static let color = "color"
    
}

class ProfileDetails: NSObject, NSCoding {
    
    static let instance = ProfileDetails()
    
    var userId:String = ""
    var password:String = ""
    var accessToken:String = ""
    var firstName:String = ""
    var lastName:String = ""
    var email:String = ""
    var profileThumbnail:String = ""
    var profilePicture:String = ""
    var dialCode:String = ""
    var phoneNumber:String = ""
    var color:String = ""
    
    required convenience init?(coder aDecoder: NSCoder)
    {
        
        self.init()
        
        if let usrId = aDecoder.decodeObject(forKey: ProfileKeys.userId) as? String {
            userId = usrId
        }
        if let psword = aDecoder.decodeObject(forKey: ProfileKeys.password) as? String {
            password = psword
        }
        if let token = aDecoder.decodeObject(forKey: ProfileKeys.accessToken) as? String {
            accessToken = token
        }
        if let fname = aDecoder.decodeObject(forKey: ProfileKeys.firstName) as? String {
            firstName = fname
        }
        if let lname = aDecoder.decodeObject(forKey: ProfileKeys.lastName) as? String {
            lastName = lname
        }
        if let emails = aDecoder.decodeObject(forKey: ProfileKeys.email) as? String {
            email = emails
        }
        if let profileThumbUrl = aDecoder.decodeObject(forKey: ProfileKeys.profileThumbnail) as? String {
            profileThumbnail = profileThumbUrl
        }
        if let profilePicUrl = aDecoder.decodeObject(forKey: ProfileKeys.profilePicture) as? String {
            profilePicture = profilePicUrl
        }
        if let dialCde = aDecoder.decodeObject(forKey: ProfileKeys.dialCode) as? String {
            dialCode = dialCde
        }
        if let phnNumber = aDecoder.decodeObject(forKey: ProfileKeys.phoneNumber) as? String {
            phoneNumber = phnNumber
        }
        if let clr = aDecoder.decodeObject(forKey: ProfileKeys.color) as? String {
            color = clr
        }
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(userId, forKey: ProfileKeys.userId)
        aCoder.encode(password, forKey: ProfileKeys.password)
        aCoder.encode(accessToken, forKey: ProfileKeys.accessToken)
        aCoder.encode(firstName, forKey: ProfileKeys.firstName)
        aCoder.encode(lastName, forKey: ProfileKeys.lastName)
        aCoder.encode(email, forKey: ProfileKeys.email)
        aCoder.encode(profileThumbnail, forKey: ProfileKeys.profileThumbnail)
        aCoder.encode(profilePicture, forKey: ProfileKeys.profilePicture)
        aCoder.encode(dialCode, forKey: ProfileKeys.dialCode)
        aCoder.encode(phoneNumber, forKey: ProfileKeys.phoneNumber)
        aCoder.encode(color, forKey: ProfileKeys.color)
    }
    
    func getProfileDetails() -> ProfileDetails?
    {
        var profileDetails : ProfileDetails?
        if let data = UserDefaults.standard.object(forKey: "profileDetailsKey") as? Data
        {
            profileDetails = NSKeyedUnarchiver.unarchiveObject(with: data) as? ProfileDetails
        }
        return profileDetails
    }
    
    func saveProfileDetails(instance:ProfileDetails)
    {
        let data = NSKeyedArchiver.archivedData(withRootObject: instance)
        UserDefaults.standard.set(data, forKey: "profileDetailsKey")
    }
    
    func removeProfileDetails(instance:ProfileDetails) -> Void {
        UserDefaults.standard.removeObject(forKey: "profileDetailsKey")
        UserDefaults.standard.synchronize()
        UserDefaults.standard.setValue(0, forKey: K.NOTIFICATION_COUNT_KEY)
    }
    
    func removeProfileOnLogout() -> Void {
        UserDefaults.standard.removeObject(forKey: "profileDetailsKey")
        UserDefaults.standard.synchronize()
    }
    
    func clearAllUserDefaults() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    
}
