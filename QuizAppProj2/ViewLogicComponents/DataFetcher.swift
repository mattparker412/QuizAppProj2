//
//  DataFetcher.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/20/22.
//
import Foundation
class DataFetcher{
    var isPaginating = false
    
    //data fetcher needs to be updated so it can fetch data from DB
    //the data being fetched for the ranking list should be in a string format that contains the name of the user, the name of the quiz, and their quiz score
    //a separate fetchdata function should be made for fetching all the users to be displayed in the adminalluserviewcontroller because that is just the list of the users
    
    func fetchData(pagination: Bool = false, completion : @escaping(Result<[String], Error>)->Void){
        DispatchQueue.global().asyncAfter(deadline: .now()
                                          + (pagination ? 3 : 2), execute: {
            let originalData = ["Apple", "Google", "Facebook","Apple", "Google", "Facebook",
                                "Apple", "Google", "Facebook",
                                "Apple", "Google", "Facebook",
                                "Apple", "Google", "Facebook","Apple", "Google", "Facebook",
                                "Apple", "Google", "Facebook",
                                "Apple", "Google", "Facebook","Apple", "Google", "Facebook",
                                "Apple", "Google", "Facebook",
                                "Apple", "Google", "Facebook"]
            let newData = ["banana", "oranges", "grapes"]
            completion(.success(pagination ? newData : originalData))
        })
    }
}

