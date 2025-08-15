//
//  AddTaskListVC.swift
//  Tasky
//
//  Created by Archana Kumari on 11/08/25.
//

import UIKit

class AddTaskListVC: UIViewController {

    let textField = TaskTextField(placeholderText: "Enter List Name")
    let sidePadding: CGFloat = 20
    
    var symbolCollectionView: UICollectionView!
    let symbolsList = SymbolList.allSymbols

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func configureViews() {
        configureTextField()
        configureCollectionView()
    }

    func configureTextField() {
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidePadding),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sidePadding),
            textField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func configureCollectionView() {
        symbolCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: UIHelper.createSixColumnFlowlayout(in: view))
        symbolCollectionView.delegate = self
        symbolCollectionView.dataSource = self
        symbolCollectionView.register(SymbolCell.self, forCellWithReuseIdentifier: SymbolCell.reuseId)
        
        symbolCollectionView.layer.cornerRadius = 2
        symbolCollectionView.backgroundColor = .systemGray
        
        view.addSubview(symbolCollectionView)
        symbolCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            symbolCollectionView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 50),
            symbolCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidePadding),
            symbolCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sidePadding),
            symbolCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 30)
        ])
    }
}

extension AddTaskListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return symbolsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SymbolCell.reuseId, for: indexPath) as! SymbolCell
        guard let symbol = symbolsList[indexPath.item] else { return UICollectionViewCell() }
        cell.setSymbol(image: symbol)
        return cell
    }
    
}
