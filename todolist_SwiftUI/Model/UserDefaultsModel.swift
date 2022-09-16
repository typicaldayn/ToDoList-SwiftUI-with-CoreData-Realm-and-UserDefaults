//
//  UserDefaultsModel.swift
//  todolist_SwiftUI
//
//  Created by Stas Bezhan on 16.09.2022.
//

import Foundation

struct UserDefaultsToDoObject: ToDoObject, Codable {
    
    var id: UUID
    
    var text: String
    
    var title: String
    
}
