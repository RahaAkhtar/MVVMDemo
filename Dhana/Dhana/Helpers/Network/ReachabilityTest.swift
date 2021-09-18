//
//  ReachabilityTest.swift
//
//  Created by Muhammad  Akhtar on 3/15/21.
//  Copyright © 2021 Akhtar. All rights reserved.
//

import Foundation
import SystemConfiguration


public class ReachabilityTest {
    
    static let sharedInstance = ReachabilityTest()
    private var reachability : Reachability!
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
        
    }
    
    func observeReachability(){
        
        do {
            try self.reachability = Reachability()
        } catch {
            print(error)
        }
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.reachabilityChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(self.reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
        do {
            try self.reachability.startNotifier()
        }
        catch(let error) {
            print("Error occured while starting reachability notifications : \(error.localizedDescription)")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        
        var isConnected = false
        
        switch reachability.connection {
        case .cellular:
            print("Network available via Cellular Data.")
            isConnected = true
            break
        case .wifi:
            print("Network available via WiFi.")
            isConnected = true
            break
        case .none:
            print("Network is not available.")
            isConnected = false
            break
        case .unavailable:
            print("Network is unavailable.")
            isConnected = false
        }
        
        let userInfo = [K.IS_CONNECTED: isConnected]
        NotificationCenter.default.post(name: .NETWORK_ARRIVE, object: nil, userInfo: userInfo)
        
    }
    
}
