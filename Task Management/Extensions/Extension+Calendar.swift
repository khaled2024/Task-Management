//
//  Extension+Calender.swift
//  Task Management
//
//  Created by KhaleD HuSsien on 31/01/2023.
//

import SwiftUI

//MARK: - Calender Ex :-
extension Calendar{
    /// return 24 hours in a day...
    var hours: [Date]{
        let startOfDay = self.startOfDay(for: Date())
        var hours: [Date] = []
        for index in 0..<24{
            if let date = self.date(byAdding: .hour,value: index, to: startOfDay){
                hours.append(date)
            }
        }
        return hours
    }
    /// return current week in Array format
    var currentWeek: [WeekDay]{
        guard let firstWeekDay = self.dateInterval(of: .weekOfMonth, for: Date())?.start else{return []}
        var week: [WeekDay] = []
        for index in 0..<7{
            if let day = self.date(byAdding: .day,value: index, to: firstWeekDay){
                let weekDaySymbol: String = day.toString(format: "EEEE")
                let isToday = self.isDateInToday(day)
                week.append(.init(string: weekDaySymbol, date: day,isToday: isToday))
            }
        }
        return week
    }
    // used to stored data of each week day...
    struct WeekDay: Identifiable{
        var id: UUID = .init()
        var string: String
        var date: Date
        var isToday: Bool = false
    }
}
