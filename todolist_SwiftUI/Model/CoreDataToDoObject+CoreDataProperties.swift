//
//  CoreDataToDoObject+CoreDataProperties.swift
//  todolist_SwiftUI
//
//  Created by Stas Bezhan on 16.09.2022.
//
//

import Foundation
import CoreData


extension CoreDataToDoObject: ToDoObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataToDoObject> {
        return NSFetchRequest<CoreDataToDoObject>(entityName: "CoreDataToDoObject")
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var text: String
}

extension CoreDataToDoObject : Identifiable {

}
