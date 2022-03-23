//
//  ViewController.swift
//  QuizAppProj2
//
//  Created by admin on 3/11/22.
//


import UIKit
import FBSDKLoginKit

class ViewController: UIViewController {
    let adminUser = "admin"
    let adminPass = "1234"
    let userUser1 = "user1"
    let userPass1 = "1234"
    let userUser2 = "user2"
    let userPass2 = "1234"
    var isSubbed = false
    var isAdmin = false
    
    //let i = InitialDbInserts()
    //let db = DBHelper()
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var error: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let db = DBHelper()
        //print("*********************************************************")
        
     let feedBacks = db.getFeedBacks()
        //print(feedBacks)
        
        for f in feedBacks{
            print(f["name"]! + " ----> " + f["feedback"]!)
        }
        
        //i.connect()
        //i.insertInitial()
        // Do any additional setup after loading the view.
        pass.isSecureTextEntry = true
        let loginButton = FBLoginButton()
        loginButton.permissions = ["public_profile", "email"]
        loginButton.center = view.center
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
        if validation.validateLoginInput(username: user.text!, password: pass.text!, error: error) == true{
            if (user.text! == userUser1 && pass.text! == userPass1){
                print("user1 logged in")
                isSubbed = false
                //nav()
                navigateToUserController()
            } else if(user.text! == userUser2 && pass.text! == userPass2){
                print("user2 logged in")
                isSubbed = true
                //navigate directly to quiz page
            } else if(user.text! == adminUser && pass.text! == adminPass){
                print("admin logged in")
                isAdmin = true
                //navigate to admin page
                navigateToAdmin()
            }
        }
    }
    
    
    func nav(){
        print("inside nav")
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "userPage") as! UserPageViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    func navigateToUserController(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "homeNavigation") as! UINavigationController
        //self.navigationController?.pushViewController(nextViewController, animated: true)
        self.view?.window?.rootViewController = nextViewController
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

