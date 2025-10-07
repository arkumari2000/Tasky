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
        let navVC = UINavigationController(rootViewController: addTaskBottomSheet)
        navVC.modalPresentationStyle = .pageSheet
        
        if let sheet = navVC.sheetPresentationController {
            sheet.detents = [.custom ( resolver:  { context in 0.3*context.maximumDetentValue } ) ]
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
        cell.setData(with: task.title, isCompleted: task.isCompleted)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //didTapButton(in: cell)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let self = self, let taskListData = taskListData,  let task = taskListData.tasks[safe: indexPath.item] else { return }
            
            try! DataManager.shared.deleteTask(task, from: taskListData)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.reloadTitle()
            
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
}

extension TaskVC: BottomSheetUIViewDelegate {

    func addButtonTapped(withText text: String?) {
        guard let taskList = taskListData, let title = text else { return }
        let taskItem = TaskItem(title: title)
        try! DataManager.shared.addTaskToList(taskItem, taskList: taskList)
        tasksTableView.reloadData()
        reloadTitle()
    }
}
