//
//  RealmModel.swift
//  todolist_SwiftUI
//
//  Created by Stas Bezhan on 16.09.2022.
//

import Foundation
import RealmSwift

class RealmToDoObject: Object, ToDoObject {
    
    @Persisted var id: UUID
    @Persisted var title: String
    @Persisted var text: String
}
