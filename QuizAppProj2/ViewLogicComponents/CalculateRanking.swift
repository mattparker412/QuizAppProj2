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
    
    func calculateRank(timeTaken : Int, correctAnswers : Int){
        func calculateRank(timeLeft : Int, correctAnswers : Int) -> Int{
            return correctAnswers*250 + timeLeft - ((5-correctAnswers)*100)
        
        //to calculate ranking position, use array of all previous scores and sort the array. higher integer values are placed higher on the list while lower integer values are placed lower
        
        
    }
}
