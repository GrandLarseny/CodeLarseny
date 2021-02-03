//
//  PlaygroundType.swift
//  XcodeLarseny
//
//  Created by Daniel Larsen on 1/12/21.
//

import Foundation

enum PlaygroundType {
    
    case iOS
    case tvOS
    case macOS
    
    var framework: String {
        switch self {
        case .macOS: return "Cocoa"
        default: return "UIKit"
        }
    }
    
    var platform: String {
        switch self {
        case .iOS: return "ios"
        case .tvOS: return "tvos"
        case .macOS: return "macos"
        }
    }
    
    private var playgroundDirectory: URL? {
        guard let playgroundPath = DefaultPlaygroundDirectory.url else { return nil }
        return playgroundPath.appendingPathComponent("\(platform)-Code.playground")
    }
    
    func createPlayground(for source: String) {
        guard let directory = playgroundDirectory else { return }
        
        do {
            try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)

            let builder = PlaygroundBuilder(type: self, swiftCode: source)
            try PlaygroundFile.allCases.forEach { fileToWrite in
                let contents = fileToWrite.contents(with: builder)
                let fileLocation = directory.appendingPathComponent(fileToWrite.filename)
                try contents.write(to: fileLocation, atomically: true, encoding: .utf8)
            }
        } catch {
            print(error)
        }
    }
}
