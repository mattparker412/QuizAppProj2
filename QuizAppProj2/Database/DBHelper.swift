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
    
    func prepareDatabaseFile() -> String{
        let fileName : String = "quizzer.db"
        
        let fileManager : FileManager = FileManager.default
        let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let documentUrl = directory.appendingPathComponent(fileName)
        let bundleUrl = Bundle.main.resourceURL?.appendingPathComponent(fileName)
        
        if fileManager.fileExists(atPath: (documentUrl.path)){
            print("document file exists")
            return documentUrl.path
        }
        else if fileManager.fileExists(atPath: (bundleUrl?.path)!){
            print("document file does not exist, copy from bundle!")
            try! fileManager.copyItem(at: bundleUrl!, to: documentUrl)
        }
        return documentUrl.path
    }
    
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
    
    func createQuiz(technologyId: Int) -> Quizz {
        
        // This is the list of questions in the quiz.
        var questions = [Question]()
        
        // Need this variables here.
        var id:Int?
        var question: String?
        var answer1: String?
        var answer2: String?
        var answer3: String?
        var rightAnswer: String?
        
        
        let techId = String(technologyId)
        // Build query.
        let query = "select * from question where technologyId = " + techId + " order by random() limit 5"
        
        var pointer: OpaquePointer?
        
        // Connect the pointer to the database, and apply the query.
        if sqlite3_prepare(db, query, -2, &pointer, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error at create quizz --> ", err)
            
        }
        
        while(sqlite3_step(pointer) == SQLITE_ROW){
            
            // Get the id.
             id = Int(sqlite3_column_int(pointer, 0))
            // Get the technologyId.
            let tId = Int(sqlite3_column_int(pointer, 1))
            // Get question.
             question = String(cString:sqlite3_column_text(pointer, 2))
            // Get answer1
            answer1 = String(cString: sqlite3_column_text(pointer,3))
            // Get answer2
             answer2 = String(cString: sqlite3_column_text(pointer,4))
            // Get answer3
            answer3 = String(cString: sqlite3_column_text(pointer,5))
            // Get rightAnswer
             rightAnswer = String(cString: sqlite3_column_text(pointer,6))
            
            
            // Add the row to the question list.
            let ques = Question(id: id!, technologyId:tId, question:question!, answer1: answer1!, answer2: answer2!, answer3: answer3!, rightAnswer: rightAnswer!)
            questions.append(ques)
            
        }// End of while loop.
        
        // Display the ids in questions.
        for q in questions{
            print("id --> ", q.id)
        }
        
        // Create a quizz object.
        let quizz = Quizz(technologyId: technologyId, questions: questions)
        
        // Insert quizz into the database.
        
        
        return quizz
    }
    
    func storeRanking(userID : Int, techID : Int, rankScore : Int){
        var pointer : OpaquePointer?
        
        let strTechID = String(techID)
        let struserID = String(userID)
        var oldRank : Int
        var newRank : Int = rankScore
        
        let query = "select * from ranking where userID = " + struserID + " and technologyID = " + strTechID
        
        if sqlite3_prepare(db, query, -2, &pointer, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error at get ranking --> ", err)
            
        }
        
        while(sqlite3_step(pointer) == SQLITE_ROW){
            
            // Get the id.
             oldRank = Int(sqlite3_column_int(pointer, 2))
            newRank = rankScore + oldRank
        }
        
       
        
        if newRank != rankScore{
            let query2 = "update ranking set rankingValue = " + String(newRank) + " where userID = " + struserID + " and technologyID = " + strTechID
            
            if sqlite3_prepare(db, query2, -1, &pointer, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(db)!)
                print("There is an error at update ranking --> ", err)
            }
            
            if sqlite3_step(pointer) != SQLITE_DONE{
                let err = String(cString: sqlite3_errmsg(db)!)
                print("There is an error at update ranking step --> ", err)
            }
        }
        else{
            
            let query3 = "insert into ranking (userID, technologyID, rankingValue) values (?,?,?)"
            
            if sqlite3_prepare(db, query3, -1, &pointer, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(db)!)
                print("There is an error at insert new ranking --> ", err)
            }
            
            if sqlite3_bind_int(pointer, 1, (Int32(userID)) ) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(db)!)
                print("There is an error at insert id bind int --> ", err)
            }
            
            if sqlite3_bind_int(pointer, 2, (Int32(techID)) ) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(db)!)
                print("There is an error at insert techid bind int --> ", err)
            }
            
            if sqlite3_bind_int(pointer, 3, (Int32(rankScore)) ) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(db)!)
                print("There is an error at insert rankscore bind int --> ", err)
            }
            
            if sqlite3_step(pointer) != SQLITE_DONE{
                let err = String(cString: sqlite3_errmsg(db)!)
                print("There is an error at insert ranking step --> ", err)
            }
        }
        
        
    }
    
    func getTopRanking(techID : Int) -> [Ranking]{
        var pointer : OpaquePointer?
        
        //var userRankingDict = [Int:Int]()
        var dictUsers = [Int]()
        var dictRankings = [Int]()
        var rankingArray = [Ranking]()
        
        
        let query = "select * from ranking where technologyID = " + String(techID) + " order by rankingValue desc limit 10"
        
        if sqlite3_prepare(db, query, -1, &pointer, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error at prepare ranking sort --> ", err)
        }
        
        while(sqlite3_step(pointer) == SQLITE_ROW){
            
            //userRankingDict[Int(sqlite3_column_int(pointer, 0))] = Int(sqlite3_column_int(pointer, 2))
            //dictUsers.append(Int(sqlite3_column_int(pointer, 0)))
            //dictRankings.append(Int(sqlite3_column_int(pointer, 2)))
            let id = Int(sqlite3_column_int(pointer, 0))
            let rankscore = Int(sqlite3_column_int(pointer, 2))
            let rankingObj = Ranking(userId: id, technologyId: techID, rank: rankscore)
            rankingArray.append(rankingObj)
        }
//        print(dictUsers)
//        print(dictRankings)
        for r in rankingArray{
            print(r.userId)
            print(r.technologyId)
            print(r.ranking)
        }
        return rankingArray
    }
    
}





