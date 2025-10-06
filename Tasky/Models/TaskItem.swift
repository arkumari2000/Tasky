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
    var id: UUID
    var title: String
    var isCompleted: Bool
    var dueDate: Date
    
    init(title: String = "", isCompleted: Bool = false, dueDate: Date = .distantFuture) {
        self.id = UUID()
        self.title = title
        self.isCompleted = isCompleted
        self.dueDate = dueDate
    }
}

