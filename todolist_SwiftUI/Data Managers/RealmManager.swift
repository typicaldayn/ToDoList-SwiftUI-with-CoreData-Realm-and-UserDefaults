//
//  RealmManager.swift
//  todolist_SwiftUI
//
//  Created by Stas Bezhan on 17.09.2022.
//

import Foundation
import RealmSwift

class RealmManager: DataManager {
    
    @ObservedResults(RealmToDoObject.self) private var realmObjets
    
    func add(title: String, description: String) {
        let newObject = RealmToDoObject()
        newObject.title = title
        newObject.text = description
        newObject.id = UUID()
        _realmObjets.append(newObject)
    }
    
    func delete(at offset: IndexSet) {
        _realmObjets.remove(atOffsets: offset)
    }
    
    func fetchObjects(completion: @escaping ([any ToDoObject]) -> ()) {
        var toDoObjectsArray: [any ToDoObject] = []
        realmObjets.forEach { object in
            toDoObjectsArray.append(object)
        }
        completion(toDoObjectsArray)
    }
    
    
}
