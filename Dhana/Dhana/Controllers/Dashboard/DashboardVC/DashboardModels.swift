//
//  DashboardModels.swift
//  Dhana
//
//  Created by Muhammad  Akhtar on 3/15/21.
//  Copyright © 2021 Akhtar. All rights reserved.
//

import Foundation

// MARK: - DashboardResponseModel
struct DashboardResponseModel: Codable {
    let isError: Bool
    let message: String
    let exception: String
    let data: [MeetingModel]?

    enum CodingKeys: String, CodingKey {
        case isError = "isError"
        case message = "message"
        case exception = "exception"
        case data = "data"
    }
}

// MARK: - MeetingModel
struct MeetingModel: Codable {
    let id: String
    let qrCode: String?
    let name: String
    let meetingCode: String
    let attendeeImage: String
    let startTime: String
    let endTime: String
    let attendees: [AttendeeModel]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case qrCode = "qrCode"
        case name = "name"
        case startTime = "startTime"
        case endTime = "endTime"
        case attendees = "attendees"
        case meetingCode = "meetingCode"
        case attendeeImage = "attendeeImage"
    }
}

// MARK: - Attendee
struct AttendeeModel: Codable {
    let id, profilePic, color: String?
    let firstName: String?
    let lastName: String?
}

// MARK: - Custom Dashboard model

// MARK: - MeetingCustomModel
struct DashboardCustomModel: Codable {
    
    let startTime: String
    let endTime: String
    let isToday:Bool
    let meetingModel: MeetingModel?
}


// MARK: - DashboardRequestModel
struct DashboardRequestModel: Codable {
    let latitude: Double
    let longitude: Double
    let skip: Int
    let take: Int

    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
        case skip = "skip"
        case take = "take"
    }
}
