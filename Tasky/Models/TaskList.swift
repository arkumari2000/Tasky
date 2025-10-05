//
//  TaskList.swift
//  Tasky
//
//  Created by Archana Kumari on 11/08/25.
//

import Foundation
import SwiftData

@Model
class TaskList {
    var title: String
    var icon: String
    @Relationship(deleteRule: .cascade) var tasks = [TaskItem]()
    
    init(title: String, icon: String) {
        self.title = title
        self.icon = icon
    }
}
