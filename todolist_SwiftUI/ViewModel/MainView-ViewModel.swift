//
//  MainView-ViewModel.swift
//  todolist_SwiftUI
//
//  Created by Stas Bezhan on 16.09.2022.
//

import Foundation

@MainActor class ViewModel: ObservableObject {
    
    @Published var currentType = Types.realm.rawValue
    @Published var savingTypes = [Types.realm.rawValue, Types.coreData.rawValue, Types.userDefaults.rawValue]
    @Published var alertPresenting = false
    @Published var title = ""
    @Published var text = ""
    
    @Published var objects: [any ToDoObject] = []
    @Published var dataManager: (any DataManager) = RealmManager() {
        didSet {
            setObjects()
        }
    }
    
    
    func changeDataManager() {
        
        switch currentType {
        case Types.realm.rawValue:
            dataManager = RealmManager()
        case Types.coreData.rawValue:
            dataManager = CoreDataManager()
        case Types.userDefaults.rawValue:
            dataManager = UserDefaultsManager()
        default:
            print("Error while changed data manager")
        }
    }
    
    func setObjects() {
        dataManager.fetchObjects { unTypedArray in
            self.objects = unTypedArray
        }
    }
    
    init() {
        setObjects()
    }
    
}
