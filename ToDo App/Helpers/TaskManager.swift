//
//  TaskManager.swift
//  ToDo App
//
//  Created by John Nikko Borja on 6/2/23.
//

import Foundation


class TaskManager {
    
    public static func writeUsers(userList: UserList?) {
        if let url = Bundle.main.url(forResource: "data", withExtension: "json") {
            do {
                try JSONEncoder().encode(userList).write(to: url)
            } catch {
                print("error:\(error)")
            }
        }
    }
    
    public static func checkUser(email: String, userList: UserList?) -> Bool {
        var isExistingUser: Bool = false
        
        userList?.userList?.forEach({ user in
            if user.email == email {
                isExistingUser = true
                return
            }
        })
        
        return isExistingUser
    }
    
    public static func getUserList() -> UserList? {
        if let url = Bundle.main.url(forResource: "data", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(UserList.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    public static func getUser(with email: String, userList: UserList?) -> User? {
        return userList?.userList?.filter({ email == $0.email }).first ?? nil
    }
    
    public static func getList() -> TaskList? {
        if let url = Bundle.main.url(forResource: "data", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(TaskList.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}

