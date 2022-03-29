//
//  DataFetcher.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/20/22.
//
import Foundation

/// Fetches data for pagination
class DataFetcher{
    var isPaginating = false
    lazy var users = db.getAllUsers()
    var getFetchFunctionCount = 0
    
    /**
                Gets data from DB to update tableview inside the relevant view controller
                    -Parameters:
                        -pagination: determines pagination status
                    -Returns:
                        -The function is void but it essentially returns an array of user data to the relevant view controller
                        -Uses the completion handler to implement passing data and exiting fetchData function
     
     */
    
    func fetchData(pagination: Bool = false, completion : @escaping(Result<[String], Error>)->Void){
        
        guard users.count > 0 else {
            return
        }
        if pagination{
            isPaginating = true
        }
        DispatchQueue.global().asyncAfter(deadline: .now()
                                          + (pagination ? 3 : 2), execute: { [self] in
            
            
            var originalData = [String]()
            var newData = [String]()
            guard getFetchFunctionCount > 0 else {
                for index in 0..<5{
                    let user = db.getUserName(userId: index + 1)
                    if user != ""{
                        originalData.append(user)
                    }
                }
                
                completion(.success(pagination && getFetchFunctionCount > 0 ? newData : originalData))
                if pagination{
                    self.isPaginating = false
                }
                getFetchFunctionCount += 1
                return
            }
            if getFetchFunctionCount > 0{
                
                for index in 5*getFetchFunctionCount...(9*getFetchFunctionCount-4*(getFetchFunctionCount-1)){
                    let user = db.getUserName(userId: index + 1)
                    if user != ""{
                        newData.append(user)
                    }
                }
            }
            
            completion(.success(pagination && getFetchFunctionCount > 0 ? newData : originalData))
            if pagination{
                self.isPaginating = false
            }
            getFetchFunctionCount += 1
        })
        
    }
}
