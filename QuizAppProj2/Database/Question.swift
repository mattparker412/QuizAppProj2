//
//  Question.swift
//  QuizAppProj2
//
//  Created by costin popescu on 3/17/22.
//

import Foundation

class Question {
    
    var id: Int
    var technologyId: Int
    var question: String?
    var answer1: String?
    var answer2: String?
    var answer3: String?
    var rightAnswer: String?
    
    init(id: Int, technologyId: Int, question: String, answer1: String, answer2: String, answer3: String, rightAnswer: String){
        self.id = id
        self.technologyId = technologyId
        self.question = question
        self.answer1 = answer1
        self.answer2 = answer2
        self.answer3 = answer3
        self.rightAnswer = rightAnswer
    }
}
