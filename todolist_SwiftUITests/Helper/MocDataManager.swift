//
//  MocDataManager.swift
//  todolist_SwiftUITests
//
//  Created by Stas Bezhan on 27.09.2022.
//
//

import Foundation
@testable import todolist_SwiftUI

class MocDataManager: DataManager {
    
    private var testMocObjects: [MocToDoOject] = []
    
    func add(title: String, description: String) {
        let newObject: MocToDoOject = MocToDoOject(id: UUID(),
                                                   text: title,
                                                   title: description)
        testMocObjects.append(newObject)
    }

    func delete(at offset: IndexSet) {
        guard let index = offset.first else { return }
        testMocObjects.remove(at: index)
    }

    func fetchObjects(completion: @escaping ([any ToDoObject]) -> ()) {
        var toDoObjectsArray: [any ToDoObject] = []
        testMocObjects.forEach { object in
            toDoObjectsArray.append(object)
        }
        completion(toDoObjectsArray)
    }


}
