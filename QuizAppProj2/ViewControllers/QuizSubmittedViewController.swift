//
//  QuizSubmittedViewController.swift
//  QuizAppProj2
//
//  Created by admin on 3/23/22.
//

import UIKit
import SideMenu
class QuizSubmittedViewController: UIViewController, MenuControllerDelegate {
    
    
    @IBOutlet weak var goToRanking: UIButton!
    
    @IBOutlet weak var goToQuizzes: UIButton!
    @IBOutlet weak var goToFeedback: UIButton!
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
        let quizLeft = UILabel(frame: CGRect(x: view.center.x, y: 50, width: 140, height: 50))
        quizLeft.textAlignment = .center
        quizLeft.adjustsFontSizeToFitWidth = true
        quizLeft.center.x = view.center.x
        //quizLeft.center = CGPoint(x: view.center.x, y: 50)
        if isSubscribed == false{
            quizLeft.text = "Quizzes Left: \(quizzesLeft!)"
            view.addSubview(quizLeft)
        }
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
        if quizzesLeft != 0{
        performSegue(withIdentifier: "goToQuiz", sender: self)
        }
        else{
            let noQuiz = UILabel(frame: CGRect(x: 100 , y: 500, width: 300, height: 50))
            noQuiz.text = "Error: No quizzes left today"
            noQuiz.textColor = .red
            view.addSubview(noQuiz)
            print("error: no quizzes left today")
        }
    }
}

