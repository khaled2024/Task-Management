//
//  TaskCategory.swift
//  Task Management
//
//  Created by KhaleD HuSsien on 30/01/2023.
//

import SwiftUI

enum Category: String,CaseIterable,Codable {
    case general = "General"
    case bug = "Bug"
    case idea = "Idea"
    case modifiers = "Modifiers"
    case challenge = "Challenge"
    case coding = "Coding"
    
    var color: Color{
        switch self {
        case .general:
            return .gray
        case .bug:
            return .green
        case .idea:
            return .pink
        case .modifiers:
            return .blue
        case .challenge:
            return .purple
        case .coding:
            return .brown
        }
    }

}
