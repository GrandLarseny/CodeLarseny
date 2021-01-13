//
//  DefaultPlaygroundDirectory.swift
//  CodeLarseny
//
//  Created by Daniel Larsen on 1/5/21.
//

import Foundation

enum DefaultPlaygroundDirectory {
    
    private static let defaultsKey = "xcl.playgroundDir"
    
    static var path: String? {
        return UserDefaults.standard.string(forKey: defaultsKey)
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
            UserDefaults.standard.set(newValue?.absoluteString, forKey: defaultsKey)
        }
    }
}
