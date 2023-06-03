//
//  User.swift
//  ToDo App
//
//  Created by John Nikko Borja on 6/3/23.
//

import Foundation

final class User: Codable {
    var email: String?
    var todoList: [Task]?
    
    init(email: String?, todoList: [Task]?) {
        self.email = email
        self.todoList = todoList
    }
    
    required init(from decoder: Decoder) throws {
        let component = try decoder.container(keyedBy: CodingKeys.self)
        
        email = try component.decodeIfPresent(String.self, forKey: .email)
        todoList = try component.decodeIfPresent([Task].self, forKey: .todoList)
    }
}

extension User {
    enum CodingKeys: String, CodingKey {
        case email, todoList
    }
}
