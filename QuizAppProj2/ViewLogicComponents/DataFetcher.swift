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
    func fetchData(pagination: Bool = false, completion : @escaping(Result<[String], Error>)->Void){
        if pagination{
            isPaginating = true
        }
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
            /*
             ["Apple", "Google", "Facebook","Apple", "Google", "Facebook",
                                 "Apple", "Google", "Facebook",
                                 "Apple", "Google", "Facebook",
                                 "Apple", "Google", "Facebook","Apple", "Google", "Facebook",
                                 "Apple", "Google", "Facebook",
                                 "Apple", "Google", "Facebook","Apple", "Google", "Facebook",
                                 "Apple", "Google", "Facebook",
                                 "Apple", "Google", "Facebook"]
             */
            let newData = ["banana", "oranges", "grapes"]
            completion(.success(pagination ? newData : originalData))
            if pagination{
                self.isPaginating = false
            }
        })
        
    }
}

