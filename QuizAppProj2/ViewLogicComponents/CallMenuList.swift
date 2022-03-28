//
//  CallMenuList.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/23/22.
//

import Foundation
import SideMenu
import UIKit

/// Defines the side menu interface
class CallMenuList{
    /**
            Defines the interface of the side menu. Used whenever a sidemenu wants to be created in a view controller class.
            -Parameters:
                -sideMenu: the navigation controller defined in the particular view controller class sidemenu is being created in
                -menu: MenuController instance that sets the tableview and other data in sidemenu
                -Returns the sidemenu navigation controller
     */
    func setUpSideMenu(menu: SideMenuNavigationController?, controller : UIViewController)->SideMenuNavigationController{
        var menu = menu
        menu = SideMenuNavigationController(rootViewController:  MenuListController())
        menu?.leftSide = false
        menu?.setNavigationBarHidden(
            true, animated: false)
        SideMenuManager.default.rightMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: controller.view)
        return menu!
    }
}
