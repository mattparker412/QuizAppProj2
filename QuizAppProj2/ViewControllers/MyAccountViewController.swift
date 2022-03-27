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
        
        //date data supposed to be from database
        var endOfSubscription = Date() // gets date. can add 10, 20, or 30 if option is available because of rank 1,2,3 position in a technology
        
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateStyle = .medium
        formatter.locale = .current
        formatter.dateFormat = "MM/dd/yyyy"
        
        // example of adding more days to user who has good rank
        var dateComponent = DateComponents()
        dateComponent.day = 10
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: endOfSubscription)
        
        subDate.text = formatter.string(from: futureDate!)
        
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
    

}
