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
    var username: String?
    private var sideMenu: SideMenuNavigationController?
    let views = ["MyAccount","Subscription","Quizzes","Feedback","Ranking","Logout"]
    let menuCaller = CreateSideMenu()
    /// If tapped, display side menu
    @IBAction func didTapMenu(){
        present(sideMenu!, animated: true)
    }
    /// Creates side menu UI
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
        /**
            In a fully functioning application, dateComponent.day should be set to 0
            It is set to the number of days difference to get to the first day of the next month for demo purposes.
            When set to 0, the application claimRewardButton will only be redisplayed the first of every month
         */
        dateComponent.day = 4 // set this to 0 to simulate first day of month claim reward functionality
        let exampleDate = Calendar.current.date(byAdding: dateComponent, to: Date())
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: exampleDate!)
        let dayOfMonth = components.day
        /// Block of if-else-if statements is to determine what rank a person is and
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
        if(isSubscribed == false){
            subDate.text = "No subscription"
        } else {
            subDate.text = String(db.getEnd(userId: userID!)!)
        }
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
    /// Cancels a user's subscription
    @IBAction func cancelSub(){
        if isSubscribed == false{
            errorLabel.backgroundColor = color
            errorLabel.textColor = .red
            errorLabel.text = "No subscription to cancel"
        }
        db.updateSubStartDate(userid: userID!, subStatus: false, subscriptionType: false)
        isSubscribed = db.changeSubStatus(subStatus: isSubscribed, userid: userID!)
        quizzesLeft = 2 - db.checkQuizzesTaken(userid: userID!, date: dateFormatter.string(from: date))
        if quizzesLeft! < 0{
            quizzesLeft = 0
        }
        subDate.text = "No subscription"
        print("subscription cancelled")
    }
    /// When clicked, rewards are claimed and DB updated to reflect subscription status changes and any other associated updates
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
        print("rewards claimed")
        if isSubscribed == false{
            isSubscribed = db.changeSubStatus(subStatus: isSubscribed, userid: userID!)
        }
        db.setClaim(userID: userID!, claimBool: 0)
        quizzesLeft = -1
    }
}
