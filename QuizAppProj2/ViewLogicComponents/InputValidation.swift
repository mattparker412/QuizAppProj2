//
//  InputValidation.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/17/22.
//

import Foundation
import UIKit
class InputValidation{
    
    func validateMonth(monthExpire: String) -> Bool{
        if(monthExpire.count != 2 || Int(monthExpire)! > 12 || Int(monthExpire)! < 1 || checkContainsOnlyDigits(stringToCheck: monthExpire) == false){
            return false
        }
        return true
    }
    func validateYear(yearExpire: String) -> Bool{
        if(yearExpire.count != 2 || Int(yearExpire)! < 22 || Int(yearExpire)! < 1 || checkContainsOnlyDigits(stringToCheck: yearExpire) == false){
            return false
        }
        return true
    }
    func validateCVC(cvc: String) -> Bool{
        if(cvc.count != 3 || checkContainsOnlyDigits(stringToCheck: cvc) == false){
            return false
        }
        return true
    }
    
    func validateCCNumber(creditCardNumber: String)-> Bool{
        if(creditCardNumber.count != 16 || checkContainsOnlyDigits(stringToCheck: creditCardNumber) == false){
            return false
        }
        return true
    }
    func checkExpiry(inputDate: String){
        
    }
    func checkContainsOnlyDigits(stringToCheck: String) -> Bool{
        let numbersSet = CharacterSet(charactersIn: "0123456789")

        let textCharacterSet = CharacterSet(charactersIn: stringToCheck)

        if textCharacterSet.isSubset(of: numbersSet) {
            print("text only contains numbers 0-9")
            
            return true
        } else {
            print(stringToCheck, " contains invalid credit information")
            return false
        }
    }
    
    func validateCreditCard(creditCard : String, cvc :String, expMonth : String, expYear: String, error:UILabel) -> Bool{
        if(validateCCNumber(creditCardNumber: creditCard) == false || validateCVC(cvc: cvc) == false) || validateMonth(monthExpire: expMonth) == false || validateYear(yearExpire: expYear) == false
        {
            if(validateCCNumber(creditCardNumber: creditCard) == false){
                print("cc number")
                error.text = "Invalid credit card number"
            }
            else if(validateMonth(monthExpire: expMonth) == false){
                print("month bad")
                error.text = "Invalid month"
            }
            else if(validateYear(yearExpire: expYear) == false){
                print("year bad")
                error.text = "Invalid year"
            }
            else if(validateCVC(cvc: cvc) == false){
                print("cvc bad")
                error.text = "Invalid cvc"
            }
            return false
        }
        return true
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
        
        return db.checkUser(userName:userName, pass: password)
    }
}
