//
//  ENUMs.swift
//  Dhana
//
//  Created by Muhammad  Akhtar on 3/15/21.
//  Copyright © 2021 Akhtar. All rights reserved.
//

import Foundation

enum APIUrlType:Int {
    case dev = 1
    case staging = 2
    case live = 3
}

enum CurrentStageType {
    case start
    case one
    case two
    case three
    case end
}

enum GenderType: Int {
    case none = -1
    case male = 1
    case female = 2
    case other = 3
}

enum cameraType {
    case image
    case video
}

enum DeviceType : Int {
    case android = 1
    case iOS = 2
}

enum MenuKeys:String {
    case viewProfile = "View Profile"
    case locateFriend = "Locate Friend"
    case settings = "Settings"
    case laboratory = "Laboratory"
    case viewTestResult = "View Test Results"
    case scanResult = "Scan Result"
}
