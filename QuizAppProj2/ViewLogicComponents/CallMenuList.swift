//
//  CallMenuList.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/23/22.
//

import Foundation
import SideMenu
import UIKit
class CallMenuList{
    
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
