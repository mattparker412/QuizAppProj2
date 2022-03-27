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
    var endQuiz = false
    func getTime(timeCount : (Int,Int,Int))->(Int,Int,Int){
        return timeCount
    }
    func countdownTimer(secondsRemaining : Int, remainingTime : UILabel, errorLabel : UILabel){
        
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
                self.leftOver = time
                print ("\(display)")
                time -= 1
                
                //return time
            }
            else{
                remainingTime.text = "Out of time!"
                errorLabel.text = "Cannot continue quiz. Click next to continue."
                self.endQuiz = true
                Timer.invalidate()
            }
            
        }
    }
    
    func getEndQuiz() -> Bool{
        return self.endQuiz
    }
    
    func timerActionTest(){
        print("timer condition \(timerTest!)")
    }
    func stopTimerTest(){
        timerTest?.invalidate()
        timerTest = nil
    }
    
    
}
