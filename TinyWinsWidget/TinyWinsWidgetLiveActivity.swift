//
//  TinyWinsWidgetLiveActivity.swift
//  TinyWinsWidget
//
//  Created by Rajorshi Roy Chowdhury on 18/01/26.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TinyWinsWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct TinyWinsWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TinyWinsWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension TinyWinsWidgetAttributes {
    fileprivate static var preview: TinyWinsWidgetAttributes {
        TinyWinsWidgetAttributes(name: "World")
    }
}

extension TinyWinsWidgetAttributes.ContentState {
    fileprivate static var smiley: TinyWinsWidgetAttributes.ContentState {
        TinyWinsWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: TinyWinsWidgetAttributes.ContentState {
         TinyWinsWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: TinyWinsWidgetAttributes.preview) {
   TinyWinsWidgetLiveActivity()
} contentStates: {
    TinyWinsWidgetAttributes.ContentState.smiley
    TinyWinsWidgetAttributes.ContentState.starEyes
}
