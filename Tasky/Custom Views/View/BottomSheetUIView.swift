//
//  BottomSheetUIView.swift
//  Tasky
//
//  Created by Rishabh Kumar on 29/08/25.
//

import UIKit

protocol BottomSheetUIViewDelegate: AnyObject {
    func addButtonTapped(withText text: String?, date: Date?)
    func editButtonTapped(withText text: String?, date: Date?, task: TaskItem?)
}

class BottomSheetUIView: UIViewController {
    
    var isEditingEnabled: Bool = false
    var task: TaskItem? = nil
    
    let taskField = TaskTextField(placeholderText: "Enter Task Name")
    let cancelButton = TaskyButton(backgroundColor: .systemRed, title: "Cancel")
    let addButton = TaskyButton(backgroundColor: .systemOrange, title: "Add Task", titleColor: .white)
    let datePicker = UIDatePicker()
    let heading = UILabel()
   
    
    var delegate: BottomSheetUIViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureHeading()
        configureTaskField()
        configureDatePicker()
        configureAddButton()
        configureCancelButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureData()
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
            let selectedDate = sender.date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let dateString = dateFormatter.string(from: selectedDate)
            print(dateString)
    }
    
    @objc func addButtonTapped() {
        if isEditingEnabled {
            delegate?.editButtonTapped(withText: taskField.text,
                                       date: datePicker.date,
                                       task: task)
        } else {
            delegate?.addButtonTapped(withText: taskField.text, date: datePicker.date)
        }
        resetData()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelButtonTapped() {
        resetData()
        self.dismiss(animated: true, completion: nil)
    }
    
    func resetData() {
        taskField.text = ""
        isEditingEnabled = false
        task = nil
    }
    
    func configureData() {
        if isEditingEnabled {
            addButton.setTitle("Edit Task", for: .normal)
            heading.text = "Edit Task"
            taskField.text = task?.title
            let dueDate = task?.dueDate ?? .now
            datePicker.setDate(dueDate, animated: true)
        } else {
            addButton.setTitle("Add Task", for: .normal)
            heading.text = "Add Task"
            taskField.text = ""
            datePicker.setDate(.now, animated: true)
        }
    }
    
    func configureHeading(){
        heading.textColor = UIColor.black
        heading.font = UIFont.boldSystemFont(ofSize: 25)
        heading.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(heading)
        NSLayoutConstraint.activate([
            heading.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            heading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
    
    func configureTaskField(){
        view.addSubview(taskField)
        let sidePadding:CGFloat = 20
        
        NSLayoutConstraint.activate([
            taskField.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            taskField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidePadding),
            taskField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sidePadding),
            taskField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func configureDatePicker(){
        view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date // or .time, .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: taskField.topAnchor, constant: 50),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
           datePicker.heightAnchor.constraint(equalToConstant: 155)
        ])
    }
    
    func configureAddButton(){
        view.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 15),
            addButton.trailingAnchor.constraint(equalTo: taskField.trailingAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 175),
            addButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func configureCancelButton(){
        view.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 15),
            cancelButton.leadingAnchor.constraint(equalTo: taskField.leadingAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: 175),
            cancelButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
