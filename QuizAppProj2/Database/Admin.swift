//
//  AdminM.swift
//  QuizAppProj2
//
//  Created by costin popescu on 3/22/22.
//

import Foundation

class Admin{

    var id: Int
    var name: String?
    var password: String?

    init(id: Int, name: String, password: String){
         self.id = id
         self.name = name
         self.password = password
    }
}
