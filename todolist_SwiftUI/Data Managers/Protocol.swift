//
//  Protocol.swift
//  todolist_SwiftUI
//
//  Created by Stas Bezhan on 17.09.2022.
//

import Foundation

protocol DataManager {
    func add(object: any ToDoObject)
    func delete(at offset: IndexSet)
    func fetchObjects(completion: @escaping ([any ToDoObject]) -> ())
}
 
