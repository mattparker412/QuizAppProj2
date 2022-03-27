//
//  SubscribeViewController.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/23/22.
//

import UIKit
import SideMenu
class SubscribeViewController: UIViewController, MenuControllerDelegate {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var expireMonth: UITextField!
    @IBOutlet weak var expireYear: UITextField!
    @IBOutlet weak var cvc: UITextField!
    @IBOutlet weak var creditCard: UITextField!
    private var sideMenu: SideMenuNavigationController?
    
    var startSubscriptionDate = Date() // start date of subscription; store in DB
    var endSubscriptionDate = Date() // end of subscription, should add 30 days if monthly or 365 if annually is checked
    
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
    }
    
    let validator = InputValidation()
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(validator.validateCreditCard(creditCard: creditCard.text!, cvc: cvc.text!, expMonth: expireMonth.text!, expYear: expireYear.text! , error: errorLabel) == false){
            return false
        } else {
            
            isSubscribed = db.changeSubStatus(subStatus: isSubscribed, userid: userID!)
            //print(isSubscribed)
            quizzesLeft = -1
            return true
        }
    }
    @IBAction func subscribe(_ sender: Any) {
        if(validator.validateCreditCard(creditCard: creditCard.text!, cvc: cvc.text!, expMonth: expireMonth.text!, expYear: expireYear.text! , error: errorLabel) == true){
            //once textfield is validated isSubscribed gets updated in database
            //once updated, move to quiz view controller
            
        }
    }
    
}
