//
//  Date.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/27.
//

import Foundation

extension Date {
    
    func today(date: Date) -> String {
        let today = date
        return weekdayName(date: today)
    }
    
    func nextDay(date:  Date) -> String {
        let nextDate = date
        guard let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: nextDate) else { return "" }
        return weekdayName(date: tomorrow)
    }
    
    func nextFiveDays(date: Date) -> [String] {
        let startDate = nextDay(date: date)
        var upcomingDays: [String] = []
        var dayOfWeekTally = 0
        guard var day = daysOfTheWeek.firstIndex(of: startDate ) else { return [] }
        
        while dayOfWeekTally < 5 {
            upcomingDays.append(daysOfTheWeek[day])
            day = day.advanced(by: 1)
            if day > 6 {
                day = 0
            }
            dayOfWeekTally = dayOfWeekTally + 1
        }
        return upcomingDays
    }
    
    var daysOfTheWeek: [String] {
        return Calendar.current.standaloneWeekdaySymbols
    }
    
    func weekdayName(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
}
