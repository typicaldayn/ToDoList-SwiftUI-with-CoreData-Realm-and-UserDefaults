//
//  UserDefaultsManager.swift
//  todolist_SwiftUI
//
//  Created by Stas Bezhan on 17.09.2022.
//

import Foundation

class UserDefaultsManager: DataManager {
    
    @Published private var userDefaultsObjects: [UserDefaultsToDoObject] = [] {
        didSet {
            saveUDObjects()
        }
    }

    init() {
        getUDObjects()
    }
    
    
    func add(object: any ToDoObject) {
        let newObject = UserDefaultsToDoObject(id: object.id, text: object.text, title: object.title)
        userDefaultsObjects.append(newObject)
    }
    
    func delete(at offset: IndexSet) {
        userDefaultsObjects.remove(atOffsets: offset)
    }
    
    func fetchObjects(completion: @escaping ([any ToDoObject]) -> ()) {
        var toDoObjectsArray: [any ToDoObject] = []
        userDefaultsObjects.forEach { object in
            toDoObjectsArray.append(object)
        }
        completion(toDoObjectsArray)
    }
    
    private func getUDObjects() {
        guard let data = UserDefaults.standard.data(forKey: "UD_Objects"),
              let decoded = try? JSONDecoder().decode([UserDefaultsToDoObject].self, from: data)
        else { return }
        userDefaultsObjects = decoded
    }
    
    private func saveUDObjects() {
        if let encoded = try? JSONEncoder().encode(userDefaultsObjects) {
            UserDefaults.standard.set(encoded, forKey: "UD_Objects")
        }
    }
    
    
}
