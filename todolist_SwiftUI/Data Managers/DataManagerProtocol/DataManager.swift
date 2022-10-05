//
//  Protocol.swift
//  todolist_SwiftUI
//
//  Created by Stas Bezhan on 17.09.2022.
//

import Foundation

protocol DataManager {
    
    func add(title: String, description: String)
    
    func delete(at offset: IndexSet)
    
    func fetchObjects(completion: @escaping ([any ToDoObject]) -> ())
    
}
