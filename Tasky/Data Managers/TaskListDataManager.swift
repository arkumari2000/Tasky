//
//  TaskListDataManager.swift
//  Tasky
//
//  Created by Archana Kumari on 22/08/25.
//

import Foundation
import SwiftData

@MainActor
class DataManager {
    static let shared = try! DataManager()

    private let container: ModelContainer
    private var context: ModelContext { container.mainContext }

    init() throws {
        self.container = try ModelContainer(for: TaskList.self)
    }

    // MARK: - TaskList CRUD

    func addTaskList(_ taskList: TaskList) {
        context.insert(taskList)
    }

    func fetchTaskLists() throws -> [TaskList] {
        let descriptor = FetchDescriptor<TaskList>()
        return try context.fetch(descriptor)
    }
    
    func fetchFlaggedTaskLists() throws -> [TaskList] {
        let predicate = #Predicate<TaskList> { tasklist in
            tasklist.flagged == true
        }
        let descriptor = FetchDescriptor<TaskList>(predicate: predicate)
        return try context.fetch(descriptor)
    }

    func updateTaskList(_ taskList: TaskList, flagged: Bool) throws {
        taskList.flagged = flagged
        try context.save()
    }

    func deleteTaskList(_ taskList: TaskList) throws {
        context.delete(taskList)
        try context.save()
    }

    // MARK: - TaskItem CRUD (optional helpers)

    func addTaskToList(_ task: TaskItem, taskList: TaskList) throws {
        taskList.tasks.append(task)
        context.insert(task)
        try context.save()
    }
    
    func updateTaskToList(_ task: TaskItem, taskList: TaskList) throws {
        if ((taskList.tasks.contains(where: {$0.id == task.id})) != nil) {
            task.isCompleted.toggle()
        }
        try context.save()
    }

    func deleteTask(_ task: TaskItem, from taskList: TaskList) throws {
        // Remove task from the TaskList's tasks array
        taskList.tasks.removeAll(where: { $0 == task })

        // Delete task from context
        context.delete(task)

        // If no tasks left, delete the TaskList as per requirement
        if taskList.tasks.isEmpty {
            context.delete(taskList)
        }

        try context.save()
    }
}

