//
//  SortingAlgorithm.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/18/22.
//

import Foundation
class SortingAlgorithm{
    
    func sortRanks(numD : Array<Int>){
        let num = numD.sorted{(a,b)-> Bool in
            return a > b
        }
    }
}
