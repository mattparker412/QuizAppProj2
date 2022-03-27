//
//  MyAccountViewController.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/26/22.
//

import UIKit
import SideMenu

class MyAccountViewController: UIViewController, MenuControllerDelegate {

    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var swiftScore: UILabel!
    @IBOutlet weak var iOSScore: UILabel!
    @IBOutlet weak var androidScore: UILabel!
    @IBOutlet weak var averageScore: UILabel!
    @IBOutlet weak var subDate: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    var isSubbed = false
    
    
    var userName: String?
    private var sideMenu: SideMenuNavigationController?
    let views = ["MyAccount","Subscription","Quizzes","Feedback","Ranking","Logout"]
    let menuCaller = CreateSideMenu()
    
    @IBAction func didTapMenu(){
        present(sideMenu!, animated: true)
    }

    let navigator = NavigateToController()
    func didSelectMenuItem(named: String) {
        sideMenu?.dismiss(animated: true, completion: { [weak self] in
            
            var controllerToNav = self?.navigator.viewControllerSwitch(named: named)
            self?.navigator.navToController(current: self!, storyboard: controllerToNav![0] as! String, identifier: controllerToNav![1] as! String, controller: controllerToNav![2] as! UIViewController)

        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menu = MenuController(with: views)
        menu.delegate = self
        sideMenu = menuCaller.displaySideMenu(sideMenu: sideMenu, menu: menu, view: view)
        print(userID)
        user.text = db.getUserName(userId: userID!)
        var account = db.getUserName(userId: userID!)
        // print(userName) why is this even nil?
        
        if(String(db.getEnd(userId: userID!)) == ""){
            subDate.text = "No subscription"
            isSubbed = false
        } else {
            subDate.text = String(db.getEnd(userId: userID!))
            isSubbed = true
        }
        
        // Do any additional setup after loading the view.
        let scores = (db.getTotalScoreForUser(userName: account))
        swiftScore.text = String(scores[0])
        iOSScore.text = String(scores[1])
        androidScore.text = String(scores[2])
        var sumScores = 0
        for score in 0..<scores.count{
            sumScores += scores[score]
        }
        averageScore.text = String(sumScores/3)
    }
    

    @IBAction func cancelSub(){
        if isSubbed == false{
            errorLabel.backgroundColor = color
            errorLabel.textColor = .red
            errorLabel.text = "No subscription to cancel"
        }
        db.updateSubStartDate(userid: userID!, subStatus: false, subscriptionType: false)
        //db.updateSubEndDate(userid: userID!, startDate: db.getSubStartDate(userid: userID!), subStatus: isSubscribed, subscriptionType: isMonthly!)
        isSubscribed = db.changeSubStatus(subStatus: false, userid: userID!)
        subDate.text = "No subscription"
        print("subscription cancelled")
    }
}
