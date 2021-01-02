//
//  SourceEditorExtension.swift
//  XcodeLarseny
//
//  Created by Daniel Larsen on 1/2/21.
//

import Foundation
import os
import XcodeKit

class SourceEditorExtension: NSObject, XCSourceEditorExtension {
    
    var commandDefinitions: [[XCSourceEditorCommandDefinitionKey : Any]] {
        let namespace = Bundle(for: type(of: self)).bundleIdentifier!
        let marker = CodeLarsenyCommand.className()
        return CodingLarsenyMenuCommand.allCases.map { command in
            [.identifierKey: [namespace, marker, command.rawValue].joined(separator: "."),
             .classNameKey: marker,
             .nameKey: NSLocalizedString(command.title,
                                         comment: "\(command.title) menu item")]
        }
    }
    
    func extensionDidFinishLaunching() {
        os_log("Extension ready", type: .debug)
    }
    
    /*
    var commandDefinitions: [[XCSourceEditorCommandDefinitionKey: Any]] {
        // If your extension needs to return a collection of command definitions that differs from those in its Info.plist, implement this optional property getter.
        return []
    }
    */
    
}
