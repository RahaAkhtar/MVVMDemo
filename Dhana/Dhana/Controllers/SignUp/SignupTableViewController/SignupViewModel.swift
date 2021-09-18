//
//  SignupViewModel.swift
//  Dhana
//
//  Created by Muhammad  Akhtar on 3/15/21.
//  Copyright © 2021 Akhtar. All rights reserved.
//

import Foundation

//class EmailSignupViewModel {
//    
//    var email: String = ""
//    
//    var isBlocked = false
//    var isEmailVerified = false
//    
//    var responseComes:((EmailExistModel?)->())?
//    var errorComes:((CustomError?)->())?
//
//    func validation() -> (status: Bool, message:String? ){
//        
//        var msgStr = ""
//        
//        if email == "" {
//            msgStr = Alerts.EMPTY_EMAIL_ADDRESS
//            return (false, msgStr)
//        }
//        
//        if !email.isValidEmail() {
//            msgStr = Alerts.INVALID_EMAIL_ADDRESS
//            return (false, msgStr)
//        }
//        
//        return (true, nil)
//    }
//    
//    func checkEmailAPICall() {
//        let url = API.Account.init().checkEmail
//        let requestModel =  EmailExistRequestModel(email: email)
//        
//        PostAPIGeneric<EmailExistRequestModel, EmailExistResponseModel>.postRequest(apiURL: url, requestModel: requestModel) { [weak self] (result) in
//            
//            DispatchQueue.main.async {
//                
//                guard let `self` = self else { return }
//                switch result {
//                case .success(let responseModel):
//                    if responseModel.isError{
//                        let error = CustomError(description: responseModel.message ?? "")
//                        self.errorComes?(error)
//                    }else{
//                        if let model = responseModel.data {
//                            self.isBlocked = model.isBlocked ?? false
//                            self.isEmailVerified = model.isEmailVerified ?? false
//                        }
//                        self.responseComes?(responseModel.data)
//                    }
//                case .failure(let error):
//                    let err = CustomError(description: (error as? CustomError)?.description ?? "")
//                    self.errorComes?(err)
//                }
//            }
//        }
//    }
//}
