//
//  Task.swift
//  Tasky
//
//  Created by Archana Kumari on 11/08/25.
//

import Foundation
import SwiftData

@Model
class TaskItem {
    var title: String
    var isCompleted: Bool
    var dueDate: Date
    var priority: Int
    
    init(title: String, isCompleted: Bool, dueDate: Date, priority: Int) {
        self.title = title
        self.isCompleted = isCompleted
        self.dueDate = dueDate
        self.priority = priority
    }
}
