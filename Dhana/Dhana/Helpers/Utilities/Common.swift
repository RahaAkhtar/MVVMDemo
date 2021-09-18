//
//  Common.swift
//  Dhana
//
//  Created by Muhammad  Akhtar on 3/15/21.
//  Copyright © 2021 Akhtar. All rights reserved.
//

import UIKit
import Photos

class Common: NSObject {
    
    class func getImageFromAsset(asset: PHAsset, completionHandler: ((UIImage?) -> Void)?) {
        let options = PHImageRequestOptions()
        options.isSynchronous = false
        options.isNetworkAccessAllowed = false
        options.deliveryMode = .highQualityFormat
        
        PHImageManager.default().requestImageData(for: asset, options: options) { data, uti, orientation, info in
            guard let info = info else { return }
            
            if let error = info[PHImageErrorKey] as? Error {
                print("Cannot fetch data for GIF image: \(error)")
                completionHandler?(nil)
                return
            }
            
            if let isInCould = info[PHImageResultIsInCloudKey] as? Bool, isInCould {
                print("Cannot fetch data from cloud. Option for network access not set.")
                completionHandler?(nil)
                return
            }
            
            if let imageData = data {
                let pickedImage = UIImage(data: imageData) ?? Icons.RECTANGLE_PLACEHOLDER!
                completionHandler?(pickedImage)
            } else {
                completionHandler?(nil)
            }
        }
    }
    
