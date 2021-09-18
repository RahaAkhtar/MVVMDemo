//
//  Dictionary+Extension.swift
//  Dhana
//
//  Created by Muhammad  Akhtar on 3/15/21.
//  Copyright © 2021 Akhtar. All rights reserved.
//

import Foundation

extension Dictionary where Key:ExpressibleByStringLiteral {
    
    func convertToJSONString() -> String{
        var paramStr:String!
        if let theJSONData = try? JSONSerialization.data(withJSONObject: self,options: []) {
            paramStr = String(data: theJSONData,
                              encoding: .utf8)!
        }
        return paramStr
    }
}
