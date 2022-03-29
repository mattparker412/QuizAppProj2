//
//  UserPageViewController.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/15/22.
//

import UIKit
import SideMenu

/// Provides UI to choose whether or not to continue as guest or to get a subscription. Only shown if user is not subscribed. Otherwise program flow navigates directly to MyAccount page.
class UserPageViewController: UIViewController, MenuControllerDelegate {

    private var sideMenu: SideMenuNavigationController?
    let views = ["MyAccount","Subscription","Quizzes","Feedback","Ranking","Logout"]
    
    let menuCaller = CreateSideMenu() // Instantiates side menu via the CreateSideMenu class
    
    /**
            Navigates to the selected view when tapped in the Side Menu table view
     */
    @IBAction func didTapMenu(){
        present(sideMenu!, animated: true)
    }

    let navigator = NavigateToController()
    func didSelectMenuItem(named: String) {
        if named == "Quizzes"{
            if quizzesLeft == 0{
                print("Error: No quizzes left")
            }
        }
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
    }
    



}
