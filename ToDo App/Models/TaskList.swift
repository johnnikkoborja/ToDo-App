//
//  TaskList.swift
//  ToDo App
//
//  Created by John Nikko Borja on 6/2/23.
//

import Foundation

final class TaskList: Codable {
    var taskList: [Task]?
    
    required init(from decoder: Decoder) throws {
        let component = try decoder.container(keyedBy: CodingKeys.self)
        
        taskList = try component.decodeIfPresent([Task].self, forKey: .taskList)
    }
}

extension TaskList {
    enum CodingKeys: String, CodingKey {
        case taskList = "todoList"
    }
}
