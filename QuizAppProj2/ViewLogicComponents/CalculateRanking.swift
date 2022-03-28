//
//  CalculateRanking.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/18/22.
//

import Foundation

/// Calculates the score after a quiz was taken
class CalculateRanking{
    func getData(){
    }
    
    /**
            Calculates score.
                -Parameters:
                    -timeLeft: amount of time left to take the quiz
                    -correctAnswers: number of correct answers in quiz
     */
    func calculateRank(timeLeft : Int, correctAnswers : Int) -> Int{
        if correctAnswers == 0{
            return -500 - Int(timeLeft/15)
        }
        return correctAnswers*500 + timeLeft/15 - ((5-correctAnswers)*100)
        
    }
}
