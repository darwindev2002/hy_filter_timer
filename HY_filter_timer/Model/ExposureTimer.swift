//
//  ExposureTimer.swift
//  HY_filter_timer
//
//  Created by Darwin Chan on 10/6/2021.
//

import SwiftUI


/// Keeps time for a daily scrum meeting. Keep track of the total meeting time, the time for each speaker, and the name of the current speaker.
class ExposureTimer: ObservableObject {
    
    @Published var hours: Int
    @Published var minutes: Int
    @Published var seconds: Int
    @Published var timerIsPaused: Bool
    @Published var timer: Timer?
    
    @Published var lengthInSeconds: Int
    
    init(lengthInSeconds: Int) {
        self.lengthInSeconds = lengthInSeconds
        self.hours = lengthInSeconds / 3600
        self.minutes = (lengthInSeconds % 3600) / 60
        self.seconds = lengthInSeconds % 60
        self.timerIsPaused = true
        self.timer = nil
    }
    
    func startTimer(seconds: Int) {
        timerIsPaused = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { tempTimer in
            if self.seconds == 0 {
                if self.minutes == 0 {
                    if self.hours == 0 {
                        self.stopTimer()
                    } else {
                        self.hours -= 1
                        self.minutes = 59
                        self.seconds = 59
                    }
                } else {
                    self.minutes -= 1
                    self.seconds = 59
                }
            } else if self.seconds == 1 && self.minutes == 0 && self.hours == 0 {
                self.stopTimer()
            } else {
                self.seconds -= 1
            }
            
        }
    }
    
    func stopTimer() {
        timerIsPaused = true
        timer?.invalidate()
        timer = nil
        resetTimer()
    }
    
    func resetTimer() {
        hours = 100
        minutes = (lengthInSeconds % 3600) / 60
        seconds = lengthInSeconds % 60
    }
    
}
