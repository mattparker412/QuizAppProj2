//
//  CreateSideMenu.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/24/22.
//

import Foundation
import SideMenu
import UIKit

class CreateSideMenu{
    func displaySideMenu(sideMenu: SideMenuNavigationController?, menu: MenuController, view: UIView)->SideMenuNavigationController{
        var sideMenu = sideMenu
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = false
        SideMenuManager.default.rightMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view) //view is view controllers view
        return sideMenu!
    }
    
}

