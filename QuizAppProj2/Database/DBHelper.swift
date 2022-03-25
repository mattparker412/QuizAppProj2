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
    
    init(){
        self.connect()
    }
    
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
    let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("quizzer.db")
    
        //Print the file path.
        print(filePath)
        
        // Connect to the database.
        if sqlite3_open(filePath.path, &db) != SQLITE_OK
        {
            print("cannot open database")
        }
        
        // Create the tables.
        
        // User Table.
        if sqlite3_exec(db, "create table if not exists user (id integer primary key autoincrement, name text, password text, isSubscribed integer, isBlocked integer)", nil, nil, nil) != SQLITE_OK
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
        if sqlite3_exec(db, "create table if not exists ranking (name text, userId integer, technologyId integer, rankingValue integer, primary key(userId, technologyId), foreign key (userId) references user (id), foreign key (technologyId) references technology (id))", nil, nil, nil) != SQLITE_OK
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
        
        // feedback table.
        if sqlite3_exec(db, "create table if not exists feedback (id integer primary key autoincrement, userId integer, review text, foreign key (userId) references user (id))", nil, nil, nil) != SQLITE_OK
        {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("error at create feedback table --> ", err)
        }
        
        // Quizes table.
        if sqlite3_exec(db, "create table if not exists quizes (id integer primary key autoincrement, technologyId integer, q1 integer, q2 integer, q3 integer, q4 integer, q5 integer)", nil, nil, nil) != SQLITE_OK
        {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("error at create quizes table --> ", err)
        }
        
        // QuizesTaken
        if sqlite3_exec(db, "create table if not exists quizzestaken (id integer primary key autoincrement, quizId integer, technologyId integer, userId integer, score real, date text)", nil, nil, nil) != SQLITE_OK
        {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("error at create quizestaken table --> ", err)
        }
        
        // Admin table.
        if sqlite3_exec(db, "create table if not exists admin (id integer primary key autoincrement, name text,  password text)", nil, nil, nil) != SQLITE_OK
        {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("error at create admin table --> ", err)
        }
        
        
    } // End of connect().
    
    
    // Print all users. This function is used in the DataFetcher.
    func getAllUsers() -> [String] {
        
        var userList = [String]()
        var pointer: OpaquePointer?
        
        let query = "select name from user"
        
        if sqlite3_prepare(db, query, -2, &pointer, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error at DBHelper.getAllUsers() --> ", err)
        }
            while(sqlite3_step(pointer)) == SQLITE_ROW
            {
                let name = String(cString:sqlite3_column_text(pointer, 0))
                
                // Get the id.
                /*let id = Int(sqlite3_column_int(pointer,0))
                let name = String(cString:sqlite3_column_text(pointer, 1))
                let pass = String(cString: sqlite3_column_text(pointer, 2))
                let isSubRaw = Int(sqlite3_column_int(pointer, 3))
                let isBlockedRaw = Int(sqlite3_column_int(pointer, 4))
                
                //Create the enums.
                let isSubscribed = IsSubscribed(rawValue: isSubRaw)
                let isBlocked = IsBlocked(rawValue: isBlockedRaw)
                
                // Create a user object.
                let user = User(id: id, name: name, password: pass, subscribed: isSubscribed!, blocked: isBlocked!)
            */
                // Add the returned users to the array.
                userList.append(name)
            }
            return userList
        
    }// End of getAllUsers()
    
    
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
    
    func checkAdmin(userName:String, pass: String) -> Bool{
        
        var adminList = [Admin]()
        
        var pointer: OpaquePointer?
        
        // This query did not work. It gives a weird error.
        //let query = "select * from user where name = userName and password = pass"
        let query = "select * from admin"
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
           // let isSubRaw = Int(sqlite3_column_int(pointer, 3))
           // let isBlockedRaw = Int(sqlite3_column_int(pointer, 4))
            
            //Create the enums.
           // let isSubscribed = IsSubscribed(rawValue: isSubRaw)
           // let isBlocked = IsBlocked(rawValue: isBlockedRaw)
            
            // Create a user object.
            let admin = Admin(id: id, name: name, password: pass)
        
            // Add the returned users to the array.
            adminList.append(admin)
        }
        // Check if there is a user with the passed name and password.
        for a in adminList{
            if(a.name == userName && a.password == pass)
            {
                return true
            }
        }
        return false
        
    } // End of checkUser
    
    func getUserID(userName:String) -> Int{
        var pointer : OpaquePointer?
        var id : Int?
        
        let query = "select * from user where name = '" + userName + "'"
        
        if sqlite3_prepare(db, query, -2, &pointer, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error at DBHelper.getUserID() --> ", err)
        }
        
        while(sqlite3_step(pointer)) == SQLITE_ROW
        {
            id = Int(sqlite3_column_int(pointer,0))
        }
        
        return id!
    }
    
    func getUserName(userId:Int) -> String{
        var pointer : OpaquePointer?
        var name : String?
        let query = "select * from user where id = '" + String(userId) + "'"
        
        if sqlite3_prepare(db, query, -2, &pointer, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error at DBHelper.getUserID() --> ", err)
        }
        
        print(String(sqlite3_column_int(pointer,1)))
        while(sqlite3_step(pointer)) == SQLITE_ROW
        {
            name = String(cString:sqlite3_column_text(pointer, 1))
        }
        return name ?? ""
    }
    
    // Check username exists.
    func checkUsernameExists(userName:String) -> Bool{
        
        var userList = [User]()
        
        var pointer: OpaquePointer?
        
        // This query did not work. It gives a weird error.
        //let query = "select * from user where name = userName and password = pass"
        let query = "select * from user"
        // Apply the query.
        // Connect the pointer to the database, and apply the query.
        if sqlite3_prepare(db, query, -2, &pointer, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error at DBHelper.checkUsernameExists() --> ", err)
            
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
            if(u.name == userName)
            {
                return true
            }
        }
        return false
        
    } // End of checkUser

    func checkAdminUsernameExists(userName:String) -> Bool{
        
        var adminList = [Admin]()
        
        var pointer: OpaquePointer?
        
        // This query did not work. It gives a weird error.
        //let query = "select * from user where name = userName and password = pass"
        let query = "select * from admin"
        // Apply the query.
        // Connect the pointer to the database, and apply the query.
        if sqlite3_prepare(db, query, -2, &pointer, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error at DBHelper.checkAdminUsernameExists() --> ", err)
            
        }
        
        while(sqlite3_step(pointer)) == SQLITE_ROW
        {
            // Get the id.
            let id = Int(sqlite3_column_int(pointer,0))
            let name = String(cString:sqlite3_column_text(pointer, 1))
            let pass = String(cString: sqlite3_column_text(pointer, 2))
           // let isSubRaw = Int(sqlite3_column_int(pointer, 3))
            //let isBlockedRaw = Int(sqlite3_column_int(pointer, 4))
            
            //Create the enums.
           // let isSubscribed = IsSubscribed(rawValue: isSubRaw)
           // let isBlocked = IsBlocked(rawValue: isBlockedRaw)
            
            // Create a user object.
            let admin = Admin(id: id, name: name, password: pass)
        
            // Add the returned users to the array.
            adminList.append(admin)
        }
        // Check if there is a user with the passed name and password.
        for u in adminList{
            if(u.name == userName)
            {
                return true
            }
        }
        return false
        
    }
    
    // This function stores a user feedback into the feedback table.
    func saveFeedback(userId: Int, feedBack: String){
        
        var pointer: OpaquePointer?
        
        let query = "insert into feedback (userId, review) values (?,?)"
        
        if sqlite3_prepare_v2(db, query, -1, &pointer, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("error at saveFeedback prepare --> ", err)
        }
        
        if sqlite3_bind_int(pointer, 1, (Int32(userId)) ) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db)!)
            print("error at saveFeedback bind int id --> ",err)
        }
        
        if sqlite3_bind_text(pointer, 2, (feedBack as NSString).utf8String, -1, nil ) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db)!)
            print("error at saveFeedBack bind text feedBack -->",err)
        }
        
        if sqlite3_step(pointer) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("error at saveFeedback step --> ",err)
        }
    }// Emd of saveFeedback
    
    // When the admin wants to create a quiz,m all he has to do is pick a technology id.
    // On a "Create Quizz" button click, this function will be called.
    // The function creates and returns a Quizz object, and saves the Quizz object into the data
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
        //print(questions[0].id, "***************************")
        
        // Create a quizz object.
        let quizz = Quizz(technologyId: technologyId, questions: questions)
        
        // Insert quizz into the database(quizes table).
        let insertQuiz = "insert into quizes (technologyId, q1, q2, q3, q4, q5) values (?,?,?,?,?,?)"
        
        if sqlite3_prepare_v2(db, insertQuiz, -1, &pointer, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print(err)
        }
        
        if sqlite3_bind_int(pointer, 1, (Int32(quizz.technologyId)) ) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db)!)
            print(err)
            
        }
    
        if sqlite3_bind_int(pointer, 2, (Int32(questions[0].id)) ) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db)!)
            print(err)
            
        }
        
        if sqlite3_bind_int(pointer, 3, (Int32(questions[1].id)) ) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db)!)
            print(err)
            
        }
        
        if sqlite3_bind_int(pointer, 4, (Int32(questions[2].id)) ) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db)!)
            print(err)
            
        }
        
        if sqlite3_bind_int(pointer, 5, (Int32(questions[3].id)) ) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db)!)
            print(err)
            
        }
        
        if sqlite3_bind_int(pointer, 6, (Int32(questions[4].id)) ) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db)!)
            print(err)
            
        }
        if sqlite3_step(pointer) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(db)!)
            print(err)
            
        }
        return quizz
    }// End of create quizz.
    
    
    // This function returns an array of dictionaries.
    //Each dictionary contains the user name and user feedback of each feedback received.
    func getFeedBacks() -> [[String:String]]{
        
        // This array holds the feedbacks.
        var feedBacks : [[String:String]] = []
        
        var pointer: OpaquePointer?
        
        //let query = "select user.name, feedback.review from user inner join feedback on user.id = feedback.userId"
        let query = "select userId, review from feedback"
        
        // Connect the pointer to the database, and apply the query.
        if sqlite3_prepare(db, query, -2, &pointer, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error at DBHelper.getFeedBacks() --> ", err)
        }
        
        while(sqlite3_step(pointer) == SQLITE_ROW){
            
            let name = String(cString:sqlite3_column_text(pointer,0))
            let feedBack = String(cString: sqlite3_column_text(pointer,1))
            
            let dic = ["name":name, "feedback": feedBack]
            feedBacks.append(dic)
        }
        
       return feedBacks
    }// End getFeedBacks
    
    func storeRanking(userName : String, userID : Int, techID : Int, rankScore : Int){
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
            oldRank = Int(sqlite3_column_int(pointer, 3))
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
            
            let query3 = "insert into ranking (name, userID, technologyID, rankingValue) values (?,?,?,?)"
            
            if sqlite3_prepare(db, query3, -1, &pointer, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(db)!)
                print("There is an error at insert new ranking --> ", err)
            }
            
            if sqlite3_bind_text(pointer, 1, ((userName as NSString).utf8String), -1, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(db)!)
                print("There is an error at insert ranking bind name --> ", err)
            }
            
            if sqlite3_bind_int(pointer, 2, (Int32(userID)) ) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(db)!)
                print("There is an error at insert id bind int --> ", err)
            }
            
            if sqlite3_bind_int(pointer, 3, (Int32(techID)) ) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(db)!)
                print("There is an error at insert techid bind int --> ", err)
            }
            
            if sqlite3_bind_int(pointer, 4, (Int32(rankScore)) ) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(db)!)
                print("There is an error at insert rankscore bind int --> ", err)
            }
            
            if sqlite3_step(pointer) != SQLITE_DONE{
                let err = String(cString: sqlite3_errmsg(db)!)
                print("There is an error at insert ranking step --> ", err)
            }
        }
        
        
    }// end store ranking
    
    
    func getTotalScoreForUser(userName : String) -> [Int]{
        var pointer : OpaquePointer?
        
        
        let query = "select * from ranking where name = '" + userName + "'"
        var index = 0
        var scoreResult = [0,0,0]
        if sqlite3_prepare(db, query, -2, &pointer, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error at get ranking --> ", err)
            
        }
        
        while(sqlite3_step(pointer) == SQLITE_ROW){
            print("entered while loop")
            // Get the id.
            print(Int(sqlite3_column_int(pointer, 3)))
            scoreResult[index] = Int(sqlite3_column_int(pointer, 3))
            index += 1
        }
        
           
    
        if sqlite3_step(pointer) != SQLITE_DONE{
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error at update ranking step --> ", err)
        }
        
       
        return scoreResult
        
    }// end store ranking
    
    func getTopRanking(techID : Int) -> [Ranking]{
        var pointer : OpaquePointer?
        
        //var userRankingDict = [Int:Int]()
        //var dictUsers = [Int]()
        //var dictRankings = [Int]()
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
            let name = String(cString:sqlite3_column_text(pointer, 0))
            let id = Int(sqlite3_column_int(pointer, 1))
            let rankscore = Int(sqlite3_column_int(pointer, 3))
            let rankingObj = Ranking(username: name, userId: id, technologyId: techID, rank: rankscore)
            rankingArray.append(rankingObj)
        }
