//
//  TaskList.swift
//  Tasky
//
//  Created by Archana Kumari on 11/08/25.
//

import Foundation
import SwiftData

@Model
class TaskList: Hashable {
    @Attribute(.unique) var id: UUID = UUID()
    
    var title: String
    var icon: String
    var flagged: Bool?
    @Relationship(deleteRule: .cascade) var tasks = [TaskItem]()
    
    init(title: String, icon: String, flagged: Bool = false) {
        self.title = title
        self.icon = icon
        self.flagged = flagged
    }
    
    var sortedTasks: [TaskItem] {
        tasks.sorted { $0.dueDate < $1.dueDate }
    }
    
    static func ==(lhs: TaskList, rhs: TaskList) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
