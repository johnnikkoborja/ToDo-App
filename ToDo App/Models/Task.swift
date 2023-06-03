//
//  Task.swift
//  ToDo App
//
//  Created by John Nikko Borja on 6/1/23.
//

import Foundation

final class Task: Codable, Identifiable {
    
    var title: String?
    var subTasks: String?
    var dueDate: String?
    var timeStamp: Double?
    
    init(title: String?, subTasks: String?, dueDate: String?, timeStamp: Double?) {
        self.title = title
        self.subTasks = subTasks
        self.dueDate = dueDate
        self.timeStamp = timeStamp
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try container.decodeIfPresent(String.self, forKey: .title)
        subTasks = try container.decodeIfPresent(String.self, forKey: .subTasks)
        dueDate = try container.decodeIfPresent(String.self, forKey: .dueDate)
        timeStamp = try container.decodeIfPresent(Double.self, forKey: .timeStamp)
    }
    
}

extension Task {
    enum CodingKeys: String, CodingKey {
        case title, subTasks, dueDate, timeStamp
    }
}
