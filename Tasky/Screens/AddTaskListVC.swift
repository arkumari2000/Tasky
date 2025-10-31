//
//  AddTaskListVC.swift
//  Tasky
//
//  Created by Archana Kumari on 11/08/25.
//

import UIKit

class AddTaskListVC: ScrollViewController {
    
    let symbolsList = SymbolList.allSymbols
    
    let sidePadding: CGFloat = 20
    
    var collectionViewHeightConstraint: NSLayoutConstraint!
    
    // Views
    let textField = TaskTextField(placeholderText: "Enter List Name")
    var symbolCollectionView: UICollectionView!
    let submitButton = TaskyButton(backgroundColor: .systemOrange, title: "Add List")
    
    var taskName: String? { textField.text }
    var selectedIcon: String?
    var previouslySelectedIndexPath: IndexPath?
    
    var isSubmitButtonEnabled: Bool {
        return textField.text?.isEmpty == false && selectedIcon?.isEmpty == false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let collectionViewHeight = symbolCollectionView.collectionViewLayout.collectionViewContentSize.height
        collectionViewHeightConstraint.constant = collectionViewHeight
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func configureViews() {
        configureTextField()
        configureCollectionView()
        configureSubmitButton()
    }
    
    func configureTextField() {
        contentView.addSubview(textField)
        textField.becomeFirstResponder()
        textField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sidePadding),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sidePadding),
            textField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func configureCollectionView() {
        symbolCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: UIHelper.createSixColumnFlowlayout(in: view))
        symbolCollectionView.delegate = self
        symbolCollectionView.dataSource = self
        symbolCollectionView.register(SymbolCell.self,
                                      forCellWithReuseIdentifier: SymbolCell.reuseId)
        symbolCollectionView.register(HeaderCell.self,
                                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                      withReuseIdentifier: HeaderCell.reuseId)
        
        contentView.addSubview(symbolCollectionView)
        symbolCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionViewHeightConstraint = symbolCollectionView.heightAnchor.constraint(equalToConstant: 100)
        
        NSLayoutConstraint.activate([
            symbolCollectionView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 50),
            symbolCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            symbolCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            symbolCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            collectionViewHeightConstraint
        ])
    }
    
    func configureSubmitButton() {
        view.addSubview(submitButton)
        
        submitButton.addTarget(self, action: #selector(addTaskList), for: .touchUpInside)
        updateSubmitButton()
        
        NSLayoutConstraint.activate([
            scrollView.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: 10),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidePadding),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sidePadding),
            submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            submitButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}

// HELPER METHODS
private extension AddTaskListVC {
    
    func updateSubmitButton() {
        submitButton.isEnabled = isSubmitButtonEnabled
    }
    
    @objc func addTaskList() {
        guard let name = taskName, let icon = selectedIcon else { return }
        let taskList = TaskList(title: name, icon: icon)
        DataManager.shared.addTaskList(taskList)
        self.popViewController(withAnimation: true)
    }
    
    @objc func dismissKeyboard() {
        textField.resignFirstResponder()
    }
}

extension AddTaskListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return symbolsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.reuseId, for: indexPath) as? HeaderCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(textAlignment: .left, text: "Choose Symbol")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SymbolCell.reuseId, for: indexPath) as! SymbolCell
        if let symbolImage = symbolsList[indexPath.item].image {
            cell.setSymbol(image: symbolImage)
        } else {
            cell.setSymbol(image: UIImage()) // Or set to a placeholder image or clear state
        }
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Deselect previous cell if any
        if let previousIndexPath = previouslySelectedIndexPath, previousIndexPath != indexPath {
            if let previousCell = collectionView.cellForItem(at: previousIndexPath) as? SymbolCell {
                // Reset appearance of previously selected cell
                if let previousSymbol = symbolsList[previousIndexPath.item].image {
                    previousCell.setSymbol(image: previousSymbol, withBackgorundColor: .clear) // Or default color
                }
                collectionView.deselectItem(at: previousIndexPath, animated: true)
            }
        }
        
        // Update current selected cell appearance
        if let cell = collectionView.cellForItem(at: indexPath) as? SymbolCell,
           let symbol = symbolsList[indexPath.item].image {
            cell.setSymbol(image: symbol, withBackgorundColor: .systemCyan)
        }
        
        // Update selected icon and selected index path
        selectedIcon = symbolsList[safe: indexPath.item]?.systemName
        previouslySelectedIndexPath = indexPath
        updateSubmitButton()
    }
    
}

extension AddTaskListVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSubmitButton()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        updateSubmitButton()
        return taskName != nil && selectedIcon != nil
    }
}
