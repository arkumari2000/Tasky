//
//  TaskVC.swift
//  Tasky
//
//  Created by Archana Kumari on 11/08/25.
//

import UIKit

class TaskVC: UIViewController {
    
    var tasks: [TaskItem] = DummyTasks.dummyDataArray
    
    let tasksTableView = UITableView()
    let addButton = TaskyAddButton()
    let myBottomSheetView = BottomSheetUIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureTableView()
        configureAddTaskButton()
    }
    
    func configureAddTaskButton() {
        let addTaskButton = TaskyAddButton(title: "Add New Task", image: UIImage(systemName: "plus.circle.fill"))
        addTaskButton.addTarget(self, action: #selector(customButtonTapped), for: .touchUpInside)
        let customBarButton = UIBarButtonItem(customView: addTaskButton)
        
        navigationItem.rightBarButtonItem = customBarButton
    }
    
    @objc func customButtonTapped() {
        
        let navVC = UINavigationController(rootViewController: myBottomSheetView)
        navVC.modalPresentationStyle = .pageSheet
        
        if let sheet = navVC.sheetPresentationController {
            sheet.detents = [.custom ( resolver:  { context in 0.3*context.maximumDetentValue } ) ]
            sheet.preferredCornerRadius = 24
            sheet.prefersGrabberVisible = true
        }
        present(navVC, animated: true, completion: nil)
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
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTVC.reuseId, for:  indexPath) as? TaskTVC, let task = tasks[safe: indexPath.item] else {
            return UITableViewCell()
        }
        cell.setData(with: task.title, isCompleted: task.isCompleted)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //didTapButton(in: cell)
    }
}
