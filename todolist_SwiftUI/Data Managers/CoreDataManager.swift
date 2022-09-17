//
//  CoreDataManager.swift
//  todolist_SwiftUI
//
//  Created by Stas Bezhan on 17.09.2022.
//

import Foundation
import CoreData

class CoreDataManager: DataManager {
    
    private let container: NSPersistentContainer
    @Published private var coreDataObjects: [CoreDataToDoObject] = [] //Pub here
    
    init() {
        container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        loadCoreDataObjects()
    }
    
    func add(object: any ToDoObject) {
        let newObject = CoreDataToDoObject(context: container.viewContext)
        newObject.id = object.id
        newObject.text = object.text
        newObject.title = object.title
        saveCoreData()
    }
    
    func delete(at offset: IndexSet) {
        guard let index = offset.first else { return }
        let object = coreDataObjects[index]
        container.viewContext.delete(object)
        saveCoreData()
    }
    
    func fetchObjects(completion: @escaping ([any ToDoObject]) -> ()) {
        var arrayOfToDoObjects: [any ToDoObject] = []
        coreDataObjects.forEach { object in
            arrayOfToDoObjects.append(object)
        }
        completion(arrayOfToDoObjects)
    }
    
    private func saveCoreData() {
        do {
            try container.viewContext.save()
            loadCoreDataObjects()
        } catch let error {
            print("Error saving: \(error.localizedDescription)")
        }
    }
    
    private func loadCoreDataObjects() {
        let request = NSFetchRequest<CoreDataToDoObject>(entityName: "CoreDataToDoObject")
        do {
            coreDataObjects = try container.viewContext.fetch(request)
        } catch let error {
            fatalError("Error fetching: \(error.localizedDescription)")
        }
    }
    
}
