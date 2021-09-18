//
//  String+Extension.swift
//  Dhana
//
//  Created by Muhammad  Akhtar on 3/15/21.
//  Copyright © 2021 Akhtar. All rights reserved.
//

import UIKit

extension String {
  
    func getYearOnly() -> String {
        let date = self.getLocalDate()
        
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let yearStr = format.string(from: date)
        return yearStr
    }
    
    func getMonthOnly() -> String {
        let date = self.getLocalDate()
        
        let format = DateFormatter()
        format.dateFormat = "MMMM"
        let monthStr = format.string(from: date)
        return monthStr
    }
    
    func getStringFromDateString() -> String{
        
        let dateString = "\(self) 00:00:00.0"

        let dateFormatter12 = DateFormatter()
        dateFormatter12.dateFormat = "yyyy/MM/dd HH:mm:ss.S"
        let dateFromString = dateFormatter12.date(from: dateString)

        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "MMMM d, yyyy"

        let stringFromDate = dateFormatter2.string(from: dateFromString!)
        return stringFromDate
        
    }
    
    func getLocalDate() -> Date{
        let startIndex = self.index(self.startIndex, offsetBy: 0)
        let endIndex = self.index(self.startIndex, offsetBy: 18)
        let substring = self[startIndex...endIndex]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.DATE_TIME_FORMAT
        
        let convertedlocalTime = String(substring).UTCToLocal()
        dateFormatter.locale = DateFormats.EN_US_POSIX
        let localDate = dateFormatter.date(from: convertedlocalTime)
        
        return localDate!
    }
    
    func getDisplayDateToLocalDate() -> Date{
        let startIndex = self.index(self.startIndex, offsetBy: 0)
        let endIndex = self.index(self.startIndex, offsetBy: 18)
        let substring = self[startIndex...endIndex]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.MY_CARDS_DATE_FORMAT
        
        let convertedlocalTime = String(substring).UTCToLocalDisplayDate()
        dateFormatter.locale = DateFormats.EN_US_POSIX
        let localDate = dateFormatter.date(from: convertedlocalTime)
        
        return localDate!
    }
    
