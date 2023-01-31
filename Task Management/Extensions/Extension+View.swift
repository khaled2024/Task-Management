//
//  Extension+View.swift
//  Task Management
//
//  Created by KhaleD HuSsien on 31/01/2023.
//

import SwiftUI


//MARK: - Alignment extentions
extension View{
    func hAlign(_ alignment: Alignment)-> some View{
        self.frame(maxWidth: .infinity,alignment: alignment)
    }
    func vAlign(_ alignment: Alignment)-> some View{
        self.frame(maxHeight: .infinity,alignment: alignment)
    }
}
