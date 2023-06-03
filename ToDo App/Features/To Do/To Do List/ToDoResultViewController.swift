//
//  ToDoResultViewController.swift
//

import Foundation
import UIKit
import ReSwift

final class ToDoResultViewController: BaseViewController, StoreSubscriber {
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate var taskList = [Task]()
    
    var selectedTask: Task?
    var selectedIndex: Int?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainStore.subscribe(self)
        
        if tableView != nil {
            mainStore.dispatch(ToDoResultState.getToDoList())
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        mainStore.unsubscribe(self)
    }
    
    func newState(state: AppState) {
        guard let updatedTaskList = state.todoResultState.todoList else { return }
        taskList = updatedTaskList
        tableView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.backButtonDisplayMode = .minimal
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(R.nib.toDoResultCell)
        
        mainStore.dispatch(ToDoResultState.getToDoList())
    }
    
    // MARK: - Actions
    @IBAction func addTask(_ sender: UIButton) {
        let addTaskVC = R.storyboard.taskDetails.taskDetailsViewController()!
        addTaskVC.isEdit = false
        addTaskVC.toDoFlag = true
        navigationController?.pushViewController(addTaskVC, animated: true)
    }
    
    func modifyTask() {
        guard let task = self.selectedTask else { return }
        guard let title = task.title else { return }
        let alertController = UIAlertController(title: "Task \(title)", message: nil, preferredStyle: .alert)
        let editAction = UIAlertAction(title: "Edit", style: .default, handler: { (action) -> Void in
            let editTaskVC = R.storyboard.taskDetails.taskDetailsViewController()!
            editTaskVC.selectedToDo = self.selectedTask
            editTaskVC.selectedIndex = self.selectedIndex
            editTaskVC.isEdit = true
            editTaskVC.toDoFlag = true
            self.navigationController?.pushViewController(editTaskVC, animated: true)
        })

        let deleteAction = UIAlertAction(title: "Delete", style: .default, handler: { (action) -> Void in
            mainStore.dispatch(ToDoResultState.deleteToDoEntry(index: self.selectedIndex))
        })

        alertController.addAction(deleteAction)
        alertController.addAction(editAction)

        present(alertController, animated: true, completion: nil)
    }
}

extension ToDoResultViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTask = taskList[indexPath.row]
        selectedIndex = indexPath.row
        modifyTask()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let topSeparator = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 2))
        topSeparator.backgroundColor = R.color.off_black()
        return topSeparator
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let bottomSeparator = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 2))
        bottomSeparator.backgroundColor = R.color.off_black()
        return bottomSeparator
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
}

extension ToDoResultViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.toDoResultCell, for: indexPath), taskList.count > 0 {
            cell.configure(with: taskList[indexPath.row])
            
            return cell
        }
        return UITableViewCell()
    }
}

