//
//  QuizTimer.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/17/22.
//

import Foundation
import UIKit
class Clock{
    var timerTest : Timer?
    var leftOver = 0
    func getTime(timeCount : (Int,Int,Int))->(Int,Int,Int){
        return timeCount
    }
    func countdownTimer(secondsRemaining : Int, remainingTime : UILabel){
        var time = secondsRemaining
        var minutes : String?
        var seconds : String?
        var fullTime : String?
        timerTest = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if time > 0 {
                let display = (time / 3600, (time % 3600) / 60, (time % 3600) % 60)
                minutes = String(display.1)
                seconds = String(display.2)
                fullTime = "\(minutes!):\(seconds!)"
                remainingTime.text = fullTime!
                print ("\(display)")
                time -= 1
                //return time
            } else {
                Timer.invalidate()
            }
        }
    }
}
