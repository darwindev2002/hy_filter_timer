//
//  ContentView.swift
//  HY_filter_timer
//
//  Created by Darwin Chan on 10/6/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var offset: CGFloat = 0
    let NDcardWidth = 106
    
    let BackgroundColor = Color("BackgroundColor")
    let TextColor = Color("TextColor")
    
//    var startAction: () -> Void
    @StateObject var exposureTimer = ExposureTimer(lengthInSeconds: 5)
//
//    @State var hours: Int = 0
//    @State var minutes: Int = 0
//    @State var seconds: Int = 0
//    @State var timerIsPaused = true
//    @State var timer: Timer? = nil
    
    var body: some View {
        
        ZStack {
            
            BackgroundColor
            VStack {
                Spacer()
                
                TimerView(exposureTimer: exposureTimer, scrumColor: Color.yellow)
                
                Spacer()
                Text("ND Number / Stops").font(.title3).fontWeight(.regular).foregroundColor(Color.gray)
                TimerNDView(cardWidth: NDcardWidth, offset: .constant(offset), height: 50, backgroundColor: BackgroundColor, textColor: TextColor)
                Text("Normal Shutter Speed").font(.title3).fontWeight(.regular).foregroundColor(Color.gray)
                TimerNDView(cardWidth: NDcardWidth, offset: .constant(offset), height: 50, backgroundColor: BackgroundColor, textColor: TextColor)
                
                if exposureTimer.timerIsPaused {
                    HStack {
                        TimerButton(abLabel: "Restart timer", text: "Restart", action: { exposureTimer.resetTimer() })
                        .padding(.all)
                        TimerButton(abLabel: "Start timer", text: "Start", action: { exposureTimer.startTimer(seconds: 500) })
                        .padding(.all)
                    }
                } else {
                    TimerButton(abLabel: "Stop timer", text: "Stop", action: { exposureTimer.stopTimer() })
                    .padding(.all)
                }
            }
            .padding(.top)
            
        }
    }

}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
