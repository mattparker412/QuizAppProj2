//
//  NavigateToController.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/24/22.
//

import Foundation
import UIKit

/// When class is instanced, can navigate to a defined UIViewcontroller
class NavigateToController{
    
    /**
        Navigates to view controller
                
         -Parameters:
                -current: the current UIViewController
                -storyboard: the name of the storuboard reference
                -identifier: the identifier of the view controller
                -controller: the UIViewcontroller to navigate to
         -Returns: Void
     */
    func navToController(current: UIViewController, storyboard: String, identifier: String, controller: UIViewController){
        let storyBoard : UIStoryboard = UIStoryboard(name: storyboard, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: identifier)
        nextViewController.modalPresentationStyle = .fullScreen
        current.present(nextViewController, animated: true, completion:nil)
    }
    
    /**
            Determines which view controller to navigate to in SideMenu view table selection
            
            -Parameters:
                -named: the selected row of the side menu table view
            -Returns:
                -array of values to pass to navToController() function in relevant ViewControllers
        
     */
    func viewControllerSwitch(named: String) -> Array<Any>{
        
        if named == "MyAccount"{
            return ["Main","myAccount", MyAccountViewController()]
        } else if named == "Subscription"{
            return ["Main","subPage", SubscribeViewController()]
        } else if named == "Quizzes"{
            return ["Main","quizPage", QuizCollectionViewController()]
        } else if named == "Ranking"{
            return ["Main","rankingPage", RankingViewController()]
        }
        else if named == "Feedback"{
            return ["Main","feedbackPage", FeedbackViewController()]
        }
        else if named == "Logout"{
            return ["Main","loginPage", ViewController()]
        }
        return ["View Not Found"]
    }
}
