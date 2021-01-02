//
//  CodeLarsenyCommand.swift
//  XcodeLarseny
//
//  Created by Daniel Larsen on 1/2/21.
//

import Foundation
import XcodeKit

class CodeLarsenyCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        print("Invoked: \(invocation.commandIdentifier)")
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        
        completionHandler(nil)
    }
    
}
