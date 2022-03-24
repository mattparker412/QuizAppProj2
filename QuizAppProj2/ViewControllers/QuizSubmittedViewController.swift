//
//  QuizSubmittedViewController.swift
//  QuizAppProj2
//
//  Created by admin on 3/23/22.
//

import UIKit

class QuizSubmittedViewController: UIViewController {
    
    var userID : Int?
    
    @IBOutlet weak var goToRanking: UIButton!
    
    @IBOutlet weak var goToQuizzes: UIButton!
    @IBOutlet weak var goToFeedback: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleButton(goToRanking)
        Utilities.styleButton(goToQuizzes)
        Utilities.styleButton(goToFeedback)

        
    }
    
    @IBAction func rankPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToRanking", sender: self)
    }
    
   
    @IBAction func feedbackPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToFeedback", sender: self)
    }
    
    @IBAction func quizPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToQuiz", sender: self)
    }
}

