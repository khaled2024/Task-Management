//
//  Home.swift
//  Task Management
//
//  Created by KhaleD HuSsien on 27/01/2023.
//

import SwiftUI

struct Home: View {
    @State private var currentDay: Date = .init()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            //
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            headerView()
        }
    }
    //MARK: - Header Builder:-
    @ViewBuilder
    // Header view
    func headerView()-> some View{
        VStack{
            HStack{
                VStack(alignment: .leading, spacing: 6) {
                    Text("Today")
                        .ubuntu(30, .light)
                    Text("Welcome, Khaled")
                        .ubuntu(14, .light)
                }
                .hAlign(.leading)
                Button {
                    
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "plus")
                        Text("Add Task")
                            .ubuntu(15, .regular)
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal,15)
                    .background(
                        Capsule()
                            .fill(Color.blue.gradient)
                    )
                    .foregroundColor(.white)
                }
                
            }
            /// Today date in string...
            Text(Date().toString(format: "MMM YYYY"))
                .ubuntu(16, .medium)
                .hAlign(.leading)
                .padding(.top, 15)
            /// current week row...
            WeekRow()
        }
        .padding(15)
        
    }
    // Week row
    @ViewBuilder
    func WeekRow()-> some View{
        HStack(spacing: 0) {
            ForEach(Calendar.current.currentWeek) { weekDay in
                let status = Calendar.current.isDate(weekDay.date, inSameDayAs: currentDay)
                VStack(spacing: 6){
                    Text(weekDay.string.prefix(3))
                        .ubuntu(12, .medium)
                    Text(weekDay.date.toString(format: "dd"))
                        .ubuntu(16,status ? .medium : .regular)
                }
                .foregroundColor(status ? Color.blue : .gray)
                .hAlign(.center)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        currentDay = weekDay.date
                    }
                }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, -15)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
//MARK: - Alignment extentions
extension View{
    func hAlign(_ alignment: Alignment)-> some View{
        self.frame(maxWidth: .infinity,alignment: alignment)
    }
    func vAlign(_ alignment: Alignment)-> some View{
        self.frame(maxHeight: .infinity,alignment: alignment)
    }
}
//MARK: - Date String Ex :-
extension Date{
    func toString(format: String)-> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
//MARK: - Calender Ex :-
extension Calendar{
    var currentWeek: [WeekDay]{
        guard let firstWeekDay = self.dateInterval(of: .weekOfMonth, for: Date())?.start else{return []}
        var week: [WeekDay] = []
        for index in 0..<7{
            if let day = self.date(byAdding: .day,value: index, to: firstWeekDay){
                let weekDaySymbol: String = day.toString(format: "EEEE")
                let isToday = self.isDateInToday(day)
                week.append(.init(string: weekDaySymbol, date: day))
            }
        }
        return week
    }
    // used to stored data of each week day...
    struct WeekDay: Identifiable{
        var id: UUID = .init()
        var string: String
        var date: Date
        var today: Bool = false
    }
}

