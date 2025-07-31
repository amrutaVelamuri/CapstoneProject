//
//  ToDoItem.swift
//  CapstoneProject
//
//  Created by Ranjan Verma on 7/29/25.
//

import Foundation
import SwiftData

@Model
class ToDoItem {
    var title: String
    var isImportant: Bool
    var dueDate: Date
    
    init(title: String, isImportant: Bool, dueDate: Date) {
        self.title = title
        self.isImportant = isImportant
        self.dueDate = dueDate
    }
    
}
