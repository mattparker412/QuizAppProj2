//
//  NavigateToController.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/24/22.
//

import Foundation
import UIKit
class NavigateToController{
    func navToController(current: UIViewController, storyboard: String, identifier: String, controller: UIViewController){
        let storyBoard : UIStoryboard = UIStoryboard(name: storyboard, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: identifier)
        nextViewController.modalPresentationStyle = .fullScreen
        current.present(nextViewController, animated: true, completion:nil)
    }
    
    //"Subscription","Quizzes","Feedback","Ranking","Logout"
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
