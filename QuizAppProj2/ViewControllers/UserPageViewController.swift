//
//  UserPageViewController.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/15/22.
//

import UIKit
import SideMenu
class UserPageViewController: UIViewController {
    
    

    var menu: SideMenuNavigationController?
    let createMenu = CallMenuList()
    
    
    @IBAction func didTapMenu(){
        present(menu! ,animated: true)
        //let menulist = MenuListController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu = createMenu.setUpSideMenu(menu: menu, controller: self)
        // Do any additional setup after loading the view.
        print("inside user")
        print(userID)
        print(userName)
    }
    



}
