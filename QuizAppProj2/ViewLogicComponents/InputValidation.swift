//
//  InputValidation.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/17/22.
//

import Foundation
import UIKit
class InputValidation{
    
    
    
    func validateCreditCard(creditCard : String, cvc :String, expDate : String, firstName : String, lastName : String){
        
    }
    
    
    
    func validateLoginInput(username : String, password: String, error:UILabel) -> Bool{
        if(username == ""){
            print("Please enter an email")
//            error.text = "Please enter an email."
            return false
        }else if(password == ""){
            print("Please enter a password.")
//            error.text = "Please enter a password."
            return false
        } else if(checkValidAccount(userName:username, password: password) == false){
            print("Email or password is wrong. Try again.")
          error.text = "Email or password is wrong. Try again."
            return false
        }
        
        return true
    }
    
    //function checks to see if username input and password input exist in database
    //to do when database is finished
    func checkValidAccount(userName: String, password: String) -> Bool {
        
        // Connect to the data base.
        let db = DBHelper()
        return db.checkUser(userName:userName, pass: password)
    }
}
