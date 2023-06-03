//
//  UserDefaultsManager.swift
//  ToDo App
//
//  Created by John Nikko Borja on 6/3/23.
//

import Foundation

class UserDefaultsManager {
    
    public static func setValue(key: String, value: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    public static func getValue(key: String) -> String {
        return UserDefaults.standard.string(forKey: key) ?? ""
    }
    
    public static func deleteValue(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    public static func clearAllValues() {
        if let appDomain = Bundle.main.bundleIdentifier {
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
         }
    }
}
