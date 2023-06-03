//
//  UserList.swift
//  ToDo App
//
//  Created by John Nikko Borja on 6/3/23.
//

import Foundation

final class UserList: Codable {
    var userList: [User]?
    
    init(userList: [User]?) {
        self.userList = userList
    }
    
    required init(from decoder: Decoder) throws {
        let component = try decoder.container(keyedBy: CodingKeys.self)
        
        userList = try component.decodeIfPresent([User].self, forKey: .userList)
    }
}

extension UserList {
    enum CodingKeys: String, CodingKey {
        case userList = "users"
    }
}
