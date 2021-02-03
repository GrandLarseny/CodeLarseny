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
        case .sortLines: sort(buffer: invocation.buffer, byVariables: false)
        case .sortVariables: sort(buffer: invocation.buffer, byVariables: true)
        /*
        case .iOSPlayground: createPlayground(of: .iOS, buffer: invocation.buffer)
        case .tvOSPlayground: createPlayground(of: .tvOS, buffer: invocation.buffer)
        case .macOSPlayground: createPlayground(of: .macOS, buffer: invocation.buffer)
         */
        }
        
        completionHandler(nil)
    }
    
    private func sort(buffer: XCSourceTextBuffer, byVariables: Bool) {
        guard let ranges = buffer.selections as? [XCSourceTextRange] else { return }

        ranges.forEach { sort(buffer: buffer, start: $0.start.line, end: $0.end.line, byVariables: byVariables) }
    }
    
    private func sort(buffer: XCSourceTextBuffer, start: Int, end: Int, byVariables: Bool) {
        guard let allLines = buffer.lines as? [String] else { return }
        var originalLines = allLines[start...end]
        buffer.lines.removeObjects(in: NSRange(location: start, length: (end - start) + 1))
        
        var appendNewline = false
        if originalLines.contains(where: { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }) {
            originalLines.removeAll { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            appendNewline = true
        }
        
        var sortedLines: [String]
        if byVariables {
            sortedLines = originalLines.sorted(by: sortedByVariable)
        } else {
            sortedLines = originalLines.sorted(by: <)
        }
        
        if appendNewline {
            sortedLines.append("")
        }

        var lineNumber = 0
        for line in sortedLines {
            buffer.lines.insert(line, at: start + lineNumber)
            lineNumber += 1
        }
    }
    
    private func sortedByVariable(line1: String, line2: String) -> Bool {
        let lexedLine1 = lex(line: line1.trimmingCharacters(in: .whitespaces))
        let lexedLine2 = lex(line: line2.trimmingCharacters(in: .whitespaces))
        return lexedLine1 < lexedLine2
    }
    
    private func lex(line: String) -> String {
        let keywords = ["var",
                        "let",
                        "public",
                        "private",
                        "internal",
                        "weak",
                        "strong"]
        var tokens = line.components(separatedBy: .whitespaces)
        tokens.removeAll { keywords.contains($0) }
        tokens.removeAll { $0.first == "@" }
        
        return tokens.joined(separator: " ")
    }

    private func createPlayground(of type: PlaygroundType, buffer: XCSourceTextBuffer) {
        guard let ranges = buffer.selections as? [XCSourceTextRange],
              let allLines = buffer.lines as? [String] else { return }

        let sourceText = ranges
            .compactMap { allLines[$0.start.line...$0.end.line].joined(separator: "\n") }
            .joined(separator: "\n")
        
        type.createPlayground(for: sourceText)
    }
}
