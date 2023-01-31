//
//  Task.swift
//  Task Management
//
//  Created by KhaleD HuSsien on 30/01/2023.
//

import Foundation
struct Task: Identifiable, Codable{
    var id: UUID = .init()
    var dateAdded: Date
    var taskName: String
    var taskDescription: String
    var taskCategory: Category
}
