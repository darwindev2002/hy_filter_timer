//
//  TimerButton.swift
//  HY_filter_timer
//
//  Created by Darwin Chan on 11/6/2021.
//

import SwiftUI

struct TimerButton: View {
    var abLabel: String
    var text: String
    var action: () -> Void
    var body: some View {
        Button(action: action){
            ZStack{
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color.yellow).frame(width: 100.0, height: 50.0)
                Text(text).foregroundColor(Color.white)
            }
        }
        .accessibilityLabel(Text(abLabel))
    }
}

struct TimerButton_Previews: PreviewProvider {
    static var previews: some View {
        TimerButton(abLabel: "Start timer", text: "Start", action: {})
    }
}
