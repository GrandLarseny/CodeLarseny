//
//  CodingLarsenyMenuCommand.swift
//  XcodeLarseny
//
//  Created by Daniel Larsen on 1/2/21.
//

import Foundation

enum CodingLarsenyMenuCommand: String, CaseIterable {
    
    case sortLines
    case codingKeys
    
    init(identifier: String) {
        guard let commandString = identifier.split(separator: ".").last,
              let commandValue = CodingLarsenyMenuCommand(rawValue: String(commandString)) else { fatalError("Unsupported command identifier \(identifier)") }
        
        self = commandValue
    }
    
    var title: String {
        switch self {
        case .sortLines: return "Sort Lines"
        case .codingKeys: return "Create CodingKeys Enum"
        }
    }
}
