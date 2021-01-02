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
        let command = CodingLarsenyMenuCommand(identifier: invocation.commandIdentifier)
        
        switch command {
        case .sortLines:
            sort(buffer: invocation.buffer)
        default:
            fatalError("Implement \(command), dangit!")
        }
        
        completionHandler(nil)
    }
    
    private func sort(buffer: XCSourceTextBuffer) {
        guard let ranges = buffer.selections as? [XCSourceTextRange] else { return }
        
        ranges.forEach { sort(buffer: buffer, start: $0.start.line, end: $0.end.line) }
    }
    
    private func sort(buffer: XCSourceTextBuffer, start: Int, end: Int) {
        guard let allLines = buffer.lines as? [String] else { return }
        let originalLines = allLines[start...end]
        let sortedLines = originalLines.sorted(by: <)
        
        for lineNumber in start...end {
            buffer.lines[lineNumber] = sortedLines[lineNumber - start]
        }
    }
}
