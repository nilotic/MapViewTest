//
//  DateUtil.swift
//  dailyhotel
//
//  Created by Den Jo on 07/10/2016.
//  Copyright © 2016 Daily Co., Ltd. All rights reserved.
//

import Foundation

// MARK: - Enum

/// DateFormat
///
/// - iso8601: yyyy-MM-dd'T'HH:mm:ssZZZZZ
/// - format1: yyyyMMddHHmm
/// - format2: yyyy.MM.dd
/// - format3: yyyy년 MM월 dd일 HH시 mm분 까지
/// - format4: yyyy/MM/dd HH:mm:ss
/// - format5: yyyy. MM. dd
/// - format6: yyyy년 MM월 dd일
/// - format7: yyyy-MM-dd
/// - format8: MM.dd
/// - format9: yyyyMMdd
/// - format10: yyyy/MM/dd
/// - format11: yyyyMMdd'T'HHmm
/// - format12: yyyy.MM
/// - format13: yyyy.MM.dd HH:mm
/// - time: HH:mm
/// - time2: HH:mm:ss
/// - weekDay: e
/// - hour: HH시
/// - hour2: H
enum DateFormat: String {
    case iso8601 = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    case format1 = "yyyyMMddHHmm"
    case format2 = "yyyy.MM.dd"
    case format3 = "yyyy년 MM월 dd일 HH시 mm분 까지"
    case format4 = "yyyy/MM/dd HH:mm:ss"
    case format5 = "yyyy. MM. dd"
    case format6 = "yyyy년 MM월 dd일"
    case format7 = "yyyy-MM-dd"
    case format8 = "MM.dd"
    case format9 = "yyyyMMdd"
    case format10 = "yyyy/MM/dd"
    case format11 = "yyyyMMdd'T'HHmm"
    case format12 = "yyyy.MM"
    case format13 = "yyyy.MM.dd HH:mm"
    case time     = "HH:mm"
    case time2    = "HH:mm:ss"
    case weekDay  = "e"
    case hour     = "HH시"
    case hour2    = "H"
}


enum DHTimeZone {
    case gmt
    case seoul
    
    var rawValue: TimeZone? {
        switch self {
        case .gmt:      return TimeZone(identifier: "GMT")
        case .seoul:    return TimeZone(identifier: "Asia/Seoul")
        }
    }
}

struct DateUtil {
    
    static let oneMinute: TimeInterval = 60.0
    static let oneHour = DateUtil.oneMinute * 60.0
    static let oneDay  = DateUtil.oneHour * 24.0
    
    
    /// Default (locale : "en_US_POSIX", timeZone : "GTM")
    static func string(from date: Date?, dateFormat: DateFormat, timeZone: DHTimeZone = .gmt) -> String? {
        return string(from: date, dateFormat: dateFormat.rawValue, timeZone: timeZone)
    }
    
    /// Default (locale : "en_US_POSIX", timeZone : "GTM")
    static func string(from date: Date?, dateFormat: String, timeZone: DHTimeZone = .gmt) -> String? {
        guard let dateFormatterTimeZone = timeZone.rawValue, let date = date else {
            log(.error, "Failed to convert date to string.")
            return nil
        }
        
        // Set formatter
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale     = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone   = dateFormatterTimeZone
        
        let dateString = dateFormatter.string(from: date)
        return (dateString == "") ? nil : dateString
    }
    
    /// Default (locale : "en_US_POSIX", timeZone : "GTM")
    static func date(from dateString: String?, dateFormat: DateFormat, timeZone: DHTimeZone = .gmt) -> Date? {
        return date(from: dateString, dateFormat: dateFormat.rawValue, timeZone: timeZone)
    }
    
