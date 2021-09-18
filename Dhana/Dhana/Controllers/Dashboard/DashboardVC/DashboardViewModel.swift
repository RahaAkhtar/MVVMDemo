//
//  DashboardViewModel.swift
//  Dhana
//
//  Created by Muhammad  Akhtar on 3/15/21.
//  Copyright © 2021 Akhtar. All rights reserved.
//

import Foundation

class DashboardViewModel {
    
    var responseComes:((DashboardResponseModel?)->())?
    var errorComes:((CustomError?)->())?

    var dashboardMeetingsList : [MeetingModel] = [MeetingModel]()
    var meetingCustomList : [DashboardCustomModel] = [DashboardCustomModel]()
    var userLat = 0.0
    var userLong = 0.0
    var isDashboardApiCalled = false
    
    private var isLoading = false
    private var skipCount = 0
    private var takeCount = 20
    
    func dashboardAPICall() {
        let url = API.AppMeeting.init().getdashboard
        
        let requestModel =  DashboardRequestModel.init(latitude: self.userLat, longitude: self.userLong, skip: skipCount, take: takeCount)
        
        PostAPIGeneric<DashboardRequestModel, DashboardResponseModel>.postRequest(apiURL: url, requestModel: requestModel) { [weak self] (result) in
            
            DispatchQueue.main.async {
                
                guard let `self` = self else { return }
                
                switch result {
                case .success(let responseModel):
                    if responseModel.isError{
                        let error = CustomError(description: responseModel.message)
                        self.errorComes?(error)
                    } else {
                        
                        //self.dashboardMeetingsList = responseModel.data ?? []
                        self.skipTakeImplementation(responseArray: responseModel.data ?? [])
                        self.responseComes?(responseModel)
                        //self.createModelForList()
                    }
                case .failure(let error):
                    let err = CustomError(description: (error as? CustomError)?.description ?? "")
                    self.errorComes?(err)
                    
                }
            }
        }

        
//        APIGeneric<DashboardResponseModel>.fetchRequest(apiURL: url, onCompletion: { [weak self] (result) in
//            switch result {
//            case .success(let responseModel):
//                DispatchQueue.main.async {
//                    guard let `self` = self else {return}
//                    if responseModel.isError{
//                        let error = CustomError(description: responseModel.message)
//                        self.errorComes?(error)
//                    }else{
//                        self.responseComes?(responseModel)
//                        self.dashboardMeetingsList = responseModel.data ?? []
//                        //self.createModelForList()
//                    }
//                }
//            case .failure(let error):
//                let err = CustomError(description: (error as? CustomError)?.description ?? "")
//                self?.errorComes?(err)
//            }
//        })
        
    }
    
    
    private func skipTakeImplementation(responseArray: [MeetingModel]) {
        if self.dashboardMeetingsList.count > 0 && self.skipCount != 0 {
            for obj in responseArray {
                self.dashboardMeetingsList.append(obj)
            }
        } else {
            self.dashboardMeetingsList = responseArray
        }
        
        self.isLoading = responseArray.count == 0
       
    }
    
    func updateSkipTakeDataOnScroll() -> Bool {
        if !self.isLoading {
            if self.dashboardMeetingsList.count < self.skipCount {
                self.isLoading = true
                self.skipCount += self.takeCount
                self.dashboardAPICall()
                return true
            } else {
                return false
            } 
        } else {
            return false
        }
    }
    
    func reset() {
//        session.cancelRequest(withURL: API.AppMeeting.init().getdashboard)
        skipCount = 0
        isLoading = false
        dashboardMeetingsList = []
    }
}
