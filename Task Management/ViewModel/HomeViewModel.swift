//
//  HomeViewModel.swift
//  Task Management
//
//  Created by KhaleD HuSsien on 31/01/2023.
//

import SwiftUI

class HomeViewModel: ObservableObject{
    //MARK: - Proparties:-
    @Published var tasks: [Task] = [] {
        didSet{
            saveItems()
        }
    }
    let tasks_key = "tasks_list"
    init() {
        getItems()
    }
    //MARK: - Functions:-
    func getItems(){
        guard let data = UserDefaults.standard.data(forKey: tasks_key),
              let savedTasks = try? JSONDecoder().decode([Task].self, from: data)
        else{return}
        self.tasks = savedTasks
    }
    
    func saveItems(){
        if let encodedData = try? JSONEncoder().encode(tasks){
            UserDefaults.standard.set(encodedData, forKey: tasks_key)
        }
    }
    
}
