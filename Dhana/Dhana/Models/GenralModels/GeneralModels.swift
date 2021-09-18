//
//  GeneralModels.swift
//  Dhana
//
//  Created by Muhammad  Akhtar on 3/15/21.
//  Copyright © 2021 Akhtar. All rights reserved.
//

import Foundation

// MARK: - DeviceInfo
struct DeviceInfo: Codable {
    let deviceManufacturer: String
    let osType: String
    let model: String
    let osVersion: String
    let udid: String
    let modelNumber: String
    let serialNumber: String
    let macAddress: String
    let deviceToken: String
    let ip: String

    enum CodingKeys: String, CodingKey {
        case deviceManufacturer = "deviceManufacturer"
        case osType = "osType"
        case model = "model"
        case osVersion = "osVersion"
        case udid = "udid"
        case modelNumber = "modelNumber"
        case serialNumber = "serialNumber"
        case macAddress = "macAddress"
        case deviceToken = "deviceToken"
        case ip = "ip"
    }
}

// MARK: - BoolResponseModel
struct BoolResponseModel: Codable {
    let isError: Bool
    let message, exception: String?
    let data: Bool?
}

// MARK: - StringResponseModel
struct StringResponseModel: Codable {
    let isError: Bool
    let message, exception: String?
    let data: String?
}


struct NotSuccessModel:Codable {
    let isError: Bool
    let message: String?
}

struct NameIDModel: Codable {
    let id: Int
    let name: String
}


struct CustomError: LocalizedError {
    var description: String?

    init(description: String) {
        self.description = description
    }
}

