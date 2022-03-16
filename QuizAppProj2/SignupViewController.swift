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
        //submits textfield input to DB
    }
    
    func validateLoginInput() -> Bool{
        if(userEmailText.text! == ""){
            print("Please enter an email")
            error.text = "Please enter an email."
            return false
        }else if(userPasswordText.text! == ""){
            print("Please enter a password.")
            error.text = "Please enter a password."
            return false
        } else if(checkValidAccount() == false){
            print("Email or password is wrong. Try again.")
            error.text = "Email or password is wrong. Try again."
            return false
        }
        
        return true
    }

}
