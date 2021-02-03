//
//  DefaultPlaygroundDirectory.swift
//  CodeLarseny
//
//  Created by Daniel Larsen on 1/5/21.
//

import Foundation

enum DefaultPlaygroundDirectory {
    
    private static let defaultsKey = "xcl.playgroundDir"
    
    static var userDefaults: UserDefaults! { UserDefaults(suiteName: "group.org.fjord.CodeLarseny") }
    
    static var path: String? {
        return userDefaults.string(forKey: defaultsKey)
    }
    
    static var url: URL? {
        get {
            if let path = path {
                return URL(fileURLWithPath: path, isDirectory: true)
            } else {
                return nil
            }
        }
        set {
            userDefaults.set(newValue?.absoluteString, forKey: defaultsKey)
        }
    }
}
