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
           // var originalData = [String]()
//            switch users.count{
//            case 5:
//                originalData = [users[0],users[1],users[2],users[3],users[4]]
//            case 4:
//                originalData = [users[0],users[1],users[2],users[3]]
//            case 3:
//                originalData = [users[0],users[1],users[2]]
//            case 2:
//                originalData = [users[0],users[1]]
//            case 1:
//                originalData = [users[0]]
//            default:
//                print("no more data")
//            }
            
            var originalData = [String]()//[users[0],users[1],users[2],users[3],users[4]]
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
            //removeFromUsers(removeArray: originalData)
            //print(users)
//            users.remove(at: 1)
//            users.remove(at: 1)
//            users.remove(at: 2)
//            users.remove(at: 3)
//            users.remove(at: 4)
//            for index in 0..<5{
//                print(users[index])
//                originalData.append(users[index])
//                users.remove(at: index)
//            }
            print(getFetchFunctionCount)
            if getFetchFunctionCount > 0{
                //print(users)
                for index in 5*getFetchFunctionCount...(9*getFetchFunctionCount-4*(getFetchFunctionCount-1)){
                    let user = db.getUserName(userId: index + 1)
                    if user != ""{
                        newData.append(user)
                    }
                }
                print("inside if")
                print(newData)
//                newData = updateData() as! [String]
//                print(newData)
            }
            
//            //let users = self.db.getAllUsers()
//            // This keeps track of location within the users array.
//            var location:Int = 0
//            //This holds the originalData.
//            var originalData = [String]()
//
//            for index in 0..<5{
//                if(!originalData.contains(self.users[index])){
//                originalData.append(self.users[index])
//                    location += 1
//                }
//            }
//            print(originalData)
//
//            // This holds the new data. It should update when the getNewData() function is run.
//            var newData = [String]()
//            var count = 0
//
//            while(self.users.count > location)
//            {
//
//                newData = self.getNewData(location:location,size: 5)
//                location += 5
//                count += 1
//              print("--------------------------------------------********************************")
//                for s in newData{
//                    print("new data user name ------> ", s)
//                }
//                print(count)
//
//            }
//            guard getFetchFunctionCount > 0 else {
//                completion(.success(pagination && getFetchFunctionCount > 0 ? newData : originalData))
//                if pagination{
//                    self.isPaginating = false
//                }
//                getFetchFunctionCount += 1
//                return
//            }
            completion(.success(pagination && getFetchFunctionCount > 0 ? newData : originalData))
            if pagination{
                self.isPaginating = false
            }
            getFetchFunctionCount += 1
        })
        
    }
}
