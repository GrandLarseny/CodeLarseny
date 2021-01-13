//
//  PlagroundFolderPicker.swift
//  CodeLarseny
//
//  Created by Daniel Larsen on 1/3/21.
//

import AppKit
import Foundation

enum PlaygroundFolderPicker {
    static func chooseFolder() -> URL? {
        let folderPicker = NSOpenPanel()
        folderPicker.allowsMultipleSelection = false
        folderPicker.canChooseDirectories = true
        folderPicker.canChooseFiles = false
        
        folderPicker.runModal()
        return folderPicker.url
    }
}
