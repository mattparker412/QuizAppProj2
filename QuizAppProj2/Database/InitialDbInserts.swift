//
//  InitialDbInserts.swift
//  QuizAppProj2
//
//  Created by costin popescu on 3/22/22.
//

import Foundation
import SQLite3

// Create an instance of this class in the initial viewController,code sample bellow.
// In the entry point view controller create a global InitialDbInserts instance. Ex. let i = InitialDBInserts()
// Then inside viewDidLoad() --> i.connect()
//                               i.insertInitial()
// After a run, you should have a data base that contains the tables bellow.
// ***** The most important thing is, you will have a questions table filled up with 60 questions.
//

// It inserts three users in the user table(one is subscribed), than all the questions in the question table.

class InitialDbInserts{
    
    var db: OpaquePointer?
    
    // This array holds all the data needed to be inserted into the question table.
    var data = [Question]()
    
    // This array holds three User objects. The third user is subscribed.
    var initialUsers = [User(id: 1, name: "user1", password: "123", subscribed: .isNotSubscribed, blocked: .isNotBlocked),
                        User(id:2, name:"user2", password: "123", subscribed: .isNotSubscribed, blocked: .isNotBlocked),
                        User(id:3, name:"user3", password: "234", subscribed: .isSubscribed, blocked: .isNotBlocked)]
    
