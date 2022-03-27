//
//  CalculateRanking.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/18/22.
//

import Foundation
class CalculateRanking{
    //gets data from database
    func getData(){
        
    }
    
    func calculateRank(timeLeft : Int, correctAnswers : Int) -> Int{
        if correctAnswers == 0{
            return -500 - Int(timeLeft/15)
        }
        return correctAnswers*500 - Int(timeLeft/15) - ((5-correctAnswers)*100)
        
        //to calculate ranking position, use array of all previous scores and sort the array. higher integer values are placed higher on the list while lower integer values are placed lower
        
        
    }
}
