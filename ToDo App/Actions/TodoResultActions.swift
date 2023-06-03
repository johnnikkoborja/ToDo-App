//
//  TodoResultActions.swift
//  ToDo App
//
//  Created by John Nikko Borja on 6/3/23.
//

import Foundation
import ReSwift

extension ToDoResultState {
    public static func getToDoList() -> ToDoList {
        // Get user
        let userId = UserDefaultsManager.getValue(key: R.string.localizable.userEmailId())
        let userList = TaskManager.getUserList()
        let user = TaskManager.getUser(with: userId, userList: userList)
        
        guard let todoList = user?.todoList else { return ToDoList() }
        mainStore.dispatch(ToDoListAction(todoList: todoList))
        
        return ToDoList()
    }
    
    public static func deleteToDoEntry(index: Int?) -> DeleteToDoEntry {
        // Get user
        let userId = UserDefaultsManager.getValue(key: R.string.localizable.userEmailId())
        let userList = TaskManager.getUserList()
        let user = TaskManager.getUser(with: userId, userList: userList)
        let updatedUserList: UserList?
        
        // Getting list
        var updatedList: [Task]? = user?.todoList
        if let index = index {
            updatedList?.remove(at: index)
            
            // Write User/s
            user?.todoList = updatedList
            updatedUserList = UserList.init(userList: userList?.userList?.filter({ user?.email != $0.email }))
            if let user = user {
                updatedUserList?.userList?.append(user)
                TaskManager.writeUsers(userList: updatedUserList)
            }
            
            // Re-do getting list
            guard let todoList = user?.todoList else { return DeleteToDoEntry() }
            mainStore.dispatch(ToDoListAction(todoList: todoList))
        }
        return DeleteToDoEntry()
    }
}

struct ToDoList: Action {}
struct DeleteToDoEntry: Action {}


struct ToDoListAction: Action {
    let todoList: [Task]?
}
