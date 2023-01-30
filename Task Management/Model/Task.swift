//
//  Task.swift
//  Task Management
//
//  Created by KhaleD HuSsien on 30/01/2023.
//

import SwiftUI

struct Task: Identifiable{
    var id: UUID = .init()
    var dateAdded: Date
    var taskName: String
    var taskDescription: String
    var taskCategory: Category
}
var sampleTask: [Task] = [
    .init(dateAdded: Date(timeIntervalSince1970: 1675036800), taskName: "new task ", taskDescription: "new swift ui task management", taskCategory: .coding),
    .init(dateAdded: Date(timeIntervalSince1970: 1675123200), taskName: "new task ", taskDescription: "new swift ui task management2", taskCategory: .challenge),
    .init(dateAdded: Date(timeIntervalSince1970: 1674964800), taskName: "new task ", taskDescription: "new swift ui task management3", taskCategory: .bug)
]
