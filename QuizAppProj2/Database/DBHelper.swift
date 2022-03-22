//
//  DBHelper.swift
//  QuizAppProj2
//
//  Created by costin popescu on 3/17/22.
//

import Foundation
import SQLite3

class DBHelper{
    
    var db: OpaquePointer?
    
    func connect(){
    
    // Create the file path.
    let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("quizDB.sqlite")
    
        //Print the file path.
        print(filePath)
        
        // Connect to the database.
        if sqlite3_open(filePath.path, &db) != SQLITE_OK
        {
            print("cannot open database")
        }
        
        // Create the tables.
        
        // User Table.
        if sqlite3_exec(db, "create table if not exists user (id integer primary key autoincrement, name text,  password text, isSubscribed integer, isBlocked integer)", nil, nil, nil) != SQLITE_OK
        {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("error at create user table --> ", err)
        }
        
        // Technology table.
        if sqlite3_exec(db, "create table if not exists technology (id integer primary key autoincrement, name text)", nil, nil, nil) != SQLITE_OK
        {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("error at create technologies table --> ", err)
        }
        
        // Ranking table. It has a composite primary key composed from the foreign keys technologyId and userId.
        if sqlite3_exec(db, "create table if not exists ranking (userId integer, technologyId integer, rankingValue integer, primary key(userId, technologyId), foreign key (userId) references user (id), foreign key (technologyId) references technology (id))", nil, nil, nil) != SQLITE_OK
        {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("error at create ranking table --> ", err)
        }
        
        // Question table.
        if sqlite3_exec(db, "create table if not exists question (id integer primary key autoincrement, technologyId integer, question text, answer1 text, answer2 text, answer3 text, rightAnswer text, foreign key (technologyId) references technology (id))", nil, nil, nil) != SQLITE_OK
        {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("error at create question table --> ", err)
        }
        
        // Reviews table.
        if sqlite3_exec(db, "create table if not exists reviews (id integer primary key autoincrement, userId integer, review text, foreign key (userId) references user (id))", nil, nil, nil) != SQLITE_OK
        {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("error at create technologies table --> ", err)
        }
    } // End of connect().
    
    
    // Check user account.
    func checkUser(userName:String, pass: String) -> Bool{
        
        var userList = [User]()
        
        var pointer: OpaquePointer?
        
        // This query did not work. It gives a weird error.
        //let query = "select * from user where name = userName and password = pass"
        let query = "select * from user"
        // Apply the query.
        // Connect the pointer to the database, and apply the query.
        if sqlite3_prepare(db, query, -2, &pointer, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error at DBHelper.checkUser() --> ", err)
            
        }
        
        while(sqlite3_step(pointer)) == SQLITE_ROW
        {
            // Get the id.
            let id = Int(sqlite3_column_int(pointer,0))
            let name = String(cString:sqlite3_column_text(pointer, 1))
            let pass = String(cString: sqlite3_column_text(pointer, 2))
            let isSubRaw = Int(sqlite3_column_int(pointer, 3))
            let isBlockedRaw = Int(sqlite3_column_int(pointer, 4))
            
            //Create the enums.
            let isSubscribed = IsSubscribed(rawValue: isSubRaw)
            let isBlocked = IsBlocked(rawValue: isBlockedRaw)
            
            // Create a user object.
            let user = User(id: id, name: name, password: pass, subscribed: isSubscribed!, blocked: isBlocked!)
        
            // Add the returned users to the array.
            userList.append(user)
        }
        // Check if there is a user with the passed name and password. 
        for u in userList{
            if(u.name == userName && u.password == pass)
            {
                return true
            }
        }
        return false
        
    } // End of checkUser
    
}


