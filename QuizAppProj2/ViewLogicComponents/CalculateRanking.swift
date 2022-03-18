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
        var quizScore = correctAnswers + (1800-timeTaken)
        
        //to calculate ranking position, use array of all previous scores and sort the array. higher integer values are placed higher on the list while lower integer values are placed lower
    }
}
