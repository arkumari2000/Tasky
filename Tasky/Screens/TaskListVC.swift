//
//  TaskListVC.swift
//  Tasky
//
//  Created by Archana Kumari on 11/08/25.
//

import UIKit

class TaskListVC: UIViewController {
    
    //Views
    let scrollView = UIScrollView()
    let contentView = UIView()
    var taggedCollectionView: UICollectionView!
    let tableTitleView = TaskyTitleLabel(textAlignment: .left, fontSize: 28)
    var taskListTableView = UITableView()
    
    var taskListData: [TaskList] = []
    var flaggedListData: [TaskList] = []
    
    let sidePadding : CGFloat = 10
    
    private var collectionViewHeightConstraint: NSLayoutConstraint!
    private var tableViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fetchTaskList()
        configureVC()
        configureRightButton()
        configureScrollViewAndContentView()
        configureCollectionView()
        configureTableView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        fetchTaskList()
        fetchFlaggedTaskList()
        taskListTableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateCollectionViewHeightConstraint()
        
        // Update table view height based on content size
        taskListTableView.layoutIfNeeded()
        let tableHeight = taskListTableView.contentSize.height
        tableViewHeightConstraint.constant = tableHeight
    }
    
    func fetchTaskList() {
        taskListData = try! DataManager.shared.fetchTaskLists()
    }
    
    func fetchFlaggedTaskList() {
        flaggedListData = try! DataManager.shared.fetchFlaggedTaskLists()
    }
    
    @objc func pushAddTaskListVC() {
        self.presentViewController(viewController: AddTaskListVC(), withTitle: "Add New List", withAnimation: true)
    }
    
    func pushTaskVC(withTitle title: String?, tasksList: TaskList) {
        let taskVC = TaskVC()
        taskVC.taskListData = tasksList
        self.presentViewController(viewController: taskVC, withTitle: title, withAnimation: true)
    }
    
    func updateCollectionViewHeightConstraint() {
        // Update collection view height based on content size
        taggedCollectionView.layoutIfNeeded()
        let collectionHeight = taggedCollectionView.collectionViewLayout.collectionViewContentSize.height
        collectionViewHeightConstraint.constant = collectionHeight
    }
    
    func configureRightButton() {
        let addTaskButton = TaskyAddButton(title: "Add List Item", image: UIImage(systemName: "plus.circle.fill"))
        addTaskButton.addTarget(self, action: #selector(pushAddTaskListVC), for: .touchUpInside)
        let customBarButton = UIBarButtonItem(customView: addTaskButton)

        navigationItem.rightBarButtonItem = customBarButton
    }
    
    func configureVC() {
        view.backgroundColor = .systemBackground
    }
    
    func configureScrollViewAndContentView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
    }
    
    func configureCollectionView() {
        let maxSize = UIHelper.calculateMaxCellSize(for: taskListData, fixedWidth: 200)
        let flowLayout = UIHelper.createColumnFlowlayour(withColumns: 2, in: view, padding: 10, spacing: 12, maxSize: maxSize)
        taggedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        taggedCollectionView.dataSource = self
        taggedCollectionView.delegate = self
        
        taggedCollectionView.register(TaggedTaskListCell.self, forCellWithReuseIdentifier: TaggedTaskListCell.reuseId)
        
        taggedCollectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(taggedCollectionView)
    }
    
    func configureTableView() {
        taskListTableView.register(TaskListTVC.self, forCellReuseIdentifier: TaskListTVC.reuseId)
        taskListTableView.dataSource = self
        taskListTableView.delegate = self
        
        taskListTableView.translatesAutoresizingMaskIntoConstraints = false
        
        taskListTableView.layer.cornerRadius = 10
        taskListTableView.layer.borderColor = UIColor.systemGray5.cgColor
        taskListTableView.layer.borderWidth = 1
        
        taskListTableView.isScrollEnabled = false
        
        tableTitleView.text = "My Lists"
        
        contentView.addSubview(tableTitleView)
        contentView.addSubview(taskListTableView)
    }
    
    func setupConstraints() {
        
        collectionViewHeightConstraint = taggedCollectionView.heightAnchor.constraint(equalToConstant: 100)
        tableViewHeightConstraint = taskListTableView.heightAnchor.constraint(equalToConstant: 100)
        
        // Pin scrollView edges to safe area
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Pin contentView edges to scrollView and equal width
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor) // Important for vertical scroll
        ])
        
        NSLayoutConstraint.activate([
            taggedCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            taggedCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            taggedCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionViewHeightConstraint
        ])
        
        NSLayoutConstraint.activate([
            tableTitleView.topAnchor.constraint(equalTo: taggedCollectionView.bottomAnchor, constant: 20),
            tableTitleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sidePadding + 10),
            tableTitleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sidePadding),
            taskListTableView.topAnchor.constraint(equalTo: tableTitleView.bottomAnchor, constant: 10),
            taskListTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sidePadding),
            taskListTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sidePadding),
            taskListTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            tableViewHeightConstraint
        ])
    }
}

extension TaskListVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flaggedListData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaggedTaskListCell.reuseId, for: indexPath) as? TaggedTaskListCell, let data = flaggedListData[safe: indexPath.item] else {
            return UICollectionViewCell()
        }
        cell.configureData(with: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tasksList = flaggedListData[indexPath.item]
        let count = tasksList.tasks.count
        pushTaskVC(withTitle: "\(tasksList.title) (\(count))", tasksList: tasksList)
    }
}

extension TaskListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskListTVC.reuseId) as? TaskListTVC else {
            return UITableViewCell()
        }
        cell.setData(data: taskListData[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tasksList = taskListData[indexPath.item]
        let count = tasksList.tasks.count
        pushTaskVC(withTitle: "\(taskListData[indexPath.item].title) (\(count))", tasksList: tasksList)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let taskList = taskListData[indexPath.item]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            
            try! DataManager.shared.deleteTaskList(taskList)
            fetchTaskList()

            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .red
        
        let title = !(taskList.flagged ?? false) ? "Flag" : "Unflag"
        let flagAction = UIContextualAction(style: .normal, title: title) { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            
            try! DataManager.shared.updateTaskList(taskList, flagged: !(taskList.flagged ?? false))
            fetchTaskList()
            fetchFlaggedTaskList()
            
            UIView.animate(withDuration: 0.2) {
                self.taggedCollectionView.reloadData()
                self.updateCollectionViewHeightConstraint()
            }

            completionHandler(true)
        }
        
        flagAction.backgroundColor = .systemOrange
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, flagAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
}
