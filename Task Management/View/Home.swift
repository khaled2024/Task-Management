//
//  Home.swift
//  Task Management
//
//  Created by KhaleD HuSsien on 27/01/2023.
//

import SwiftUI

struct Home: View {
    @State private var currentDay: Date = .init()
    @ObservedObject var homeVM: HomeViewModel = HomeViewModel()
    @State private var addNewTask:Bool = false
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            TimelineView()
                .padding(15)
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            headerView()
        }
        .fullScreenCover(isPresented: $addNewTask) {
            AddTaskView { task in
                homeVM.tasks.append(task)
            }
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
                    addNewTask.toggle()
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
        /// this background to make sure that the timeline date didnt shown in top of the headerview
        .background(
            VStack(spacing: 0, content: {
                Color.white
                // Gradient...
                Rectangle()
                    .fill(
                        .linearGradient(colors: [.white,.clear], startPoint: .top, endPoint: .bottom))
                    .frame(height: 20)
            })
            .ignoresSafeArea()
        )
    }
    // Week row
    @ViewBuilder
    func WeekRow()-> some View{
        HStack(spacing: 0) {
            ForEach(Calendar.current.currentWeek) { weekDay in
                let status = Calendar.current.isDate(weekDay.date, inSameDayAs: currentDay)
                VStack(spacing: 6){
                    Text(weekDay.string.prefix(3))
                        .ubuntu(13, .medium)
                    Text(weekDay.date.toString(format: "dd"))
                        .ubuntu(17,status ? .medium : .regular)
                }
                .padding([.vertical,.horizontal],5)
                .background(
                    status ? RoundedRectangle(cornerRadius: 8)
                        .fill(.black.opacity(0.1))
                    : RoundedRectangle(cornerRadius: 8)
                        .fill(.clear)
                )
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
    // timeline view...
    @ViewBuilder
    func TimelineView()-> some View{
        ScrollViewReader{ proxy in
            let hours = Calendar.current.hours
            let midHour = hours[hours.count / 2]
            VStack{
                ForEach(hours,id: \.self){hour in
                    TimelineViewRow(hour)
                        .id(hour)
                }
            }
            .onAppear {
                proxy.scrollTo(midHour)
            }
        }
    }
    // timeline view row...
    @ViewBuilder
    func TimelineViewRow(_ date: Date)-> some View{
        HStack(alignment: .top) {
            Text(date.toString(format: "h a"))
                .ubuntu(14, .regular)
                .frame(width: 45, alignment: .leading)
            
            // filtering tasks...
            let calender = Calendar.current
            let filterTasks = homeVM.tasks.filter {
                if let hour = calender.dateComponents([.hour], from: date).hour, let taskHour = calender.dateComponents([.hour], from: $0.dateAdded).hour,hour == taskHour && calender.isDate($0.dateAdded, inSameDayAs: currentDay){
                    return true
                }
                return false
            }
            if filterTasks.isEmpty{
                Rectangle()
                    .stroke(.gray.opacity(0.5),style: StrokeStyle(lineWidth: 0.5, lineCap: .butt, lineJoin: .bevel, dash: [5], dashPhase: 5))
                    .frame(height: 0.5)
                    .offset(y: 10)
            }else{
                // Task view...
                VStack(spacing: 10) {
                    ForEach(filterTasks) { task in
                        TaskRow(task)
                    }
                }
            }
        }
        .hAlign(.leading)
        .padding(.vertical, 15)
    }
    // Task view...
    @ViewBuilder
    func TaskRow(_ task: Task)-> some View{
        VStack(alignment: .leading, spacing: 8){
            Text(task.taskName.uppercased())
                .ubuntu(16, .regular)
                .foregroundColor(task.taskCategory.color)
            if task.taskDescription != ""{
                Text(task.taskDescription)
                    .ubuntu(14, .light)
                    .foregroundColor(task.taskCategory.color.opacity(0.8))
            }
        }
        .hAlign(.leading)
        .padding(12)
        .background(
            ZStack(alignment: .leading){
                Rectangle()
                    .fill(task.taskCategory.color)
                    .frame(width: 4)
                Rectangle()
                    .fill(task.taskCategory.color.opacity(0.25))
            }
        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