    /// Default (locale : "en_US_POSIX", timeZone : "GTM")
    static func date(from dateString: String?, dateFormat: String, timeZone: DHTimeZone = .gmt) -> Date? {
        guard let dateFormatterTimeZone = timeZone.rawValue, let dateString = dateString else {
            log(.error, "Failed to convert date to string.)")
            return nil
        }
        
        // Set formatter
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale     = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone   = dateFormatterTimeZone
        
        
        if let gmtDate = dateFormatter.date(from: dateString), timeZone != .gmt {
            return DateUtil.date(from: gmtDate, targetTimeZone: timeZone)
            
        } else {
            return dateFormatter.date(from: dateString)
        }
    }
    
    /// Defualt TimeZone: "GMT"
    static func date(from sourceDate: Date, sourceTimeZone: DHTimeZone = .gmt, targetTimeZone: DHTimeZone = .gmt) -> Date? {
        guard let sourceOffset = sourceTimeZone.rawValue?.secondsFromGMT(for: sourceDate), let destinationOffset = targetTimeZone.rawValue?.secondsFromGMT(for: sourceDate) else {
            log(.error, "Failed to convert date with timeZone.")
            return nil
        }
        return Date(timeInterval: TimeInterval(destinationOffset - sourceOffset), since: sourceDate)
    }
    
    
    /// Get date from deeplink parameters.
    /// dp, d, week parameters can't be duplicated.
    ///
    /// - Parameters:
    ///   - deeplinkParameters: Deeplink parameters.
    ///   - standardDate: Date of standard. (e.g) currentDate, dailyDate
    /// - Returns: Specific date or Standard Date.
    static func date(from deeplinkParameters: [String : Any]?, standardDate: Date?) -> Date? {
        guard let deepLinkInfo = deeplinkParameters, let targetDate = standardDate else {
            log(.warning, "Invalid parameters.")
            return standardDate
        }
        let keys = deepLinkInfo.keys.filter { $0 == "dp" || $0 == "d" || $0 == "week" }
        
        // Available only 1 key.
        guard keys.count == 1, let key = keys.first else {
            log(.warning, "Invalid date key.")
            return targetDate
        }
        
        switch key {
        case "dp":
            guard let datePlusString = deepLinkInfo[key] as? String, let datePlus = Int(datePlusString) else { return targetDate }
            return targetDate.date(days: datePlus)
            
        case "d":
            guard let date = DateUtil.date(from: deepLinkInfo[key] as? String, dateFormat: .format9), date.compare(targetDate) != .orderedAscending else { return targetDate }
            return date
            
        case "week":
            guard let weekdaysString = deepLinkInfo[key] as? String, weekdaysString.count > 0 else { return targetDate }
            var weekDays: [UInt]? {
                let days = Array(weekdaysString).compactMap { UInt("\($0)") }
                let sorted = days.sorted()
                guard sorted.count == days.count else { return nil }
                
                // 범위 확인, 순서대로 정렬되어 들어왔는지 확인.
                // 순서와 범위가 맞지 않을 경우에는 오늘날짜로 설정함. (예외케이스 허용하지 않음, Android와 통일)
                for (i, weekday) in days.enumerated() {
                    guard weekday > 0, weekday < 8, weekday == sorted[i] else { return nil }
                }
                return days
            }
            
            guard var supportedWeekdays = weekDays, supportedWeekdays.contains(targetDate.weekDay) == false else { return targetDate }
            supportedWeekdays.append(targetDate.weekDay)
            supportedWeekdays.sort()
            
            if let lastDay = supportedWeekdays.last, lastDay == targetDate.weekDay, let firstDay = supportedWeekdays.first {
                // 현재 요일 뒤에 아무것도 없을 때.
                return targetDate.date(days: Int(7 - targetDate.weekDay + firstDay))
                
            } else if let dateIndex = supportedWeekdays.index(of: targetDate.weekDay), (dateIndex + 1) < supportedWeekdays.count {
                // 현재 요일 다음 요일이 있을 때.
                return targetDate.date(days: Int(supportedWeekdays[dateIndex + 1] - targetDate.weekDay))
            }
            
        default:
            break
        }
        
        return targetDate
    }
}


extension Date {
    
