//
//  Quizz.swift
//  QuizAppProj2
//
//  Created by costin popescu on 3/22/22.
//

import Foundation


// This is the model for the Quizes table. It persists every quiz created. The table is used to re-calculate a user's ranking in a specific technology.


class Quizz{
    
    var technologyId: Int
    
    // An list of question.
    var questions =  [Question]()
    var quizId : Int
    
    init (technologyId: Int, questions: [Question], quizID : Int){
        self.quizId = quizID
        self.technologyId = technologyId
        self.questions = questions
        
    }
    
}
