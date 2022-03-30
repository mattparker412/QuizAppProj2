//
//  User.swift
//  QuizAppProj2
//
//  Created by costin popescu on 3/15/22.
//

import Foundation

class User {
    
    var id: Int
    var name: String?
    var password: String?
    
    // Sqlite stores boolean values in integer 0, 1 format. So this must be Int.
    // The data integrity is ensured by the passing into init an enumeration. See the
    // IsSubscribed and IsBlocked files.
    var subscribed: Int
    var blocked: Int
    var start: String
    var end: String
    // This holds 0 if the user did not claim the monthly reward and 1 if he did.
    var claimedMonthlyReward: Int
    init(id: Int, name: String, password: String, subscribed: IsSubscribed, blocked: IsBlocked, startDate: String, endDate: String, claimedMonthlyReward: Int){
        
        self.id = id
        self.name = name
        self.password = password
        self.subscribed = subscribed.rawValue
        self.blocked = blocked.rawValue
        self.start = startDate
        self.end = endDate
        self.claimedMonthlyReward = claimedMonthlyReward
    }
    
}
