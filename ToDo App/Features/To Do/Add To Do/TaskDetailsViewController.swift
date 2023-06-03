//
//  TaskDetailsViewController.swift
//  ToDo

import UIKit
import ReSwift

class TaskDetailsViewController: BaseViewController, StoreSubscriber {
    
    @IBOutlet private weak var taskTitleTextField: UITextField!
    @IBOutlet private weak var subTasksTextView: UITextView!
    @IBOutlet private weak var endDateTextField: UITextField!
    @IBOutlet weak var saveButton: ToDoButton!
    
    var endDate : String = ""
    var endDatePicker: UIDatePicker!
    var dateFormatter: DateFormatter = DateFormatter()
    var selectedDateTimeStamp: Double?
    var selectedToDo: Task?
    var selectedIndex: Int?
    var isEdit: Bool?
    var toDoFlag: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainStore.subscribe(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        mainStore.unsubscribe(self)
    }
    
    func newState(state: AppState) {
        if (self.navigationController?.topViewController != self) {
            return
        }
        
        guard let errorMessage = state.todoDetailState.errorMessage else { return }
        
        if !errorMessage.isEmpty {
            showAlert(message: errorMessage)
            return
        }
        
        if toDoFlag {
            return
        }
        
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonDisplayMode = .minimal

        endDatePicker = UIDatePicker()
        endDatePicker.addTarget(self, action: #selector(didPickDate(_:)), for: .valueChanged)
        endDatePicker.minimumDate = Date()
        endDateTextField.inputView = endDatePicker
        dateFormatter.dateStyle = .medium
        subTasksTextView.addBorder()
        taskTitleTextField.delegate = self

        updateUI()
    }
    
    func updateUI() {
        guard let selectedToDo = selectedToDo else { return }
        taskTitleTextField.text = selectedToDo.title
        subTasksTextView.text = selectedToDo.subTasks
        endDateTextField.text = selectedToDo.dueDate
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        toDoFlag = false
        if let modifyToDo = isEdit, modifyToDo {
            mainStore.dispatch(
                ToDoDetailState.updateToDoList(
                    title: self.taskTitleTextField.text ?? "",
                    subTasks: self.subTasksTextView.text ?? "",
                    dueDate: self.endDateTextField.text ?? "",
                    timeStamp: selectedDateTimeStamp,
                    index: selectedIndex)
            )
        } else {
            mainStore.dispatch(
                ToDoDetailState.addToDoList(
                    title: self.taskTitleTextField.text ?? "",
                    subTasks: self.subTasksTextView.text ?? "",
                    dueDate: self.endDateTextField.text ?? "",
                    timeStamp: selectedDateTimeStamp)
            )
        }
    }
    
    @objc func didPickDate(_ sender: UIDatePicker) {
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        let selectedDate = sender.date
        self.selectedDateTimeStamp = sender.date.timeIntervalSince1970
        endDate = dateFormatter.string(from: selectedDate)
        endDateTextField.text = endDate
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)

        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
extension TaskDetailsViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == taskTitleTextField {
            textField.resignFirstResponder()
            return true
        }
        return false
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .placeholderText {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = .placeholderText
        }
    }
}
