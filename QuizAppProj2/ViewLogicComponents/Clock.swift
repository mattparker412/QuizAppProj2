//
//  QuizTimer.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/17/22.
//

import Foundation
class Clock{
    func countdownTimer(secondsRemaining : Int){
        var time = secondsRemaining
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if time > 0 {
                var display = (time / 3600, (time % 3600) / 60, (time % 3600) % 60)
                print ("\(display)")
                time -= 1
                //return time
            } else {
                Timer.invalidate()
            }
        }
    }
}
