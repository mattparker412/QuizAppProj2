//
//  Ranking.swift
//  QuizAppProj2
//
//  Created by costin popescu on 3/17/22.
//

import Foundation


class Ranking {
    
    //var id: Int
    var userId: Int
    var technologyId: Int
    var ranking: Int = 0
    
    init(userId: Int, technologyId: Int, rank: Int){
        //self.id = id
        self.technologyId = technologyId
        self.userId = userId
        self.ranking = rank
    }
    
//    func setRanking(quizResult: Int) -> Int{
//        return self.ranking
//    }
}
