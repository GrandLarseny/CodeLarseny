//
//  CodingLarsenyMenuCommand.swift
//  XcodeLarseny
//
//  Created by Daniel Larsen on 1/2/21.
//

import Foundation

public let plyagroundDirectoryKey = "xcl.playgroundDir"

enum CodingLarsenyMenuCommand: String, CaseIterable {
    
    case sortLines
    case iOSPlayground
    case macOSPlayground
    case tvOSPlayground

    init(identifier: String) {
        guard let commandString = identifier.split(separator: ".").last,
              let commandValue = CodingLarsenyMenuCommand(rawValue: String(commandString)) else { fatalError("Unsupported command identifier \(identifier)") }
        
        self = commandValue
    }
    
    var title: String {
        switch self {
        case .sortLines: return "Sort Lines"
        case .iOSPlayground: return "Create iOS Playground"
        case .macOSPlayground: return "Create macOS Playground"
        case .tvOSPlayground: return "Create tvOS Playground"
        }
    }
}
