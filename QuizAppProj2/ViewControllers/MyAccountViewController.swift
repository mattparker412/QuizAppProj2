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
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var claimButton: UIButton!
    //var isSubbed = false
    
    
    var username: String?
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyy"
        let menu = MenuController(with: views)
        menu.delegate = self
        sideMenu = menuCaller.displaySideMenu(sideMenu: sideMenu, menu: menu, view: view)
        print("top three")
        var topSwiftThree = db.getTopThree(techID: 1)
        var topiOSThree = db.getTopThree(techID: 2)
        var topAndroidThree = db.getTopThree(techID: 3)
        var myRanks = [Int]()
        username = db.getUserName(userId: userID!)
        if(topiOSThree.contains(username!)){
            myRanks.append(topiOSThree.firstIndex(of: username!)! + 1)
        }
        if(topSwiftThree.contains(username!)){
            myRanks.append(topSwiftThree.firstIndex(of: username!)! + 1)
        }
        if(topAndroidThree.contains(username!)){
            myRanks.append(topAndroidThree.firstIndex(of: username!)! + 1)
        }
        if db.getClaim(userID: userID!) == 1{
            claimButton.isHidden = true
        }
        
        let date = Date()
        var dateComponent = DateComponents()
        dateComponent.day = 0 // set this to simulate first day of month claim
        let exampleDate = Calendar.current.date(byAdding: dateComponent, to: Date())
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: exampleDate!)
        let dayOfMonth = components.day
        
        if myRanks.contains(1){
            rank.text = "Rank 1!"
            if dayOfMonth! == 1{
                claimButton.isHidden = false
                db.setClaim(userID: userID!, claimBool: 1)
            }
        } else if (myRanks.contains(2)){
            rank.text = "Rank 2!"
            if dayOfMonth! == 1{
                claimButton.isHidden = false
                db.setClaim(userID: userID!, claimBool: 1)
            }
        } else if (myRanks.contains(3)){
            rank.text = "Rank 3!"
            if dayOfMonth! == 1{
                claimButton.isHidden = false
                db.setClaim(userID: userID!, claimBool: 1)
            }
        }
        
        user.text = db.getUserName(userId: userID!)
        var account = db.getUserName(userId: userID!)
        // print(userName) why is this even nil?
        
        if(isSubscribed == false){
            subDate.text = "No subscription"
            //isSubscribed = false
        } else {
            subDate.text = String(db.getEnd(userId: userID!)!)
            //isSubscribed = true
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
        if isSubscribed == false{
            errorLabel.backgroundColor = color
            errorLabel.textColor = .red
            errorLabel.text = "No subscription to cancel"
        }
        db.updateSubStartDate(userid: userID!, subStatus: false, subscriptionType: false)
        //db.updateSubEndDate(userid: userID!, startDate: db.getSubStartDate(userid: userID!), subStatus: isSubscribed, subscriptionType: isMonthly!)
        isSubscribed = db.changeSubStatus(subStatus: isSubscribed, userid: userID!)
        quizzesLeft = 2 - db.checkQuizzesTaken(userid: userID!, date: dateFormatter.string(from: date))
        if quizzesLeft! < 0{
            quizzesLeft = 0
        }
        subDate.text = "No subscription"
        print("subscription cancelled")
    }

    @IBAction func claimRewards(){
        
        var rankText: String!
        var endOfSub : String?
        rankText = rank.text!
        if isSubscribed == true{
            endOfSub = db.getEnd(userId: userID!)
        }
        else{
            endOfSub = dateFormatter.string(from: date)
        }
        switch rankText{
            case "Rank 1!":
                print("hello")

            subDate.text = db.addSubTime(userid: userID!, endDate: endOfSub!, rank: 1)
            claimButton.isHidden = true
            
            case "Rank 2!":
            subDate.text = db.addSubTime(userid: userID!, endDate: endOfSub!, rank: 2)
            claimButton.isHidden = true
            case "Rank 3!":
            subDate.text = db.addSubTime(userid: userID!, endDate: endOfSub!, rank: 3)

            claimButton.isHidden = true
            default:
                print("goodbye")
        
        }
        //db.changeSubStatus(subStatus: true, userid: userID!)
        print("rewards claimed")
        if isSubscribed == false{
            isSubscribed = db.changeSubStatus(subStatus: isSubscribed, userid: userID!)
        }
        quizzesLeft = -1
    }
}
