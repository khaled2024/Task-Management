//
//  Extension+Date.swift
//  Task Management
//
//  Created by KhaleD HuSsien on 31/01/2023.
//

import SwiftUI

//MARK: - Date String Ex :-
extension Date{
    func toString(format: String)-> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
