//
//  ViewController.swift
//  QuizAppProj2
//
//  Created by admin on 3/11/22.
//


import UIKit
import FBSDKLoginKit
import SQLite3

var db = DBHelper()
var userName : String?
var userID : Int?
var isSubscribed = false
let date = Date()
let dateFormatter = DateFormatter()
var quizzesLeft : Int?
let color = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)


/// Loads and displays initial view to user
class ViewController: UIViewController {
    
    // When running the program for the first time, uncomment line 29, 39, and 40--all the statements that involve var i
    // Uncommenting these statements will allow a database to be created and initialized in SQLlite
    // Once the database is first created, these statements can be commented back out
    //var i = InitialDbInserts()
    
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var pass: UITextField!
    //@IBOutlet weak var error: UILabel!
    let wrongPass = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // i.connect()
        //i.insertInitial()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        //Setup error text label
        wrongPass.center = CGPoint(x: view.center.x, y: view.center.y + 200)
        wrongPass.textColor = .red
        wrongPass.textAlignment = .center
        wrongPass.numberOfLines = 2
        
        var f1 = db.prepareDatabaseFile()
                if sqlite3_open(f1, &db.db) != SQLITE_OK{
                }
               
        pass.isSecureTextEntry = true
        
        //Create FB Login Button
        let loginButton = FBLoginButton()
        loginButton.permissions = ["public_profile", "email"]
        loginButton.center = CGPoint(x: view.center.x, y: 600)
        view.addSubview(loginButton)
        if let token = AccessToken.current,
                !token.isExpired {
            }
        else{
            
        }
    }
    
    /**
            Login function utilizes input validation class to validate input and makes DB query to check if a user is blocked or subscribed, then handles the click event based on this
     */
    let validation = InputValidation()
    @IBAction func login(_ sender: Any) {
        if db.checkUsernameExists(userName: user.text!) || db.checkAdminUsernameExists(userName: user.text!){
            if db.checkUser(userName: user.text!, pass: pass.text!) == true{
                print(user.text!,"logged in as user")
                userName = user.text!
                userID = db.getUserID(userName: userName!)
                
                if db.getSubStatus(userid: userID!) == 0{
                    isSubscribed = false
                    quizzesLeft = 2 - db.checkQuizzesTaken(userid: userID!, date: dateFormatter.string(from: date))
                    if quizzesLeft! < 0{
                        quizzesLeft = 0
                    }
                }
                else{
                    isSubscribed = true
                    quizzesLeft = -1
                }
                if db.getBlockStatus(userID: db.getUserID(userName: userName!)) == 1{
                    wrongPass.text = "Account Blocked"
                    view.addSubview(wrongPass)
                    
                    wrongPass.shake()
                } else{
                    if isSubscribed == true{
                        navigateToMyAccountPage()
                    }
                    else{
                        navigateToUserController()
                    }
                }
            }
            else if db.checkAdmin(userName: user.text!, pass: pass.text!) == true{
                print(user.text!, "logged in as admin")
                userName = user.text!
                
                navigateToAdmin()
                }
            else{
                
                wrongPass.text = "Error: Wrong Password"
                
                view.addSubview(wrongPass)
                wrongPass.shake()
            }
        }
        else{
            wrongPass.text = "Error: Username Does Not Exist, Please Sign Up"
            
            view.addSubview(wrongPass)
            wrongPass.shake()
        }
    }
    
    
    /**
            Navigates to the continue as guest or subscribe view 
     */
    func navigateToUserController(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "userPage") as! UIViewController
            self.view?.window?.rootViewController = nextViewController
            self.modalPresentationStyle = .fullScreen
            self.present(nextViewController, animated:false, completion: nil)
        
        
    
    }
    
    /**
            Navigates to the relevant my account view if the user is subscribed.
     */
    func navigateToMyAccountPage(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "myAccount") as! UIViewController
        //self.navigationController?.pushViewController(nextViewController, animated: true)
        self.present(nextViewController, animated:false, completion: nil)
    }
    
    /**
            Navigates to the administrator initial view if the user logs in as admin.
     */
    func navigateToAdmin(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Admin", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "adminPage") as! AdminViewController
        nextViewController.modalPresentationStyle = .fullScreen
        //self.navigationController?.pushViewController(nextViewController, animated: true)
        self.present(nextViewController, animated:false, completion: nil)
    }
    
}

/**
        UIView extension to animate shaking of any error messages
 */
extension UIView{
    func shake(){
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 2
        animation.values = [-20, 20, -20, 20, -20, 20, -5, 5, 0]
        layer.add(animation, forKey: "shake")
    }
}