    // This array holds the initial technologies (Spring, Java, Android).
    var initialTechnologies = [Technology(id: 1, name:"Swift"), Technology(id:2, name:"Java"), Technology(id: 3, name: "Android")]
    
    
    func fillData(){
    
    data.append(Question(id: 1, technologyId: 1, question:"What is Swift?" , answer1:"A bird." , answer2:"A word." , answer3:"Is the programming language used to create IOS apps." , rightAnswer:"Is the programming language used to create IOS apps." ))
    
    data.append(Question(id: 2, technologyId: 1, question:"What are some important features of swift?", answer1:"The big wings.", answer2:"The engine power.", answer3:"Closures, extentions, protocols.", rightAnswer:"Closures, extentions, protocols."))
    
        data.append(Question(id: 3, technologyId: 2, question:"What is Java?", answer1:"A programming language.", answer2: "A book.", answer3:"A computer program." , rightAnswer: "A programming language."))
    
        data.append(Question(id: 4, technologyId: 2, question:"Is Java an OOP programming language?", answer1:"No.", answer2:"Yes.", answer3:"Not sure.", rightAnswer:"Yes."))
        data.append(Question(id: 5, technologyId: 1, question:"What is a dictionary?", answer1:"A book.", answer2:"A data structure that stores elements in a key: value pair format.", answer3: "An animal.", rightAnswer: "A data structure that stores elements in a key: value pair format."))
        data.append(Question(id: 6, technologyId: 1, question:"What is the use of double question mark ?? in swift?", answer1:"nil coalescing operator.", answer2:"Optional.", answer3:"Marks a variable.", rightAnswer: "nil coalescing operator."))
        
        
        data.append(Question(id: 7, technologyId: 1, question:"What is a GUARD statement?", answer1:"Security.", answer2:"Is a conditional statement that performs a function if the condition is false.", answer3: "An object.", rightAnswer:"Is a conditional statement that performs a function if the condition is false."))
        
        
        data.append(Question(id: 8, technologyId: 2, question:"What is polymorphism?", answer1:"The ability to define a function in multiple forms.", answer2:"A type of computer.", answer3:"A computer program." , rightAnswer:"The ability to define a function in multiple forms."))
        
        
        
        data.append(Question(id: 9, technologyId: 2, question:"What is a local variable?", answer1:"A variable that can be accessed only inside a block of code.", answer2:"An integer.", answer3: "A primitive.", rightAnswer:"A variable that can be accessed only inside a block of code."))
        
        
        data.append(Question(id: 10, technologyId: 2, question:"What is method overriding?", answer1:"Method definition.", answer2:"Is how you create a method.", answer3:"Is the concept in which two methods having the same method signature are present in two different classes.", rightAnswer:"Is the concept in which two methods having the same method signature are present in two different classes."))
        
        
        data.append(Question(id: 11, technologyId: 2, question:"What is JVM?", answer1:"Java Virtual Machine.", answer2:"Java Vector Machine.", answer3:"Java Vitual Merger.", rightAnswer: "Java Virtual Machine."))
        
        
        data.append(Question(id: 12, technologyId: 2, question:"What is JRE?",  answer1: "Java Virtual Machine.", answer2:"Java Runtime Environment.", answer3:"Java Running Environment.", rightAnswer:"Java Runtime Environment."))
        
        
        data.append(Question(id: 13, technologyId: 2, question:"What is JDK?",  answer1:"Java Runtime Environment.", answer2:"Java Developers Kit.", answer3:"Java Development Kit.", rightAnswer:"Java Development Kit."))
        
        
        data.append(Question(id: 14, technologyId: 2, question:"What is a class?", answer1:"A blueprint used to create objects.", answer2:"An object.", answer3:"An interface.", rightAnswer:"A blueprint used to create objects."))
        
        
        
        data.append(Question(id: 15, technologyId: 2, question:"What is a constructor.", answer1:"Is a data type.", answer2:"The special method invoked when an object is crearted.", answer3:"An interface.", rightAnswer:"The special method invoked when an object is crearted."))
        
        
        
        data.append(Question(id: 16, technologyId: 1, question:"What is GCD?",  answer1:"An object.", answer2: "Grand Central Dispatch.",  answer3:"Grand Central Data.", rightAnswer:"Grand Central Dispatch." ))
        
        
        
        data.append(Question(id: 17, technologyId: 1, question:"What is OperationQueue?",  answer1:"An array.", answer2: "A type of view.", answer3:"A queue that contains operations.", rightAnswer:"A queue that contains operations."))
        
        
        
        data.append(Question(id: 18, technologyId: 1, question:"How can we make a property Optional in swift?", answer1:"By adding a question mark after the property’s type.", answer2:"By unwrap it.", answer3:"By overriding it.", rightAnswer: "By adding a question mark after the property’s type."))
        
        
                    
        
        data.append(Question(id: 19, technologyId: 1, question:"What is Optional chaining?", answer1:"An array.", answer2:"A way to call properties and methods on an optional that might be nil.", answer3:"A primitive.", rightAnswer: "A way to call properties and methods on an optional that might be nil."))
        
        
        
        data.append(Question(id: 20, technologyId: 1, question:"What is Swift module?", answer1:"A module is a single unit of code distribution.", answer2:"A double.", answer3: "A data type.", rightAnswer:"A module is a single unit of code distribution."))
        
        
        
        data.append(Question(id: 21, technologyId: 1, question:"What is an object.", answer1: "An interface.", answer2: "An object is an instance of a class.", answer3:"A class.", rightAnswer:"An object is an instance of a class."))
        
        
        
        data.append(Question(id: 22, technologyId: 1, question:"What is inheritance?",  answer1:"Allows one object acquire the properties and functionality of another object.", answer2:"A way to instantiate.", answer3:"A base class.", rightAnswer:"Allows one object acquire the properties and functionality of another object."))
        
        
        
    data.append(Question(id: 23, technologyId: 1, question:"Can structs use inheritance?" , answer1:"Yes.", answer2:"Only if they are generic.", answer3: "No.", rightAnswer: "No."))
        
        
        
    data.append(Question(id: 24, technologyId: 1, question: "What is a protocol?",  answer1:"An interface.", answer2:"A blueprint of methods and / or properties that encapsulate a piece of functionality.", answer3:"A blueprint of methods and / or properties that encapsulate a piece of functionality.", rightAnswer:"A blueprint of methods and / or properties that encapsulate a piece of functionality."))
        
        
        
    data.append(Question(id: 25, technologyId: 1, question: "What is Tuple?", answer1:"Is a data type that is used to group together values of different data types.", answer2:"A class.", answer3:"An object.", rightAnswer:"Is a data type that is used to group together values of different data types."))
        
        
        
        
    data.append(Question(id: 26, technologyId: 2, question:"What is the default value of byte datatype?", answer1: "null", answer2:"1", answer3:"0", rightAnswer:"0"))
        
        
        
        
        data.append(Question(id: 27, technologyId: 2, question:"What is an Interface?", answer1:"An interface is a collection of abstract methods.", answer2: "A class.", answer3:"An object.", rightAnswer:"An interface is a collection of abstract methods."))
        
        
        
        data.append(Question(id: 28, technologyId: 2, question:"What is an immutable object?", answer1:"An immutable object can’t be changed once it is created.", answer2: "An object that can be changed by the user.", answer3:"A final object.", rightAnswer:"An immutable object can’t be changed once it is created."))
        
        
        
        
        data.append(Question(id: 29, technologyId: 2, question:"What is a TreeSet?", answer1:"An array of sets.", answer2:"A sorted set.", answer3: "An abstrasct class.", rightAnswer:"A sorted set."))
        
        
        
        
        
        data.append(Question(id: 30, technologyId: 2, question: "Can a constructor be made final?", answer1:"Yes.", answer2:"No.", answer3:"Yes, if it is the default constructor.", rightAnswer:"No."))
        
        
        
        
        data.append(Question(id: 31, technologyId: 3, question: "What is Android?", answer1: "A type of phone.", answer2:"An operating system.", answer3:"A computer brand.", rightAnswer: "An operating system."))
        
        
        
        
        
        data.append(Question(id: 32, technologyId: 3, question:"What is an activity?", answer1:"Activity is a single screen that represents a GUI.", answer2: "Is a program.", answer3: "An event.", rightAnswer:"Activity is a single screen that represents a GUI."))
        
        
        
        
        
        
        data.append(Question(id: 33, technologyId: 3, question:"What is a service in Android?", answer1: "Service is an application component that facilitates an application to run in the background.", answer2:"A data type.", answer3:"A data structure.", rightAnswer:"Service is an application component that facilitates an application to run in the background."))
        
        
        
        
        
        
        data.append(Question(id: 34, technologyId: 3, question:"What is the use of Bundle in Android?", answer1:"Bundles are used to pass the required data between various Android activities.", answer2: "To create apps.", answer3:"To create objects.", rightAnswer: "Bundles are used to pass the required data between various Android activities."))
        
        
        
        
        
        
            data.append(Question(id: 35, technologyId: 3, question: "What is an Adapter in Android?", answer1: "null", answer2: "An adapter in Android acts as a bridge between an AdapterView and the underlying data for that view.", answer3:"It is a type of activity.", rightAnswer: "An adapter in Android acts as a bridge between an AdapterView and the underlying data for that view."))
        
        
        
        
        
        
        data.append(Question(id: 36, technologyId: 3, question: "What is the importance of setting up permission?", answer1:"So the data and code are restricted to the authorized users only.", answer2:"So everyone ca access the app.", answer3: "So no one can have access to the app.", rightAnswer: "So the data and code are restricted to the authorized users only."))
        
        
        
        
        
        
        data.append(Question(id: 37, technologyId: 3, question:  "What is .apk extension in Android?", answer1:"It holds the pictures.", answer2:"It holds the videos.", answer3:"It is a default file format that is used by the Android Operating System.", rightAnswer: "It is a default file format that is used by the Android Operating System."))
        
        
        
        
        data.append(Question(id: 38, technologyId: 3, question: "What is ANR in Android?", answer1: "Another Null Object.", answer2:"Android Number Array.", answer3:"Application Not Responding", rightAnswer: "Application Not Responding"))
        
        
        
        
        data.append(Question(id: 39, technologyId: 3, question:"What is ActivityCreator?", answer1: "The object used to create activities.", answer2:"A batch file and shell script which was used to create a new Android project.", answer3: "An event handling class.", rightAnswer:"A batch file and shell script which was used to create a new Android project."))
        
        
        
        
        data.append(Question(id: 40, technologyId: 3, question: "What is ADB?", answer1: "Android Debug Bridge", answer2: "Android Debugger Bridge", answer3:"Android Default Bridge", rightAnswer:"Android Debug Bridge"))
        
        
        
        
        
        
        data.append(Question(id: 41, technologyId: 3, question: "What is a Toast?", answer1:"A type of bread.", answer2:"Toast notification is a message that pops up on the window.", answer3: "A data type.", rightAnswer:"Toast notification is a message that pops up on the window."))
        
        
        
        
        data.append(Question(id: 42, technologyId: 3, question:"What is the use of WebView in Android?", answer1:"WebView is a view that display web pages inside your application.", answer2:"The documentation website.", answer3: "The security interface.", rightAnswer: "WebView is a view that display web pages inside your application."))
        
        
        
        
    data.append(Question(id: 43, technologyId: 3, question: "What is AAPT?", answer1:"Android App Package Toolkit", answer2:"Android Asset Packaging Tool.", answer3:"Android Assets and Packaging Tools", rightAnswer:"Android Asset Packaging Tool."))
        
        
        
        
        
    data.append(Question(id: 44, technologyId: 3, question:"How will you pass data to sub-activities?", answer1:"tools", answer2:"you can't", answer3: "bundles", rightAnswer: "bundles"))
        
        
        
        
        
    data.append(Question(id: 45, technologyId: 3, question:"Which launguage cannot be used to build an Android app?", answer1:"Italian", answer2:"Java", answer3:"Kotlin", rightAnswer: "Italian"))
        
        
        
        
        
    data.append(Question(id: 46, technologyId: 3, question:"What is the Android Emulator?", answer1:"Is the phone used for testing apps.", answer2:"The base classs.", answer3:"Is the implementation of the Android Virtual Machine", rightAnswer:"Is the implementation of the Android Virtual Machine"))
        
        
        
        
    data.append(Question(id: 47, technologyId: 3, question:"What is Android Interface Definition Language?", answer1:"Java", answer2:"Facilitates the communication between the client and service", answer3:"kotlin", rightAnswer:"Facilitates the communication between the client and service"))
        
        
        
        
    data.append(Question(id: 48, technologyId: 3, question:"What is AlertDialog?", answer1: "A text element.", answer2:"A dialog box.", answer3:"A button.", rightAnswer:"A dialog box."))
        
        
        
        
    data.append(Question(id: 49, technologyId: 3, question: "What is Context?", answer1: "A class.", answer2:"A sorted set.", answer3: "The context of the current state of your application or object", rightAnswer: "The context of the current state of your application or object"))
        
        
        
        
    data.append(Question(id: 50, technologyId: 3, question:"What is the AndroidManifest.xml?", answer1:"The data base.", answer2:"The app.", answer3:"Contains information about the application", rightAnswer: "Contains information about the application"))
        
        
        
    data.append(Question(id: 51, technologyId: 2, question:"What is Encapsulation?", answer1: "An object.", answer2: "Protects the code from others.", answer3:"A class.", rightAnswer: "Protects the code from others."))
        
        
        
        data.append(Question(id: 52, technologyId: 2, question:"What is an abstract class?", answer1:"A special class.", answer2:"A null class.", answer3: "A class that cannot create objects.", rightAnswer:"A class that cannot create objects."))
        
        
        
        data.append(Question(id: 53, technologyId: 2, question:"What is a try/catch block?", answer1:"A instance of a class.", answer2: "A way to handle exceptions.", answer3:"A function.", rightAnswer:"A way to handle exceptions."))
        
        
        
        data.append(Question(id: 54, technologyId: 2, question:"What is a Thread?", answer1: "An abstarct class.", answer2:"An interface.", answer3:"The flow of execution.", rightAnswer: "The flow of execution."))
        
        
        
        data.append(Question(id: 55, technologyId: 2, question: "What is the wait() method?", answer1: "The main method.", answer2:"The main interface.", answer3:"Method is used to make the thread to wait in the waiting pool.", rightAnswer: "Method is used to make the thread to wait in the waiting pool."))
        
        
        
        data.append(Question(id: 56, technologyId: 1, question:"What is a strong reference?" , answer1:"A base class.", answer2: "A base ptrotocol.", answer3:"A reference that increments the count of an object by 1.", rightAnswer:"A reference that increments the count of an object by 1."))
        
        
        
        data.append(Question(id: 57, technologyId: 1, question:"What is extention?" , answer1: "A base class.", answer2:"A class inheritance.", answer3:"The way to add functionality to a class or struct.", rightAnswer:"The way to add functionality to a class or struct."))
        
        
        
        
        data.append(Question(id: 58, technologyId: 1, question:"What is a closure?" , answer1: "A method.", answer2:"A protocol.", answer3:"Self-contained block of code that can be passed around and used throughout the application.", rightAnswer: "Self-contained block of code that can be passed around and used throughout the application."))
        
        
        
        
        data.append(Question(id: 59, technologyId: 1, question:"What is let?", answer1: "Creates a constant.", answer2:"Creates a variable.", answer3: "Creates a class.", rightAnswer:"Creates a constant."))
        
        
        
        
        data.append(Question(id: 60, technologyId: 1, question: "What is a property?", answer1:"Properties associate values with a class, struct or enum.", answer2:"A protocol", answer3:"A data type.", rightAnswer:"Properties associate values with a class, struct or enum."))
        
        

    }
    
    
    //Connect to the data base and create the tables.
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
            print("error at create technologies table --> ", err)
        }
    } // End of connect().
    
    func insertInitial(){
        // Fill the data array with the Question objects.
        fillData()
        print(data.count)
        
        fillUser()
        fillTechnology()
        fillQuestions()

}// End of insertInitial()
    
    
    func fillUser(){
        
        var statement: OpaquePointer?
    
        for u in initialUsers{
            
            
            
            let query = "insert into user (id, name, password, isSubscribed, isBlocked) values (?,?,?,?,?)"
        
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) != SQLITE_OK {
                let err = String(cString: sqlite3_errmsg(db)!)
                print(err)
            }
        
        
            if sqlite3_bind_int(statement, 1, (Int32(u.id))) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(db)!)
                print(err)
            
            }
        
            if sqlite3_bind_text(statement, 2, (u.name! as NSString).utf8String, -1, nil ) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(db)!)
                print(err)
            }
            
            if sqlite3_bind_text(statement, 3, (u.password! as NSString).utf8String, -1, nil ) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(db)!)
                print(err)
            }
            
            if sqlite3_bind_int(statement, 4, (Int32(u.subscribed ))) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(db)!)
                print(err)
            }
            
            if sqlite3_bind_int(statement, 5, (Int32(u.blocked ))) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(db)!)
                print(err)
            }
            
            
            if sqlite3_step(statement) != SQLITE_DONE {
                let err = String(cString: sqlite3_errmsg(db)!)
                print(err)
            }
        
            print("User ", u.id, " saved")
        }// End of loop
    }//End of fillUser
    
    
    func fillTechnology(){
        
        var statement: OpaquePointer?
        
        for t in initialTechnologies{
        
            let query = "insert into technology (id, name) values (?,?)"
    
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) != SQLITE_OK {
                let err = String(cString: sqlite3_errmsg(db)!)
                print(err)
            }
        
            if sqlite3_bind_int(statement, 1, (Int32(t.id))) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(db)!)
                print(err)
        
            }
    
            if sqlite3_bind_text(statement, 2, (t.name! as NSString).utf8String, -1, nil ) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(db)!)
                print(err)
            }
            
            if sqlite3_step(statement) != SQLITE_DONE {
                let err = String(cString: sqlite3_errmsg(db)!)
                print(err)
            }
            print("Tech ", t.id, " saved")
            
        }// End of loop.
        
    }// End of fillTechnology
    
    
    
    func fillQuestions(){
        
        var statement: OpaquePointer?
        
        for d in data{
        
            let query = "insert into question (id, technologyId, question, answer1, answer2, answer3, rightAnswer ) values (?,?,?,?,?,?,?)"
    
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) != SQLITE_OK {
                let err = String(cString: sqlite3_errmsg(db)!)
                print(err)
            }
        
            if sqlite3_bind_int(statement, 1, (Int32(d.id))) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(db)!)
                print(err)
        
            }
    
            if sqlite3_bind_int(statement, 2, (Int32(d.technologyId))) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(db)!)
                print(err)
            }
            
            if sqlite3_bind_text(statement, 3, (d.question! as NSString).utf8String, -1, nil ) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(db)!)
                print(err)
            }
            
            if sqlite3_bind_text(statement, 4, (d.answer1! as NSString).utf8String, -1, nil ) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(db)!)
                print(err)
            }
            
            if sqlite3_bind_text(statement, 5, (d.answer2! as NSString).utf8String, -1, nil ) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(db)!)
                print(err)
            }
            
            if sqlite3_bind_text(statement, 6, (d.answer3! as NSString).utf8String, -1, nil ) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(db)!)
                print(err)
            }
            
            if sqlite3_bind_text(statement, 7, (d.rightAnswer! as NSString).utf8String, -1, nil ) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(db)!)
                print(err)
            }
            if sqlite3_step(statement) != SQLITE_DONE {
                let err = String(cString: sqlite3_errmsg(db)!)
                print(err)
            }
            print("Question ", d.id, " saved")
            
        }// End of loop.
        
    }// End of fillQuestions.
    
    
    
}