    class func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        DispatchQueue.global().async { //1
            let asset = AVAsset(url: url) //2
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
            avAssetImageGenerator.appliesPreferredTrackTransform = true //4
            let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
                let thumbImage = UIImage(cgImage: cgThumbImage) //7
                DispatchQueue.main.async { //8
                    completion(thumbImage) //9
                }
            } catch {
                print(error.localizedDescription) //10
                DispatchQueue.main.async {
                    completion(nil) //11
                }
            }
        }
    }
    
    class func getMp4UrlFromAsset(asset: PHAsset, completionHandler: ((URL?) -> Void)?) {
        PHImageManager.default().requestAVAsset(forVideo: asset, options: nil) { (asset, audioMix, info) in
            guard let asset = asset else { return }
            
            let manager = FileManager.default
            guard let documentDirectory = try? manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {return}
            
            var outputURL = documentDirectory.appendingPathComponent("output")
            do {
                try manager.createDirectory(at: outputURL, withIntermediateDirectories: true, attributes: nil)
                outputURL = outputURL.appendingPathComponent("output.mp4")
            }catch let error {
                print(error)
            }
            
            //Remove existing file
            _ = try? manager.removeItem(at: outputURL)
            
            guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetMediumQuality) else {return}
            exportSession.outputURL = outputURL
            exportSession.outputFileType = AVFileType.mp4
            
            exportSession.exportAsynchronously{
                switch exportSession.status {
                case .completed:
                    DispatchQueue.main.async {
                        let mp4url = outputURL
                        completionHandler?(mp4url)
                    }
                case .failed:
                    print("failed \(String(describing: exportSession.error))")
                    completionHandler?(nil)
                case .cancelled:
                    print("cancelled \(String(describing: exportSession.error))")
                    completionHandler?(nil)
                    
                default: break
                }
            }
        }
    }
    
    class func logoutUserApi(logoutFromAll:Bool) -> Void {
        //        let url = "\(API.Account.logout)/\(logoutFromAll)"
        //        APIGeneric<GeneralModel<Bool>>.fetchRequest(apiURL: url) { (result) in
        //            switch result {
        //            case .success(let responseModel):
        //                DispatchQueue.main.async {
        //                    if responseModel.isError{
        //                        let error = CustomError(description: responseModel.messages)
        //                        print(error.localizedDescription)
        //                    }else{
        //                        if let profile = ProfileDetails.instance.getProfileDetails(){
        //                            ProfileDetails.instance.removeProfileDetails(instance: profile)
        //                        }
        //                        UserDefaults.standard.setValue(false, forKey: UserDefaultKeys.isFreeSubscribed)
        //                        Common.loginAsGuestApi(completionHandler: {_ in})
        //                        ModeSelection.instance.signupMode()
        //                    }
        //                }
        //            case .failure(let error):
        //                let error = CustomError(description: error.localizedDescription)
        //                print(error)
        //            }
        //        }
    }
    
    
    
    class func getGMTDifference() -> Int {
        let utcDate = Date()
        let localDate = Date().toLocalTime()
        
        let diffComponents = Calendar.current.dateComponents([.hour], from: utcDate, to: localDate)
        let hours = diffComponents.hour
        print("Hours :- \(hours)")
        return hours ?? 0
    }
    
    class func appendHoursAndGetEndMeetingDate(date:Date, hours:String) -> String {
        let hours = Float(hours) ?? 0.0
        let total = hours * 60.0
        let newDate = Calendar.current.date(byAdding: .minute, value: Int(total), to: date)
        let currentDateTime  = newDate?.convertTimeToUTC() ?? Date().convertTimeToUTC()
        return currentDateTime
    }
    
    class func getCurrentTimeZone() -> (String,String,String){
        
        let timeZone = TimeZone.current.localizedName(for: TimeZone.current.isDaylightSavingTime() ?
            .daylightSaving :
            .standard,
                                                      locale: .current) ?? ""
        
        return (TimeZone.current.identifier, timeZone, TimeZone.current.offsetInHours())
    }
    
    class func timeDifferenceInMinutes(fromDate:Date, toDate:Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute ?? 0
    }
    
    class func getSameStateAsCityModel(name: String?) -> NameIDModel {
        let city = NameIDModel(id: 0, name: name ?? "")
        return city
    }
    
    class func getIPAddress() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                let interface = ptr?.pointee
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6),
                   let cString = interface?.ifa_name,
                   String(cString: cString) == "en0",
                   let saLen = (interface?.ifa_addr.pointee.sa_len) {
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    let ifaAddr = interface?.ifa_addr
                    getnameinfo(ifaAddr,
                                socklen_t(saLen),
                                &hostname,
                                socklen_t(hostname.count),
                                nil,
                                socklen_t(0),
                                NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
            freeifaddrs(ifaddr)
        }
        return address
    }
    
    class func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 12, y: 12)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
        
    class func getDateStringsBetween(from startDate: Date, to endDate: Date) -> [String] {

        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(Set([.month]), from: startDate, to: endDate)

        var allDates: [String] = []
        let dateRangeFormatter = DateFormatter()
        dateRangeFormatter.dateFormat = DateFormats.DATE_TIME_FORMAT

        for i in 0 ... components.month! {
            guard let date = calendar.date(byAdding: .month, value: i, to: startDate) else {
            continue
            }

            let formattedDate = dateRangeFormatter.string(from: date)
            allDates += [formattedDate]
        }
        return allDates
    }
    
    
    class func statusAtributtedString(boldText:String, normalText:String) -> NSMutableAttributedString {
        let boldFont = UIFont(name: "HelveticaNeue-Bold", size: 11.0)!
        let regularFont = UIFont(name: "Helvetica Neue", size: 11.0)!

        let boldText  = "\(boldText) "

        let attrsBold = [NSAttributedString.Key.font : boldFont]
        let boldString = NSMutableAttributedString(string: boldText, attributes:attrsBold)
        
        let attrsNormal = [NSAttributedString.Key.font : regularFont]
        let normalString = NSMutableAttributedString(string: normalText, attributes:attrsNormal)

        let attributedString = NSMutableAttributedString(attributedString: boldString)
        
        attributedString.append(normalString)
        
        return attributedString
    }
    
    class func addMeetingCovidBoldString(boldText:String, normalText:String) -> NSMutableAttributedString {
        let boldFont = UIFont(name: "HelveticaNeue-Bold", size: 14.0)!
        let regularFont = UIFont(name: "Helvetica Neue", size: 14.0)!

        let boldText  = "\(boldText) "

        let attrsBold = [NSAttributedString.Key.font : boldFont]
        let boldString = NSMutableAttributedString(string: boldText, attributes:attrsBold)
        
        let attrsNormal = [NSAttributedString.Key.font : regularFont]
        let normalString = NSMutableAttributedString(string: normalText, attributes:attrsNormal)

        let attributedString = NSMutableAttributedString(attributedString: boldString)
        
        attributedString.append(normalString)
        
        return attributedString
    }
}


extension TimeZone {
    
    func offsetFromUTC() -> String
    {
        let localTimeZoneFormatter = DateFormatter()
        localTimeZoneFormatter.timeZone = self
        localTimeZoneFormatter.dateFormat = "Z"
        return localTimeZoneFormatter.string(from: Date())
    }
    
    func offsetInHours() -> String
    {
        
        let hours = secondsFromGMT()/3600
        let minutes = abs(secondsFromGMT()/60) % 60
        let tz_hr = String(format: "%+.2d:%.2d", hours, minutes) // "+hh:mm"
        return tz_hr
    }
    
    
}
