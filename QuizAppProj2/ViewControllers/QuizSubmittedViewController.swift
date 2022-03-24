//
//  QuizSubmittedViewController.swift
//  QuizAppProj2
//
//  Created by admin on 3/23/22.
//

import UIKit
import SideMenu
class QuizSubmittedViewController: UIViewController, MenuControllerDelegate {
    
    var userID : Int?
    
    @IBOutlet weak var goToRanking: UIButton!
    
    @IBOutlet weak var goToQuizzes: UIButton!
    @IBOutlet weak var goToFeedback: UIButton!
    private var sideMenu: SideMenuNavigationController?
    let views = ["Subscription","Quizzes","Feedback","Ranking","Logout"]
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
        Utilities.styleButton(goToRanking)
        Utilities.styleButton(goToQuizzes)
        Utilities.styleButton(goToFeedback)

        
    }
    
    @IBAction func rankPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToRanking", sender: self)
    }
    
   
    @IBAction func feedbackPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToFeedback", sender: self)
    }
    
    @IBAction func quizPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToQuiz", sender: self)
    }
}