    var year: UInt {
        return UInt(Calendar.current.component(.year, from: self))
    }
    
    var month: UInt {
        return UInt(Calendar.current.component(.month, from: self))
    }
    
    var day: UInt {
        return UInt(Calendar.current.component(.day, from: self))
    }
    
    var hour: UInt {
        return UInt(Calendar.current.component(.hour, from: self))
    }
    
    var minute: UInt {
        return UInt(Calendar.current.component(.minute, from: self))
    }

    var weekDay: UInt {
        return UInt(Calendar.current.component(.weekday, from: self))
    }

    var firstDate: Date? {
        return self.date(from: [.year, .month])
    }
    
    var lastDate: Date? {
        guard let firstDate = self.firstDate else { return nil }
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: firstDate)
    }
   

    init(millisecondsIntervalSince1970  milliseconds: Double) {
        self.init(timeIntervalSince1970: milliseconds / 1000.0)
    }
    
    /// Return truncated date
    func date(from components: Set<Calendar.Component>) -> Date? {
        return Calendar.current.date(from: Calendar.current.dateComponents(components, from: self))
    }
    
    func date(minutes: Int) -> Date? {
        return Calendar.current.date(byAdding: DateComponents(minute: minutes), to: self)
    }
    
    func date(hours: Int) -> Date? {
        return Calendar.current.date(byAdding: DateComponents(hour: hours), to: self)
    }
    
    func date(days: Int) -> Date? {
         return Calendar.current.date(byAdding: DateComponents(day: days), to: self)
    }
    
    func date(months: Int) -> Date? {
        return Calendar.current.date(byAdding: DateComponents(month: months), to: self)
    }
    
    
    /// Return interval by days
    ///
    /// - parameter targetDate: Date type
    ///
    /// - returns: interval or nil
    func days(from: Date?) -> Int? {
        guard let from = from else { return nil }
        
        var calendar = NSCalendar.current
        if let GMTTimeZone = DHTimeZone.gmt.rawValue {
            calendar.timeZone = GMTTimeZone
        }
        
        calendar.locale = Locale(identifier: "en_US_POSIX")
        
        // Replace the hour (time) of both dates with 00:00
        let toDay   = calendar.startOfDay(for: self)
        let fromDay = calendar.startOfDay(for: from)
        
        let dateComponets = calendar.dateComponents([.day], from: fromDay, to: toDay)
        return dateComponets.day
    }
    
    /// Return interval by months
    ///
    /// - parameter targetDate: Date type
    ///
    /// - returns: interval or nil
    func months(from: Date?) -> Int? {
        guard let from = from else { return nil }
        
        var calendar = NSCalendar.current
        if let GMTTimeZone = DHTimeZone.gmt.rawValue {
            calendar.timeZone = GMTTimeZone
        }
        
        calendar.locale = Locale(identifier: "en_US_POSIX")
        
        // Replace the hour (time) of both dates with 00:00
        guard let toDay = calendar.startOfDay(for: self).lastDate, let fromDay = calendar.startOfDay(for: from).firstDate else { return nil }
        
        let dateComponets = calendar.dateComponents([.month], from: fromDay, to: toDay)
        return dateComponets.month
    }
    
    /// Return interval by years
    ///
    /// - parameter targetDate: Date type
    ///
    /// - returns: interval or nil
    func years(from: Date?) -> Int? {
        guard let from = from else { return nil }
        
        var calendar = NSCalendar.current
        if let GMTTimeZone = DHTimeZone.gmt.rawValue {
            calendar.timeZone = GMTTimeZone
        }
        
        calendar.locale = Locale(identifier: "en_US_POSIX")
        
        // Replace the hour (time) of both dates with 00:00
        let toDay   = calendar.startOfDay(for: self)
        let fromDay = calendar.startOfDay(for: from)
        
        let dateComponets = calendar.dateComponents([.year], from: fromDay, to: toDay)
        
        return dateComponets.day
    }
}

