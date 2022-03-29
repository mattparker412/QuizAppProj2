//
//  SignupViewController.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/16/22.
//
import UIKit

/// Defines the sign up view class and how it handles inputs
class SignupViewController: UIViewController {

    var isAdmin = false
    @IBOutlet weak var adminCode: UITextField!
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    let wrongPass = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
    override func viewDidLoad() {
        super.viewDidLoad()
        wrongPass.center = CGPoint(x: view.center.x, y: view.center.y)
        wrongPass.textColor = .red
        wrongPass.textAlignment = .center
        wrongPass.numberOfLines = 2
    }
    

    /**
            When submit button pressed, input is validated and if valid is stored in the DB
     */
    @IBAction func submitToDB(_ sender: Any) {
        if adminCode.text! == "1234"{
            isAdmin = true
        }
        if (username.text != "" && password.text != ""){
            if isAdmin == false{
                if db.checkUsernameExists(userName: username.text!) == false{
                    db.addNewUser(userName: username.text!, passWord: password.text!)
                    print("user saved")
                    self.performSegue(withIdentifier: "backToLogin", sender: self)
                }
                else{
                    wrongPass.text = "Error: Username Already Exists"
                    view.addSubview(wrongPass)
                    wrongPass.shake()
                    print("user exists")
                }
            }
            else if isAdmin == true{
                if db.checkAdminUsernameExists(userName: username.text!) == false{
                    db.addNewAdmin(userName: username.text!, passWord: password.text!)
                    print("admin saved")
                    self.performSegue(withIdentifier: "backToLogin", sender: self)
                }
                else{
                    wrongPass.text = "Error: Admin Already Exists"
                    view.addSubview(wrongPass)
                    wrongPass.shake()
                    print("admin exists")
                }
            }
        }
        else{
            wrongPass.text = "Error: Invalid Input"
            view.addSubview(wrongPass)
            wrongPass.shake()
            print("please enter valid input")
        }
    }
    let valid = InputValidation()
    func validateLoginInput() -> Bool{
        return true
    }
}
