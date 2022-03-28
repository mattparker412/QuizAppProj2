//
//  CreateSideMenu.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/24/22.
//

import Foundation
import SideMenu
import UIKit

/// Defines the side menu interface
class CreateSideMenu{
    /**
            Defines the interface of the side menu. Used whenever a sidemenu wants to be created in a view controller class.
            -Parameters:
                -sideMenu: the navigation controller defined in the particular view controller class sidemenu is being created in
                -menu: MenuController instance that sets the tableview and other data in sidemenu
                -Returns the sidemenu navigation controller
     */
    func displaySideMenu(sideMenu: SideMenuNavigationController?, menu: MenuController, view: UIView)->SideMenuNavigationController{
        var sideMenu = sideMenu
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = false
        SideMenuManager.default.rightMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view) //view is view controllers view
        return sideMenu!
    }
    
}

