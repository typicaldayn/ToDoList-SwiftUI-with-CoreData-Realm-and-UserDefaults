//
//  MainView-ViewModel.swift
//  todolist_SwiftUI
//
//  Created by Stas Bezhan on 16.09.2022.
//

import RealmSwift
import CoreData
import Foundation


extension MainView {
    
    @MainActor class ViewModel: ObservableObject {
        @Published var currentType = "Realm"
        @Published var savingTypes = ["Realm", "Core Data", "User Defaults"]
        @Published var alertPresenting = false
        @Published var title = ""
        @Published var text = ""
        
        //arrays of different storages
        private let realm = try! Realm(configuration: .defaultConfiguration)
        @ObservedResults(RealmToDoObject.self) private var realmObjects
        
        private let persistentContainer: NSPersistentContainer
        
        init() {
            self.persistentContainer = NSPersistentContainer(name: "CoreDataModel")
            self.persistentContainer.loadPersistentStores { (description, error) in
                if let error = error {
                    fatalError("Error while loading Core Data: \(error)")
                }
            }
            getUDObjects()
            fetchCoreDataObjects()
        }
        //Core Data objects
        @Published private var coreDataObjects: [CoreDataToDoObject] = []
        
        private func fetchCoreDataObjects() {
            let request = NSFetchRequest<CoreDataToDoObject>(entityName: "CoreDataToDoObject")
            do {
                coreDataObjects = try persistentContainer.viewContext.fetch(request)
            } catch let error {
                fatalError("Error fetching: \(error.localizedDescription)")
            }
        }
        
        @Published private var userDefaultsObjects: [UserDefaultsToDoObject] = [] {
            didSet {
                saveUDObjects()
            }
        }
        
        //Array for list
        var results: [any ToDoObject] {
            var toDoArray: [any ToDoObject]
            if currentType == "Realm" {
                let realmArray = realm.objects(RealmToDoObject.self)
                toDoArray = []
                realmArray.forEach { object in
                    toDoArray.append(object)
                }
                return toDoArray
            } else if currentType == "Core Data" {
                toDoArray = []
                coreDataObjects.forEach { object in
                    toDoArray.append(object)
                }
                return toDoArray
            } else if currentType == "User Defaults" {
                toDoArray = []
                userDefaultsObjects.forEach { object in
                    toDoArray.append(object)
                }
                return toDoArray
            } else {
                fatalError("error loading")
            }
        }
        
    }
    
}

//Data
extension MainView.ViewModel {
    
    //Public methods
    func add() {
        if currentType == "Realm" {
            addToRealm()
        } else if currentType == "Core Data" {
            addToCoreData()
        } else if currentType == "User Defaults" {
            addToUserDefaults()
        }
        text = ""
        title = ""
    }
    
    func delete(at offset: IndexSet) {
        if currentType == "Realm" {
            deleteInRealm(at: offset)
        } else if currentType == "Core Data" {
            deleteInCoreData(at: offset)
        } else if currentType == "User Defaults" {
            deleteInUserDefaults(at: offset)
        }
    }
    
    //Realm methods
    private func addToRealm() {
        guard currentType == "Realm" else { return }
        let newObject = RealmToDoObject()
        newObject.id = UUID()
        newObject.text = text
        newObject.title = title
        $realmObjects.append(newObject)
    }
    
    private func deleteInRealm(at offset: IndexSet) {
        $realmObjects.remove(atOffsets: offset)
    }
    
    //Core Data methods
    private func addToCoreData() {
        let newObject = CoreDataToDoObject(context: persistentContainer.viewContext)
        newObject.title = title
        newObject.text = text
        newObject.id = UUID()
        saveCoreData()
    }
    
    private func saveCoreData() {
        do {
            try persistentContainer.viewContext.save()
            fetchCoreDataObjects()
        } catch let error {
            print("Error saving: \(error.localizedDescription)")
        }
    }
    
    private func deleteInCoreData(at offset: IndexSet) {
        guard let index = offset.first else { return }
        let object = coreDataObjects[index]
        persistentContainer.viewContext.delete(object)
        saveCoreData()
    }
    
    //User Defaults methods
    private func addToUserDefaults() {
        let newObject = UserDefaultsToDoObject(id: UUID(), text: text, title: title)
        userDefaultsObjects.append(newObject)
    }
    
    private func deleteInUserDefaults(at offset: IndexSet) {
        userDefaultsObjects.remove(atOffsets: offset)
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
