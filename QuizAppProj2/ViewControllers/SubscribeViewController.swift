//
//  SubscribeViewController.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/23/22.
//

import UIKit
import SideMenu
class SubscribeViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var expireMonth: UITextField!
    @IBOutlet weak var expireYear: UITextField!
    @IBOutlet weak var cvc: UITextField!
    @IBOutlet weak var creditCard: UITextField!
    var menu: SideMenuNavigationController?
    let createMenu = CallMenuList()
    
    
    @IBAction func didTapMenu(){
        present(menu! ,animated: true)
        //let menulist = MenuListController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu = createMenu.setUpSideMenu(menu: menu, controller: self)
    }
    
    let validator = InputValidation()
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(validator.validateCreditCard(creditCard: creditCard.text!, cvc: cvc.text!, expMonth: expireMonth.text!, expYear: expireYear.text! , error: errorLabel) == false){
            return false
        } else {
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
