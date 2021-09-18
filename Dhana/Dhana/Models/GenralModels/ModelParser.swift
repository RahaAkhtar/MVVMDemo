//
//  ModelParser.swift
//  Dhana
//
//  Created by Muhammad  Akhtar on 3/15/21.
//  Copyright © 2021 Akhtar. All rights reserved.
//

//import Foundation
//
//class ModelParser {
//       
//    static func parseLoginModel(responseModel:LoginModel, password: String) -> Void {
//        if let profile = ProfileDetails.instance.getProfileDetails() {
//            profile.userId = responseModel.id ?? ""
//            profile.password = password
//            profile.accessToken = responseModel.accessToken ?? ""
//            profile.firstName = responseModel.firstName ?? ""
//            profile.lastName = responseModel.lastName ?? ""
//            profile.email = responseModel.email ?? ""
//            if let profileImageObject = responseModel.profileImage {
//                profile.profileThumbnail = profileImageObject.thumbnailbURL ?? ""
//                profile.profilePicture = profileImageObject.url ?? ""
//            }
//            profile.color = responseModel.color ?? ""
//            UserDefaults.standard.setValue(responseModel.isCompanyEmployee, forKey: UserDefaultKeys.isCompanyEmployee)
//            UserDefaults.standard.setValue(true, forKey: UserDefaultKeys.isUserLogin)
//            ProfileDetails.instance.saveProfileDetails(instance: profile)
//        } else {
//            let profile = ProfileDetails.instance
//            profile.userId = responseModel.id ?? ""
//            profile.password = password
//            profile.accessToken = responseModel.accessToken ?? ""
//            profile.firstName = responseModel.firstName ?? ""
//            profile.lastName = responseModel.lastName ?? ""
//            profile.email = responseModel.email ?? ""
//            if let profileImageObject = responseModel.profileImage {
//                profile.profileThumbnail = profileImageObject.thumbnailbURL ?? ""
//                profile.profilePicture = profileImageObject.url ?? ""
//            }
//            profile.color = responseModel.color ?? ""
//            UserDefaults.standard.setValue(responseModel.isCompanyEmployee, forKey: UserDefaultKeys.isCompanyEmployee)
//            UserDefaults.standard.setValue(true, forKey: UserDefaultKeys.isUserLogin)
//            ProfileDetails.instance.saveProfileDetails(instance: profile)
//        }
//        
//    }
//    
//    static func parseStaticDataModel(staticModel:StaticDataModel?) -> Void {
//        if let model = staticModel {
//            StaticModelInfoStruct.instance.saveData(model: model)
//        }
//    }
//    
//    struct StaticModelInfoStruct {
//        static let instance = StaticModelInfoStruct()
//        
//        private let defaults = UserDefaults.standard
//        
//        func saveData(model:StaticDataModel?) -> Void {
//            if model != nil {
//                let defaults = UserDefaults.standard
//                defaults.set(try? PropertyListEncoder().encode(model), forKey: "StaticModelInfoStruct")
//            }else{
//                defaults.set(nil, forKey: "StaticModelInfoStruct")
//            }
//
//        }
//        
//        func fetchData() -> StaticDataModel? {
//            
//            let defaults = UserDefaults.standard
//            
//            if let data = defaults.object(forKey: "StaticModelInfoStruct") as? Data{
//                if let staticModel = try? PropertyListDecoder().decode(StaticDataModel.self, from: data) {
//                    return staticModel
//                } else {
//                    return nil
//                }
//            } else {
//                return nil
//            }
//        }
//    }
//}
