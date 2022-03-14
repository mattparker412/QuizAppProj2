//
//  ViewController.swift
//  QuizAppProj2
//
//  Created by admin on 3/11/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startAnimate()
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
                    navigateTime in self.loadLogin()//self.navigateToController()
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
        let button = UIButton()
        button.frame = CGRect(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2, width: 100, height: 50)
        button.backgroundColor = UIColor.black
        button.setTitle("login", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func buttonAction(sender: UIButton!) {
       print("Button tapped")
    }
    /*
    func navigateToController(){
        print("inside nav")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "loginPage") as! LoginViewController
        self.present(nextViewController, animated:true, completion: nil)
        print("completed nav")
    }*/

}

