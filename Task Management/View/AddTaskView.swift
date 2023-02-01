//
//  AddTaskView.swift
//  Task Management
//
//  Created by KhaleD HuSsien on 30/01/2023.
//

import SwiftUI
struct AddTaskView: View {
    /// call back...
    var onAdd: (Task)->()
    @Environment(\.dismiss) private var dismiss
    /// proparties...
    @State private var taskName: String = ""
    @State private var taskDescription: String = ""
    @State private var taskDate: Date = .init()
    @State private var taskCategory: Category = .modifiers
    @State private var animateColor: Color = Category.general.color
    @State private var animate: Bool = false
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading, spacing: 10) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .contentShape(Rectangle())
                }
                Text("Create new Task")
                    .ubuntu(28, .light)
                    .foregroundColor(.white)
                    .padding(.vertical, 15)
                TitleView("NAME")
                TextField("Make New Video", text: $taskName)
                    .ubuntu(16, .regular)
                    .tint(.white)
                    .padding(.top, 2)
                
                Rectangle()
                    .fill(.white.opacity(0.7))
                    .frame(height: 1)
                
                TitleView("DATE")
                    .padding(.top,15)
                HStack(alignment: .bottom, spacing: 12) {
                    HStack(spacing: 12) {
                        Text(taskDate.toString(format: "EEEE dd, MMMM"))
                            .ubuntu(16, .regular)
                        /// custom date picker...
                        Image(systemName: "calendar")
                            .font(.title3)
                            .foregroundColor(.white)
                            .overlay{
                                DatePicker("", selection: $taskDate,displayedComponents: [.date]).blendMode(.destinationOver)
                                
                            }
                    }
                    .offset(y: -5)
                    .overlay(alignment: .bottom) {
                        Rectangle()
                            .fill(.white.opacity(0.7))
                            .frame(height: 1)
                            .offset(y: 5)
                    }
                    HStack(spacing: 12) {
                        Text(taskDate.toString(format: "hh:mm a"))
                            .ubuntu(16, .regular)
                        /// custom date picker...
                        Image(systemName: "clock")
                            .font(.title3)
                            .foregroundColor(.white)
                            .overlay{
                                DatePicker("", selection: $taskDate,displayedComponents: [.hourAndMinute]).blendMode(.destinationOver)
                                
                            }
                    }
                    .offset(y: -5)
                    .overlay(alignment: .bottom) {
                        Rectangle()
                            .fill(.white.opacity(0.7))
                            .frame(height: 1)
                            .offset(y: 5)
                    }
                }
                .padding(.bottom,15)
            }
            .environment(\.colorScheme, .dark)
            .hAlign(.leading)
            .padding(15)
            .background{
                ZStack{
                    taskCategory.color
                    GeometryReader {
                        let size = $0.size
                        Rectangle()
                            .fill(animateColor)
                            .mask {
                                Circle()
                            }
                            .frame(width: animate ? size.width * 2 : 0, height: animate ? size.height * 2 : 0)
                            .offset(animate ? CGSize(width: -size.width/2, height: -size.height/2): size)
                    }
                    .clipped()
                }
                .ignoresSafeArea()
            }
            VStack(alignment: .leading,spacing: 10) {
                TitleView("DESCRIPTION",Color("ForgroundColor"))
                TextField("About Your Task", text: $taskDescription)
                    .ubuntu(16, .regular)
                    .padding(.top,2)
                Rectangle()
                    .fill(Color("StrokColor"))
                    .frame(height: 1)
                
                TitleView("CATEGORY",Color("ForgroundColor"))
                    .padding(.top, 15)
                
                LazyVGrid(columns: Array(repeating: .init(.flexible(),spacing: 20), count: 3), spacing: 15) {
                    ForEach(Category.allCases,id: \.rawValue) { category in
                        Text(category.rawValue.uppercased())
                            .ubuntu(12, .bold)
                            .hAlign(.center)
                            .padding(.vertical, 5)
                            .background(
                                RoundedRectangle(cornerRadius: 5,style: .continuous)
                                    .fill(category.color.opacity(0.25))
                            )
                            .foregroundColor(category.color)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                guard !animate else{return}
                                animateColor = category.color
                                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 1, blendDuration: 1)) {
                                    animate = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now()+0.7){
                                    animate = false
                                    taskCategory = category
                                }
                            }
                    }
                }
                .padding(.top,5)
                Button {
                    let task = Task(dateAdded: taskDate, taskName: taskName, taskDescription: taskDescription, taskCategory: taskCategory)
                    onAdd(task)
                    dismiss()
                } label: {
                    Text("Create Task")
                        .ubuntu(16, .regular)
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                        .hAlign(.center)
                        .background(
                            Capsule()
                                .fill(animateColor.gradient)
                        )
                }
                .vAlign(.bottom)
                .disabled(taskName == "" || animate)
                .opacity(taskName == "" ? 0.6 : 1)
            }
            .padding(15)
        }
        .vAlign(.top)
    }
    @ViewBuilder
    func TitleView(_ value: String,_ color: Color = .white.opacity(0.7))-> some View{
        Text(value)
            .ubuntu(12, .regular)
            .foregroundColor(color)
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(onAdd: {task in
            
        })
    }
}
