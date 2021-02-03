//
//  PlaygroundFile.swift
//  XcodeLarseny
//
//  Created by Daniel Larsen on 1/16/21.
//

import Foundation

struct PlaygroundBuilder {
    let type: PlaygroundType
    let swiftCode: String
}

enum PlaygroundFile: CaseIterable {
    
    case swiftContents
    case timeline
    case xcContents

    var filename: String {
        switch self {
        case .swiftContents: return "Contents.swift"
        case .timeline: return "timeline.xctimeline"
        case .xcContents: return "contents.xcplayground"
        }
    }
    
    func contents(with builder: PlaygroundBuilder) -> String {
        switch self {
        
        case .swiftContents:
            return "import \(builder.type.framework)\n\n\(builder.swiftCode)"
        case .timeline:
            return """
<?xml version="1.0" encoding="UTF-8"?>
<Timeline
   version = "3.0">
   <TimelineItems>
   </TimelineItems>
</Timeline>
"""
        case .xcContents:
            return """
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<playground version='5.0' target-platform='\(builder.type.platform)' buildActiveScheme='true' executeOnSourceChanges='false'>
    <timeline fileName='timeline.xctimeline'/>
</playground>
"""
        }
    }
}
