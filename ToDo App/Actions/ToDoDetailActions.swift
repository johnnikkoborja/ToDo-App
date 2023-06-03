//
//  ToDoDetailActions.swift
//  ToDo App
//
//  Created by John Nikko Borja on 6/3/23.
//

import Foundation
import ReSwift

extension ToDoDetailState {
    public static func addToDoList(title: String, subTasks: String, dueDate: String, timeStamp: Double?) -> AddTodoList {
        if title.isReallyEmpty || subTasks.isReallyEmpty || dueDate.isReallyEmpty {
            mainStore.dispatch(ModifyToDoListAction(errorMessage: R.string.localizable.commonError()))
            return AddTodoList()
        }
        
        // Get user
        let userId = UserDefaultsManager.getValue(key: R.string.localizable.userEmailId())
        let userList = TaskManager.getUserList()
        let user = TaskManager.getUser(with: userId, userList: userList)
        var updatedTaskList: [Task] = []
        let updatedUserList: UserList?
        
        // Set Task list
        let task = Task.init(title: title, subTasks: subTasks, dueDate: dueDate, timeStamp: timeStamp)
        updatedTaskList.append(task)
        
        if user?.todoList == nil {
            user?.todoList = updatedTaskList
        } else {
            user?.todoList?.append(task)
        }
        
        // Write User/s
        updatedUserList = UserList.init(userList: userList?.userList?.filter({ user?.email != $0.email }))
        if let user = user {
            updatedUserList?.userList?.append(user)
            TaskManager.writeUsers(userList: updatedUserList)
            mainStore.dispatch(ModifyToDoListAction(errorMessage: ""))
        }
        
        return AddTodoList()
    }
    
    public static func updateToDoList(title: String, subTasks: String, dueDate: String, timeStamp: Double?, index: Int?) -> UpdateToDoList {
        if title.isReallyEmpty || subTasks.isReallyEmpty || dueDate.isReallyEmpty {
            mainStore.dispatch(ModifyToDoListAction(errorMessage: R.string.localizable.commonError()))
            return UpdateToDoList()
        }
        
        // Get user
        let userId = UserDefaultsManager.getValue(key: R.string.localizable.userEmailId())
        let userList = TaskManager.getUserList()
        let user = TaskManager.getUser(with: userId, userList: userList)
        var updatedTaskList: [Task]?
        let updatedUserList: UserList?
        
        // Getting list
        updatedTaskList = user?.todoList
        
        // Get task to update
        if let index = index {
            updatedTaskList?.remove(at: index)
            
            let updatedTask = Task.init(title: title, subTasks: subTasks, dueDate: dueDate, timeStamp: timeStamp)
            updatedTaskList?.insert(updatedTask, at: index)
            
            // Write User/s
            user?.todoList = updatedTaskList
            updatedUserList = UserList.init(userList: userList?.userList?.filter({ user?.email != $0.email }))
            if let user = user {
                updatedUserList?.userList?.append(user)
                TaskManager.writeUsers(userList: updatedUserList)
                mainStore.dispatch(ModifyToDoListAction(errorMessage: ""))
            }
        }
        return UpdateToDoList()
    }
}

struct AddTodoList: Action {}
struct UpdateToDoList: Action {}


struct ModifyToDoListAction: Action {
    let errorMessage: String
}
