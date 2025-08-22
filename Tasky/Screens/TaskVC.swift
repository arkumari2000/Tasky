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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
    
        configureTableView()
        configureAddTaskButton()
    }

    func configureAddTaskButton() {
        let customButton = UIButton(type: .system)
        customButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        customButton.setTitle("Add New Task", for: .normal)
        customButton.addTarget(self, action: #selector(customButtonTapped), for: .touchUpInside)
        
        let customBarButton = UIBarButtonItem(customView: customButton)
        
        navigationItem.rightBarButtonItem = customBarButton
    }
    @objc func customButtonTapped() {
        print("custom button tapped")
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
        return cell
    }
    
    
}
