//
//  TinyWinsWidgetBundle.swift
//  TinyWinsWidget
//
//  Created by Rajorshi Roy Chowdhury on 18/01/26.
//

import WidgetKit
import SwiftUI

@main
struct TinyWinsWidgetBundle: WidgetBundle {
    var body: some Widget {
        TinyWinsWidget()
        TinyWinsWidgetControl()
        TinyWinsWidgetLiveActivity()
    }
}
