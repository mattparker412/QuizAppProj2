//
//  DataFetcher.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/20/22.
//
import Foundation
class DataFetcher{
    var isPaginating = false
    lazy var users = db.getAllUsers()
    var getFetchFunctionCount = 0
    func getNewData(location:Int, size:Int) -> [String]{
        var count = 0
        var data = [String]()
        
        if(location + size >= users.count)
        {
            // Just fill up the remaining elements in users.
            for index in location ..< users.count{
                data.append(users[index])
            }
            return data
        }
        
        // Just fill the data from the location to the location + size.
        for index in location...location+size{
            data.append(users[index])
        }
        
        return data
    }
    
    func updateData()->Array<Any>{
        var newData = [Any]()
        switch users.count{
        case 5:
            newData = [users[0],users[1],users[2],users[3],users[4]]
        case 4:
            newData = [users[0],users[1],users[2],users[3]]
        case 3:
            newData = [users[0],users[1],users[2]]
        case 2:
            newData = [users[0],users[1]]
        case 1:
            newData = [users[0]]
        default:
            print("no more data")
        }
        return newData
    }
    
    func removeFromUsers(removeArray: Array<Any>){
        let thingsToRemoveArray = removeArray
        
               for k in thingsToRemoveArray {
                   users =  users.filter {$0 != k as! String}
                 }
    }
    
    func fetchData(pagination: Bool = false, completion : @escaping(Result<[String], Error>)->Void){
        
        guard users.count > 0 else {
            print("no more data")
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
                print("inside guard")
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
            print(getFetchFunctionCount)
            if getFetchFunctionCount > 0{
                //print(users)
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
