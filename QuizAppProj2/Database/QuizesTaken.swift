//
//  QuizesTaken.swift
//  QuizAppProj2
//
//  Created by costin popescu on 3/22/22.
//

import Foundation


class QuizesTaken {
    
    var quizTakenId: Int
    var userId: Int
    var technologyId: Int
    var quizId: Int
    var dateTaken: String
    var score: Int
    
    init(quizTakenId: Int, userId: Int, technologyId: Int, quizId: Int, dateTaken: String, score: Int){
        
        self.quizTakenId = quizTakenId
        self.userId = userId
        self.technologyId = technologyId
        self.quizId = quizId
        self.dateTaken = dateTaken
        self.score = score
        
    }
}
