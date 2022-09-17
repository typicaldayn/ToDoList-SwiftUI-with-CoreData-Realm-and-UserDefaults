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
    
    func add(object: any ToDoObject) {
        let newObject = RealmToDoObject()
        newObject.title = object.title
        newObject.text = object.text
        newObject.id = object.id
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
