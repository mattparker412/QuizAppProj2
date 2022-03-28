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
    @IBOutlet weak var monthlyButton: UIButton!
    @IBOutlet weak var annuallyButton: UIButton!
    private var sideMenu: SideMenuNavigationController?
    var isMonthly : Bool?
    
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
    
    @IBAction func checkedMonthly(){
        isMonthly = true
        monthlyButton.setImage(UIImage(systemName: "checkmark.square"), for: UIControl.State.normal)
        annuallyButton.setImage(UIImage(systemName: "square"), for: UIControl.State.normal)
        print("isMonthly")
    }
    @IBAction func checkedAnnually(){
        isMonthly = false
        monthlyButton.setImage(UIImage(systemName: "square"), for: UIControl.State.normal)
        annuallyButton.setImage(UIImage(systemName: "checkmark.square"), for: UIControl.State.normal)
        print("is annually")
    }
    let validator = InputValidation()
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(validator.validateCreditCard(creditCard: creditCard.text!, cvc: cvc.text!, expMonth: expireMonth.text!, expYear: expireYear.text! , error: errorLabel) == false){
            return false
        } else {
            
            if isMonthly == nil{
                errorLabel.text = "Subscription type must be selected."
                return false
            } else{
                
                db.updateSubStartDate(userid: userID!, subStatus: true, subscriptionType: isMonthly!)
                //db.updateSubEndDate(userid: userID!, startDate: db.getSubStartDate(userid: userID!), subStatus: isSubscribed, subscriptionType: isMonthly!)
                isSubscribed = db.changeSubStatus(subStatus: true, userid: userID!)
                //print(isSubscribed)
                quizzesLeft = -1
                return true
            }
        }
    }
    
    @IBAction func subscribe(_ sender: Any) {
        if(validator.validateCreditCard(creditCard: creditCard.text!, cvc: cvc.text!, expMonth: expireMonth.text!, expYear: expireYear.text! , error: errorLabel) == true){
            //once textfield is validated isSubscribed gets updated in database
            //once updated, move to quiz view controller
            
        }
    }
    
}
