//
//  MainView-ViewModel.swift
//  todolist_SwiftUI
//
//  Created by Stas Bezhan on 16.09.2022.
//

import Foundation

@MainActor class ViewModel: ObservableObject {
    
    enum DataBaseTypes: String {
        
        case realm = "Realm"
        
        case coreData = "Core Data"
        
        case userDefaults = "User Defaults"
        
    }
    
    @Published var currentType = DataBaseTypes.realm
    @Published var savingTypes: [DataBaseTypes] = [.realm, .coreData, .userDefaults]
    @Published var alertPresenting = false
    @Published var title = ""
    @Published var text = ""
    
    @Published var objects: [any ToDoObject] = []
    @Published var dataManager: (any DataManager) = RealmManager() {
        didSet {
            getObjects()
        }
    }
    
    
    init() {
        getObjects()
    }
    
    func changeDataManager() {
        switch currentType {
        case DataBaseTypes.realm:
            dataManager = RealmManager()
        case DataBaseTypes.coreData:
            dataManager = CoreDataManager()
        case DataBaseTypes.userDefaults:
            dataManager = UserDefaultsManager()
        default:
            print("Error while changed data manager")
        }
    }
    
    func addNewObject() {
        dataManager.add(title: title, description: text)
        getObjects()
        text = ""
        title = ""
    }
    
    func delete(at offset: IndexSet) {
        dataManager.delete(at: offset)
        getObjects()
    }
   
    private func getObjects() {
        dataManager.fetchObjects { toDoObjectsArray in
            self.objects = toDoObjectsArray
        }
    }
    
}
