//
//  SignupViewController.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/16/22.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func submitToDB(_ sender: Any) {
        // Use this class
        let valid = InputValidation()
        //submits textfield input to DB
        // Check if you have empty strings, and if the user is already in the database by name, if ok store it into user.
        
    }
    let valid = InputValidation()
    func validateLoginInput() -> Bool{
       /* if(username.text! == ""){
            print("Please enter an email")
//            error.text = "Please enter an email."
            return false
        }else if(password.text! == ""){
            print("Please enter a password.")
//            error.text = "Please enter a password."
            return false
        } else if(valid.checkValidAccount(userName:username.text!, pass:password.text!) == false){
          print("Email or password is wrong. Try again.")
          error.text = "Email or password is wrong. Try again."
            return false
        }*/
        
        return true
    }
}
