//
//  QuizesTaken.swift
//  QuizAppProj2
//
//  Created by costin popescu on 3/19/22.
//

import Foundation

// This is the model class for the table QuizesTaken. The table QuizesTaken persists every quiz taken by the users.
// It also persists the date and the score the user got on the quiz. This score will be used to claculate the user's ranking in that technology.
// The table has a non-composite primary key because a user can take the same quiz multyple times.
// The score is calculated by: numberOfCorectAnswers / numberOfQuizQuestions.

class QuizesTaken {
    
    var quizTakenId: Int
    var userId: Int
    var technologyId: Int
    var quizId: Int
    var dateTaken: String
    var score: Double
    
    init(quizTakenId: Int, userId: Int, technologyId: Int, quizId: Int, dateTaken: String, score: Double){
        
        self.quizTakenId = quizTakenId
        self.userId = userId
        self.technologyId = technologyId
        self.quizId = quizId
        self.dateTaken = dateTaken
        self.score = score
        
    }
}
