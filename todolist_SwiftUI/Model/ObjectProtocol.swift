//
//  Protocol.swift
//  todolist_SwiftUI
//
//  Created by Stas Bezhan on 17.09.2022.
//

import Foundation


protocol ToDoObject: Identifiable, Hashable {
    var id: UUID { get set }
    var text: String { get set }
    var title: String { get set }
}
