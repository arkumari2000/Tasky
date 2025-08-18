//
//  TaskListVC.swift
//  Tasky
//
//  Created by Archana Kumari on 11/08/25.
//

import UIKit

class TaskListVC: UIViewController {
    
    var taggedCollectionView: UICollectionView!
    
    var taskListData: [TaggedTaskListData]! = DummyTaskListData.dummyDataArray

    override func viewDidLoad() {
        super.viewDidLoad()

        configureVC()
        configureRightButton()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func pushAddTaskListVC() {
        let addTaskListVC = AddTaskListVC()
        addTaskListVC.navigationItem.title = "Add New List"
        navigationController?.pushViewController(addTaskListVC, animated: true)
    }
    
    func configureRightButton() {
        let customButton = UIButton(type: .system)
        customButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        customButton.setTitle("Add List Item", for: .normal)
        customButton.addTarget(self, action: #selector(pushAddTaskListVC), for: .touchUpInside)

        let customBarButtonItem = UIBarButtonItem(customView: customButton)

        navigationController?.navigationBar.topItem?.rightBarButtonItem = customBarButtonItem
    }
    
    func configureVC() {
        view.backgroundColor = .systemBackground
    }
    
    func configureCollectionView() {
        let flowLayout = UIHelper.createColumnFlowlayour(withColumns: 2, in: view, padding: 10, spacing: 12)
        taggedCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: flowLayout)
        taggedCollectionView.dataSource = self
        taggedCollectionView.register(TaggedTaskListCell.self, forCellWithReuseIdentifier: TaggedTaskListCell.reuseId)
        
        view.addSubview(taggedCollectionView)
        
        NSLayoutConstraint.activate([
            taggedCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            taggedCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taggedCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            taggedCollectionView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: 40)
        ])
    }
}

extension TaskListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return taskListData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaggedTaskListCell.reuseId, for: indexPath) as? TaggedTaskListCell else {
            return UICollectionViewCell()
        }
        cell.configureData(with: taskListData[indexPath.item])
        return cell
    }
}
