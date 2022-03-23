//
//  FeedBack.swift
//  QuizAppProj2
//
//  Created by costin popescu on 3/22/22.
//

import Foundation


class FeedBack{
    
    var userId: Int?
    
    // This variable is added cuz this class will be needed for display purposes only.
    // The userName value is extracted from the user table.
    //In case data in this class is needed a query with a join between user and feedback tables
    // will be done.
    var userName: String?
    
    var feedBack: String?
    
    init(userId: Int, feedBack: String){
        self.userId = userId
        self.feedBack = feedBack
    }
}
