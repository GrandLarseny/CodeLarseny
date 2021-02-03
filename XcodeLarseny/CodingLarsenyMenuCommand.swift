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
    case sortVariables
    
    // TODO: Implement playground creation when extensions allow saving files
    // I wish I could figure this out in the sandbox, but am currently getting the following:
    //    Invoked: org.fjord.CodeLarseny.XcodeLarseny.XcodeLarseny.CodeLarsenyCommand.iOSPlayground
    //    2021-01-30 17:21:37.034470-0600 XcodeLarseny[57996:707925] [User Defaults] Couldn't read values in CFPrefsPlistSource<0x600002c31400> (Domain: group.org.fjord.CodeLarseny, User: kCFPreferencesAnyUser, ByHost: Yes, Container: (null), Contents Need Refresh: Yes): Using kCFPreferencesAnyUser with a container is only allowed for System Containers, detaching from cfprefsd
    //    Error Domain=NSCocoaErrorDomain Code=513 "You don’t have permission to save the file “ios-Code.playground” in the folder “Scratch”." UserInfo={NSFilePath=/Users/daniel/Scratch/ios-Code.playground, NSUnderlyingError=0x600000c311a0 {Error Domain=NSPOSIXErrorDomain Code=1 "Operation not permitted"}}
    //    Program ended with exit code: -1
    /*
    case iOSPlayground
    case macOSPlayground
    case tvOSPlayground
     */

    init(identifier: String) {
        guard let commandString = identifier.split(separator: ".").last,
              let commandValue = CodingLarsenyMenuCommand(rawValue: String(commandString)) else { fatalError("Unsupported command identifier \(identifier)") }
        
        self = commandValue
    }
    
    var title: String {
        switch self {
        case .sortLines: return "Sort Lines"
        case .sortVariables: return "Sort Variable Declartions"
        /*
        case .iOSPlayground: return "Create iOS Playground"
        case .macOSPlayground: return "Create macOS Playground"
        case .tvOSPlayground: return "Create tvOS Playground"
         */
        }
    }
}
