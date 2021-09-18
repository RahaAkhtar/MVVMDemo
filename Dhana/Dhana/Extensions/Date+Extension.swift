//
//  Date+Extension.swift
//  Dhana
//
//  Created by Muhammad  Akhtar on 3/15/21.
//  Copyright © 2021 Akhtar. All rights reserved.
//

import Foundation

extension Date {
    
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    
    private func dateWithZeroTime(date: Date) -> Date? {
        let calendar = Calendar.current
        let components: DateComponents = calendar.dateComponents([.day, .weekOfYear, .month, .year], from: date)
        return calendar.date(from: components)
    }
    
    private func thisDay() -> Date? {
        return self.dateWithZeroTime(date: self)
    }
    
    private func today() -> Date? {
        return self.dateWithZeroTime(date: Date())
    }
    
    private var noon: Date? {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)
    }
    
    private var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: (noon ?? today())!)!
    }
    
    private var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: today()!)!
    }
    
    var dateComponents : DateComponents {
        let calendar = Calendar.current
        let components: DateComponents = calendar.dateComponents([.day, .weekOfYear, .month, .year], from: self)
        return components
    }
    
    func getYesterdayDateForMeetingHistory() -> String {
        let yesterday = Calendar.current.date(byAdding: .minute, value: -1, to: self)!
        let str = yesterday.convertTimeToUTC()
        return str
    }
    
    func convertTimeToUTC() -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = DateFormats.EN_US_POSIX
        dateFormatter.dateFormat = DateFormats.DATE_TIME_FORMAT
        dateFormatter.timeZone = DateFormats.UTC_TIME_ZONE
        return dateFormatter.string(from: self)
    }
    
    func convertTimeForCalendar() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.CALENDAR_DATE_TIME_FORMAT
        var str = dateFormatter.string(from: self)
        str = str + "T00:00:00"
        return str
    }
    
    private func dayOfTheWeek() -> String {
        let weekdays = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
        let calendar: Calendar = Calendar.current
        let components: DateComponents = calendar.dateComponents([.weekday], from: self)
        return weekdays[components.weekday! - 1]
    }
    
    func getTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.TIME_FORMAT
        let dateStr = dateFormatter.string(from: self)
        return dateStr
    }
    
    func timeAgoSinceDate() -> String {
        
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = Date()
        let earliest = now < self ? now : self
        let latest = (earliest == now) ? self : now
        let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)
        
        if (components.year! >= 2) {
            return "\(components.year!) Years ago"
        } else if (components.year! >= 1){
            return "1 Year ago"
        } else if (components.month! >= 2) {
            return "\(components.month!) Months ago"
        } else if (components.month! >= 1){
            return "1 Month ago"
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) Weeks ago"
        } else if (components.weekOfYear! >= 1){
            return "1 Week ago"
        } else if (components.day! >= 2) {
            return "\(components.day!) Days ago"
        } else if (components.day! >= 1){
            return "1 Day ago"
        } else if (components.hour! >= 2) {
            return "\(components.hour!) Hours ago"
        } else if (components.hour! >= 1){
            return "1 Hour ago"
        } else if (components.minute! >= 2) {
            return "\(components.minute!) Mins ago"
        } else if (components.minute! >= 1){
            return "1 Min ago"
            //        } else if (components.second! >= 3) {
            //            return "\(components.second!) Secs ago"
        } else {
            return "Just Now"
        }
    }
    
    func isGreaterThanDate(dateToCompare: Date) -> Bool {
        var isGreater = false
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        return isGreater
    }
    
    func isLessThanDate(dateToCompare: Date) -> Bool {
        var isLess = false
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedAscending {
            isLess = true
        }
        return isLess
    }
    
    func getDisplayDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.MMMddyyyy
        let dateStr = dateFormatter.string(from: self)
        return dateStr
    }
    
    func getDisplayMonthDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.MMMd
        let dateStr = dateFormatter.string(from: self)
        return dateStr
    }
    
    func getEventDisplayDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.dMMMMyyy
        let dateStr = dateFormatter.string(from: self)
        return dateStr
    }
    
    func getNotificationDateStr() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.NOTIFICATION_TIME_FORMAT
        let dateStr = dateFormatter.string(from: self)
        return dateStr
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }
    
    func isInSameMonth(as date: Date) -> Bool { isEqual(to: date, toGranularity: .month) }
    
    
    //    func startOfMonth() -> Date {
    //        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    //    }
    //
    //    func endOfMonth() -> Date {
    //        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    //    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    func startOfMonth() -> Date {
        let interval = Calendar.current.dateInterval(of: .month, for: self)
        return (interval?.start.toLocalTime())! // Without toLocalTime it give last months last date
    }
    
    func endOfMonth() -> Date {
        let interval = Calendar.current.dateInterval(of: .month, for: self)
        return interval!.end
    }
    
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone    = TimeZone.current
        let seconds     = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    func isMonday() -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday == 2
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    public var removeTimeStamp : Date? {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
            return nil
        }
        return date
    }
    
    
    func getSectionHeaderDate() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = DateFormats.UTC_TIME_ZONE
        formatter.locale = DateFormats.EN_US_POSIX
        formatter.dateFormat = DateFormats.EMMMdyyyy
        
        return formatter.string(from: self)
    }
    
    func toDayDateFormatterString() -> String {
        //let mydate = title.getLocalDate()
        let dateFormatter = DateFormatter()
        if Calendar.current.isDateInToday(self) {
             dateFormatter.dateFormat = "'Today -' MMM d, yyyy"
        } else if Calendar.current.isDateInTomorrow(self) {
              dateFormatter.dateFormat = "'Tomorrow -' MMM d, yyyy"
        } else {
             dateFormatter.dateFormat = "EEEE - MMM d, yyyy"
         }
        
        return dateFormatter.string(from: self)
    }
}