    func localToUTC() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.DATE_TIME_FORMAT
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.locale = DateFormats.EN_US_POSIX
        
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = DateFormats.UTC_TIME_ZONE
        dateFormatter.dateFormat = DateFormats.DATE_TIME_FORMAT
        dateFormatter.locale = DateFormats.EN_US_POSIX
        let utcDate = dateFormatter.string(from: dt ?? Date())
        return utcDate
    }
    
    func UTCToLocal() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.DATE_TIME_FORMAT
        dateFormatter.timeZone = DateFormats.UTC_TIME_ZONE
        dateFormatter.locale = DateFormats.EN_US_POSIX
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = DateFormats.DATE_TIME_FORMAT
        let localDate = dateFormatter.string(from: dt ?? Date())
        return localDate
    }
    
    func UTCToLocalDisplayDate() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.MY_CARDS_DATE_FORMAT
        dateFormatter.timeZone = DateFormats.UTC_TIME_ZONE
        dateFormatter.locale = DateFormats.EN_US_POSIX
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = DateFormats.MY_CARDS_DATE_FORMAT
        let localDate = dateFormatter.string(from: dt ?? Date())
        return localDate
    }
    
    func getScheduleDateStr() -> String {
        if var firstPart = self.components(separatedBy: "T").first {
            firstPart = firstPart + "T00:00:00"
            return firstPart
        } else {
            return self
        }
    }
    
    
    func getDate() -> Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DateFormats.DATE_TIME_FORMAT
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.locale = Locale.current
            return dateFormatter.date(from: self) ?? Date() // replace Date String
        }
    
    func getMyCardsDateStr() -> String {
        let localDate = self.getLocalDate()
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = DateFormats.MY_CARDS_DATE_FORMAT
        let resultStr = dateFormater.string(from: localDate)
        print(resultStr)
        return resultStr
    }
    
    func getSechduledCardsDate() -> String {
        let localDate = self.getLocalDate()
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = DateFormats.MMMddyyyy
        let resultStr = dateFormater.string(from: localDate)
        return resultStr
    }
    
    func isPhoneNumber(strContactNo:String) -> Bool
    {
        let regex: NSString = "\\+?[0-9]{10,13}"
        let predicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailCheck = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailCheck.evaluate(with: self)
    }
    
    func isValidURL() -> Bool {
        var isValid = false

        if !self.contains("..") {
            let head       = "((http|https)://)?([(w|W)]{3}+\\.)?"
            let tail       = "\\.+[A-Za-z]{2,3}+(\\.)?+(/(.)*)?"
            let urlRegEx = head+"+(.)+"+tail
            let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
            isValid = urlTest.evaluate(with: self.trimmingCharacters(in: CharacterSet.whitespaces))
        }
        return isValid
    }
    
    func whiteSpacesRemoved() -> String {
        return self.filter { $0 != Character(" ") }
    }
    
    func getHours() -> String{
        let h = self.split(separator: " ")
        return String(h[0])
    }
    
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }

    func hexStringToUIColor () -> UIColor {
        let hex = self
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
//    func convertHtml() -> NSMutableAttributedString{
//        guard data(using: .utf8) != nil else { return NSMutableAttributedString() }
//        do{
//            let modifiedFont = "<span style=\"font-family: Helvetica; font-size: 14\">\(self)</span>"
//            let attrStr = try NSMutableAttributedString(
//                data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
//                options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue],
//                documentAttributes: nil)
//
//            let paragraph = NSMutableParagraphStyle()
//            paragraph.lineBreakMode = .byTruncatingTail
//            attrStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraph, range: NSMakeRange(0, attrStr.length))
//            attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: Colors.LightMode.GRAY, range: NSMakeRange(0, attrStr.length))
//            attrStr.addAttribute(NSAttributedString.Key.font, value: Fonts.HELVETICA_REGULAR_14, range: NSMakeRange(0, attrStr.length))
//
//            let colorAttribute = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)]
//            attrStr.addAttributes(colorAttribute, range: NSMakeRange(0, attrStr.length))
//            return attrStr
//        } catch _{
//            return NSMutableAttributedString()
//        }
//    }
    
    func convertHtml() -> NSMutableAttributedString{
        guard data(using: .utf8) != nil else { return NSMutableAttributedString() }
        do{
            let modifiedFont = "<span style=\"font-family: Helvetica; font-size: 14\">\(self)</span>"
            let attrStr = try NSMutableAttributedString(
                data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
                options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil)
            
            let paragraph = NSMutableParagraphStyle()
            paragraph.lineBreakMode = .byTruncatingTail
            attrStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraph, range: NSMakeRange(0, attrStr.length))
            let colorAttribute = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)]
            attrStr.addAttributes(colorAttribute, range: NSMakeRange(0, attrStr.length))
            return attrStr
        } catch _{
            return NSMutableAttributedString()
        }
    }
    
    func getUniversalLinkingInfo() -> (caseCode: String, password: String){
        
        var caseCode = ""
        var password = ""
        
        if let mainValues = self.components(separatedBy: "?").last{
            
            let parameters = mainValues.components(separatedBy: "-")
            if parameters.count > 1 {
                for (index, value) in parameters.enumerated(){
                    switch index{
                    case 0:
                        if let item = value.components(separatedBy: "=").last{
                            caseCode = item
                        }
                    default:
                        if let item = value.components(separatedBy: "=").last{
                            password = item
                        }
                    }
                }
            }
            
            return(caseCode, password)
            
        }
        return ("","")
    }
}

//NSAttributedString.Key.foregroundColor: Colors.LightMode.GRAY.cgColo
//NSAttributedString.Key.font: Fonts.HELVETICA_REGULAR_14
