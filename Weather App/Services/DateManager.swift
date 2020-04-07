//
//  DateManager.swift
//  Weather App
//
//  Created by Simo on 4/7/20.
//  Copyright © 2020 A. All rights reserved.
//

import Foundation

// MARK: convert Time to 12 Fortmat
func getHour12FormatFromTime(time : Double)-> String{
        let date = Date(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "h a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
      return dateFormatter.string(from: date)
}

// MARK: convert Time to 24 Fortmat
func getHour24FormatFromTime(time : Double)-> String{
        let date = Date(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
}
// MARK: get day from Time
func getDayFromTime(time : Double)->String{
    let date = Date(timeIntervalSince1970: time)
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US")
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter.string(from: date)
}

// MARK: check today
func checkToday(sysDate : Date, dateInTime : Double)->Bool{
    let dateFromTime = Date(timeIntervalSince1970: dateInTime)
    let order = Calendar.current.compare(sysDate, to: dateFromTime, toGranularity: .day) == .orderedSame
    return order
}
