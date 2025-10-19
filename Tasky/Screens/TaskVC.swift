//
//  TaskVC.swift
//  Tasky
//
//  Created by Archana Kumari on 11/08/25.
//

import UIKit

class TaskVC: UIViewController {
    
    var taskListData: TaskList?
    
    let tasksTableView = UITableView()
    let addButton = TaskyAddButton()
    let addTaskBottomSheet = BottomSheetUIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureBottomSheet()
        configureTableView()
        configureAddTaskButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func reloadTitle() {
        guard let taskList = taskListData else { return }
        let title = "\(taskList.title) (\(taskList.tasks.count))"
        self.navigationItem.title = title
    }
    
    func configureAddTaskButton() {
        let addTaskButton = TaskyAddButton(title: "Add New Task", image: UIImage(systemName: "plus.circle.fill"))
        addTaskButton.addTarget(self, action: #selector(addTaskButtonTapped), for: .touchUpInside)
        let customBarButton = UIBarButtonItem(customView: addTaskButton)
        
        navigationItem.rightBarButtonItem = customBarButton
    }
    
    @objc func addTaskButtonTapped() {
        openTaskBottomSheet()
    }
    
    func openTaskBottomSheet(with task: TaskItem? = nil, isEditing: Bool = false) {
        addTaskBottomSheet.isEditingEnabled = isEditing
        addTaskBottomSheet.task = task
        
        let navVC = UINavigationController(rootViewController: addTaskBottomSheet)
        navVC.modalPresentationStyle = .pageSheet
        
        if let sheet = navVC.sheetPresentationController {
            sheet.detents = [.custom ( resolver:  { context in 0.5*context.maximumDetentValue } ) ]
            sheet.preferredCornerRadius = 24
            sheet.prefersGrabberVisible = true
        }
        present(navVC, animated: true, completion: nil)
    }
    
    func configureBottomSheet() {
        addTaskBottomSheet.delegate = self
    }
    
    func configureTableView() {
        tasksTableView.register(TaskTVC.self, forCellReuseIdentifier: TaskTVC.reuseId)
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
        tasksTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tasksTableView)
        NSLayoutConstraint.activate([
            tasksTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tasksTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
    
}

extension TaskVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskListData?.tasks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTVC.reuseId, for:  indexPath) as? TaskTVC, let task = taskListData?.tasks[safe: indexPath.item] else {
            return UITableViewCell()
        }
        cell.setData(with: task)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let taskList = taskListData,
              let task = taskList.tasks[safe: indexPath.item] else {
            return
        }
        try? DataManager.shared.completeTask(task, taskList: taskList)
        
        // Refresh table view UI first
        self.refreshTaskListsUI { [weak self] in
            guard let self = self else { return }
            
            // Schedule deletion after a 2-second delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                try? DataManager.shared.deleteTask(task, from: taskList)
                
                // Animate row deletion
                self.tasksTableView.beginUpdates()
                self.tasksTableView.deleteRows(at: [indexPath], with: .automatic)
                self.tasksTableView.endUpdates()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let taskListData = taskListData,
              let task = taskListData.tasks[safe: indexPath.item] else { return nil }
        
        let deleteAction = makeDeleteAction(task,
                                            from: taskListData,
                                            at: indexPath,
                                            tableView: tableView)
        
        let editAction = makeEditAction(for: task)
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction,editAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
}

extension TaskVC: BottomSheetUIViewDelegate {
    
    func addButtonTapped(withText text: String?, date: Date?) {
        guard let taskList = taskListData, let title = text else { return }
        let Date = date ?? Date()
        let taskItem = TaskItem(title: title, dueDate: Date)
        try! DataManager.shared.addTaskToList(taskItem, taskList: taskList)
        tasksTableView.reloadData()
        reloadTitle()
    }
    
    func editButtonTapped(withText text: String?, date: Date?, task: TaskItem?) {
        guard let taskList = taskListData, let title = text, let task = task else { return }
        let Date = date ?? Date()
        let taskItem = TaskItem(title: title, dueDate: Date)
        try! DataManager.shared.updateTask(task, taskList: taskList, with: taskItem)
        tasksTableView.reloadData()
        reloadTitle()
    }
}

private extension TaskVC {
    func makeDeleteAction(_ task: TaskItem,
                          from taskList: TaskList,
                          at indexPath: IndexPath,
                          tableView: UITableView) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            try? DataManager.shared.deleteTask(task, from: taskList)
            self.refreshTaskListsUI()
            completionHandler(true)
        }
        action.backgroundColor = .red
        return action
    }
    
    func makeEditAction(for task: TaskItem) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Edit") { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            openTaskBottomSheet(with: task, isEditing: true)
        }
        action.backgroundColor = .systemOrange
        return action
    }
    
    func refreshTaskListsUI(completion: (() -> Void)? = nil) {
        reloadTitle()
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.tasksTableView.reloadData()
        }, completion: { _ in
            completion?()
        })
    }
}
