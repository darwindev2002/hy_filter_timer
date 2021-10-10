//
//  TimerView.swift
//  HY_filter_timer
//
//  Created by Darwin Chan on 10/6/2021.
//

import SwiftUI

struct TimerArc: Shape {
    let secondElapsed: Int
    let lengthInSeconds: Int
    private var degreesPerSecond: Double {
        360.0 / Double(lengthInSeconds)
    }
    private var startAngle: Angle {
        Angle(degrees: degreesPerSecond * Double(secondElapsed))
    }
    private var endAngle: Angle {
        Angle(degrees: startAngle.degrees + degreesPerSecond)
    }
    
    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height) - 24.0
        let radius = diameter / 2.0
        let center = CGPoint(x: rect.origin.x + rect.size.width / 2.0,
                             y: rect.origin.y + rect.size.height / 2.0)
        return Path { path in
            path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        }
    }
}

struct TimerView: View {
    let exposureTimer: ExposureTimer
    var scrumColor: Color
    
    var body: some View {
        VStack {
        ZStack {
            Circle()
                .strokeBorder(lineWidth: 24, antialiased: true)
            VStack {
                Text("\(exposureTimer.hours)h \(exposureTimer.minutes)m \(exposureTimer.seconds)s")
                    .font(.title)
                Text("remaining")
            }
            .accessibilityElement(children: .combine)
//            .foregroundColor(scrumColor.accessibleFontColor)
//            ForEach(0..<exposureTimer.lengthInSeconds) { second in
////                if speaker.isCompleted,
////                   let index = speakers.firstIndex(where: { $0.id == speaker.id }) {
//                TimerArc(secondElapsed: 50, lengthInSeconds: exposureTimer.lengthInSeconds)
//                .rotation(Angle(degrees: -90))
//                .stroke(scrumColor, lineWidth: 12)
//            }
//            }
        }
        .padding(.horizontal)
            
            
        }
    }
    
//    func secondsToSentence(seconds: Int) {
//        let s = seconds % 60
//        let m = (seconds % 3600) / 60
//        let h
//        return "\(seconds/3600) h \(seconds/60) m \(seconds) s"
//    }
    
    
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(exposureTimer: ExposureTimer(lengthInSeconds: 500), scrumColor: Color.yellow)
    }
}
