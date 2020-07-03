//
//  Date+Propeties.swift
//  Articles_Demo_Vanita
//
//  Created by Vanita Ladkat on 02/07/20.
//  Copyright © 2020 Vanita Ladkat. All rights reserved.
//

import Foundation

extension String {
    func timeDifference(end endDate: Date?, dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") -> String? {
        var components: DateComponents?

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let startDate = dateFormatter.date(from: self)

        if let startDate = startDate, let endDate = endDate {
            components = Calendar.current.dateComponents([.day, .hour, .minute], from: startDate, to: endDate)
        }

        let days: Int = components?.day ?? 0
        let hour: Int = components?.hour ?? 0
        let minutes: Int = components?.minute ?? 0
        let seconds: Int = components?.second ?? 0
        let durationString: String?

        if days > 0 {
            if days > 1 {
                durationString = "\(days) days"
            } else {
                durationString = "\(days) day"
            }
            return durationString
        }
        if hour > 0 {
            if hour > 1 {
                durationString = "\(hour) hrs"
            } else {
                durationString = "\(hour) hr"
            }
            return durationString
        }
        if minutes > 0 {
            if minutes > 1 {
                durationString = "\(minutes) mins"
            } else {
                durationString = "\(minutes) min"
            }
            
            return durationString
        }
        if seconds > 0 {
            if seconds > 1 {
                durationString = "\(seconds) secs"
            } else {
                durationString = "\(seconds) sec"
            }
            
            return durationString
        }
        return ""
    }
}

extension Int {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}