//        print(dictUsers)
//        print(dictRankings)
//        for r in rankingArray{
//            print(r.userId)
//            print(r.technologyId)
//            print(r.ranking)
//        }
        return rankingArray
    }
    
    func addNewUser(userName : String, passWord : String){
        var pointer : OpaquePointer?
        
        let query3 = "insert into user (name, password, isSubscribed, isBlocked) values (?,?,0,0)"

        if sqlite3_prepare(db, query3, -1, &pointer, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error at insert new ranking --> ", err)
        }
        
        if sqlite3_bind_text(pointer, 1, (userName as! NSString).utf8String, -1, nil ) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db)!)
            print("error at addnewuser bind usernamek -->",err)
        }
        
        if sqlite3_bind_text(pointer, 2, (passWord as! NSString).utf8String, -1, nil ) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db)!)
            print("error at addnewuser bind pword -->",err)
        }
        
        if sqlite3_step(pointer) != SQLITE_DONE{
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error at addnewuser done step --> ", err)
        }
        
    }
    
    func addNewAdmin(userName : String, passWord : String){
        var pointer : OpaquePointer?
        
        let query3 = "insert into admin (name, password) values (?,?)"

        if sqlite3_prepare(db, query3, -1, &pointer, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error at insert new ranking --> ", err)
        }
        
        if sqlite3_bind_text(pointer, 1, (userName as! NSString).utf8String, -1, nil ) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db)!)
            print("error at addnewadmin bind username -->",err)
        }
        
        if sqlite3_bind_text(pointer, 2, (passWord as! NSString).utf8String, -1, nil ) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db)!)
            print("error at addnewadmin bind pword -->",err)
        }
        
        if sqlite3_step(pointer) != SQLITE_DONE{
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error at addnewadmin done step --> ", err)
        }
        
    }
    
}



