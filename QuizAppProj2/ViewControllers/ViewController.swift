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

class ViewController: UIViewController {
   // var i = InitialDbInserts()
    
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var error: UILabel!
    let wrongPass = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //i.connect()
        //i.insertInitial()
        
        
        wrongPass.center = CGPoint(x: view.center.x, y: 420)
        wrongPass.textColor = .red
        wrongPass.textAlignment = .center
        wrongPass.numberOfLines = 2
        
        
        var f1 = db.prepareDatabaseFile()
                if sqlite3_open(f1, &db.db) != SQLITE_OK{
                    print("can't open database")
                }
               // db.connect()
        
        //let db = DBHelper()
        
//     let feedBacks = db.getFeedBacks()
//        //print(feedBacks)
//
//        for f in feedBacks{
//            print(f["name"]! + " ----> " + f["feedback"]!)
//        }
        
        //i.connect()
        //i.insertInitial()
        // Do any additional setup after loading the view.
        pass.isSecureTextEntry = true
        let loginButton = FBLoginButton()
        loginButton.permissions = ["public_profile", "email"]
        loginButton.center = CGPoint(x: view.center.x, y: 600)
        view.addSubview(loginButton)
        if let token = AccessToken.current,
                !token.isExpired {
                // User is logged in, do work such as go to next view controller.
            
            }
        else{
            
        }
    }
    
    let validation = InputValidation()
    @IBAction func login(_ sender: Any) {
        if db.checkUsernameExists(userName: user.text!) || db.checkAdminUsernameExists(userName: user.text!){
            if db.checkUser(userName: user.text!, pass: pass.text!) == true{
                
                print(user.text!,"logged in as user")
                userName = user.text!
                userID = db.getUserID(userName: userName!)
                    //nav()
                    navigateToUserController()
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
                print("error wrong password")
            }
        }
        else{
            wrongPass.text = "Error: Username Does Not Exist, Please Sign Up"
            
            view.addSubview(wrongPass)
            wrongPass.shake()
            print("username does not exist, please sign up")
        }
    }
    
    
    func nav(){
        print("inside nav")
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "userPage") as! UserPageViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    func navigateToUserController(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "userPage") as! UIViewController
        //self.navigationController?.pushViewController(nextViewController, animated: true)
        self.view?.window?.rootViewController = nextViewController
        self.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:false, completion: nil)
        
        

    }
    
    func navigateToQuizPage(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "userPage") as! UserPageViewController
        //self.navigationController?.pushViewController(nextViewController, animated: true)
        self.present(nextViewController, animated:false, completion: nil)
    }
    
    func navigateToAdmin(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Admin", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "adminPage") as! AdminViewController
        nextViewController.modalPresentationStyle = .fullScreen
        //self.navigationController?.pushViewController(nextViewController, animated: true)
        self.present(nextViewController, animated:false, completion: nil)
    }
/*
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startAnimate()
    }
    
    /*
    // Override to remove this view from the navigation stack
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Remove self from navigation hierarchy
        guard let viewControllers = navigationController?.viewControllers,
              let index = viewControllers.firstIndex(of: self) else {
                return
                
            }
        navigationController?.viewControllers.removeFirst(index)
    }*/
    
    func navigateToController(){
        print("inside nav")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "loginPage") as! LoginViewController
        self.present(nextViewController, animated:true, completion: nil)
        print("completed nav")
    }
    
   /*
    override func viewDidAppear(_ animated: Bool) {
        print("inside viewdidappear")
        navigateToController()
    }
    */
    
    func animateRotation(){
        UIView.animate(withDuration: 1.75, animations: {
            self.label.transform = CGAffineTransform(rotationAngle:  .pi)
        })
        UIView.animate(withDuration: 2.0, animations: {
            self.label.transform = CGAffineTransform(rotationAngle:  2 * .pi)
                    })
    }
    func endAnimation(){
        UIView.animate(withDuration: 1.75, animations: {
            self.label.transform = CGAffineTransform(rotationAngle:  .pi)
        })
        UIView.animate(withDuration: 2.0, animations: {
            self.label.transform = CGAffineTransform(rotationAngle:  2 * .pi)
            self.label.alpha = 0
                    })
    }
    
    func startAnimate(){
        print("function was called")
        var timerCount = 0
        let timer = Timer.scheduledTimer(withTimeInterval: 1.75, repeats: true) { timer in
            timerCount += 1
            
            print(timerCount)
            if(timerCount == 3){
                self.endAnimation()
                timer.invalidate()
                let navigateTime = Timer.scheduledTimer(withTimeInterval: 3.75, repeats: false){
                    navigateTime in self.navigateToController()//self.loadLogin()
                }
            }
            var count = 3
            repeat{
                self.animateRotation()
                count -= 1
            } while(count > 0)
        }
        
        //Timer.scheduledTimer(timeInterval: 1.75, target: self, selector: #selector(updateImage), userInfo: nil, repeats: true) // target where it shoudl find selector self means current one
    }

    func loadLogin(){
        print("loadlogin called")
        let username = UITextField()
        username.frame = CGRect(x: self.view.frame.size.width/2 - 25, y : self.view.frame.size.height/2+75, width : 100, height: 50)
        username.backgroundColor = UIColor.white
        self.view.addSubview(username)
        //username.setTitle("username", for: .normal)
        let login = UIButton()
        login.frame = CGRect(x: self.view.frame.size.width/2-25, y: self.view.frame.size.height/2, width: 100, height: 50)
        login.backgroundColor = UIColor.black
        login.setTitle("login", for: .normal)
        login.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        self.view.addSubview(login)
        
        let signup = UIButton()
        signup.frame = CGRect(x: self.view.frame.size.width/2-25, y: self.view.frame.size.height/2-75, width: 100, height: 50)
        signup.backgroundColor = UIColor.black
        signup.setTitle("signup", for: .normal)
        signup.addTarget(self, action: #selector(signupAction), for: .touchUpInside)
        self.view.addSubview(signup)
    }
    
    @objc func loginAction(sender: UIButton!) {
       print("login tapped")
    }
    @objc func signupAction(sender: UIButton!) {
       print("signup tapped")
    }
    
*/
    
}
extension UIView{
    func shake(){
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 2
        animation.values = [-20, 20, -20, 20, -20, 20, -5, 5, 0]
        layer.add(animation, forKey: "shake")
    }
}

