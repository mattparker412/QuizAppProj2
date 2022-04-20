//
//  QuizViewController.swift
//  CollectionDemo
//
//  Created by admin on 3/16/22.
//

import UIKit
import SideMenu
//Class for presenting the user with a quiz
class QuizViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var quizTimer: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var quizTable: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    var remainingQuestions = [0,1,2,3,4]
    var questionNumber = 1
    var pickQuestion : Int?
    var techChoice : Int?
    var quizChoice : Quizz?
    var correctLocation : Int?
    var answerSelection : Int?
    var totalCorrect = 0

    //Section 0 contains question so only 1 row, section 2 contains answers so 3 rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else{
            return 3
        }
    }
    
    //Creates the cell for a given row, resizes cells for given section, sets correctlocation for score calculation
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizcell", for: indexPath) as! QuizTableViewCell
        //Question options
        if indexPath.section == 1{
            cell.answerLabel.font = UIFont.systemFont(ofSize: 16)
            cell.answerLabel.adjustsFontSizeToFitWidth = true
            cell.selectionStyle = .default
            switch indexPath.row{
            case 0:
                cell.answerLabel.text = quizChoice?.questions[remainingQuestions[pickQuestion!]].answer1
                if cell.answerLabel.text == quizChoice?.questions[remainingQuestions[pickQuestion!]].rightAnswer{
                    correctLocation = 1
                }

            case 1:
                cell.answerLabel.text = quizChoice?.questions[remainingQuestions[pickQuestion!]].answer2
                if cell.answerLabel.text == quizChoice?.questions[remainingQuestions[pickQuestion!]].rightAnswer{
                    correctLocation = 2
                }

            case 2:
                cell.answerLabel.text = quizChoice?.questions[remainingQuestions[pickQuestion!]].answer3
                if cell.answerLabel.text == quizChoice?.questions[remainingQuestions[pickQuestion!]].rightAnswer{
                    correctLocation = 3
                }
            
            default:
                print("impossible error")
                
                
            }
        }
        //Question itself
        else if indexPath.section == 0{
            cell.selectionStyle = .none
            cell.answerLabel.font = UIFont.systemFont(ofSize: 24)
            cell.answerLabel.adjustsFontSizeToFitWidth = true
            cell.answerLabel.numberOfLines = 3
            cell.answerLabel.text = quizChoice?.questions[remainingQuestions[pickQuestion!]].question
        }
        
        return cell
    }
    
    //Set height for the rows depending on which section (question or answers)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 150
        case 1:
            return 75
        default:
            return 0
        }
    }
    
    //Create the number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //Give the title for each section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "Question \(questionNumber)"
        case 1:
            return "Answers"
        default:
            return ""
        }
    }
    
    //Create the height of the section headers
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section{
        case 0:
            return 20
        case 1:
            return 20
        default:
            return 0
        }
    }
    
    //Set answer selection variable when selecting a row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        answerSelection = indexPath.row + 1
    }
    

    
    @IBOutlet weak var textLabel: UILabel!
    public var text : String? = nil
    var clock = Clock()
    var menu: SideMenuNavigationController?
    let createMenu = CallMenuList()
    
    
    var rankscore : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        var time = clock.countdownTimer(secondsRemaining: 1800, remainingTime : quizTimer, errorLabel : errorLabel)

    }
    
    //Button action for pressing next
    @IBAction func pressNext(_ sender: Any) {
        //store answer
        let calculator = CalculateRanking()
        
        //If out of time, stop the test and calculate score
        if quizTimer.text == "Out of time!"{
            clock.stopTimerTest()
            
            rankscore = calculator.calculateRank(timeLeft: 1800 - clock.leftOver, correctAnswers: totalCorrect)
            db.storeRanking(userName: userName!, userID: userID!, techID: techChoice!, rankScore: rankscore ?? 0)
            db.quizTaken(quiz: quizChoice!, userid: userID!, score: rankscore ?? 0, currentDate: dateFormatter.string(from: date))
            if isSubscribed == false{
                quizzesLeft! -= 1
            }
        
            self.performSegue(withIdentifier: "quizSubmitted", sender: self)
        }
        
        //If still time left on the timer
        else{
            //Make sure there is an answer selected and return otherwise (do nothing)
            if answerSelection == nil{
                print("please select an answer")
                errorLabel.text = "An answer must be selected"
                return
            }
            //If correct answer, add one to total correct
            if answerSelection == correctLocation{
                totalCorrect += 1
            }
            remainingQuestions.remove(at: pickQuestion!)
            
            //If we are at question 3 or less, pick a new random question to present
            if questionNumber < 4 {
            pickQuestion = Int.random(in: 0...(4-questionNumber))
            }
            //Otherwise select the only question left (only one left if we are on 4)
            else{
                pickQuestion = 0
            }
            //Add one to the question number we are currently on
            questionNumber += 1
            
            //If we are on the last question now, change next button to a submit button
            if questionNumber == 5{
                nextButton.setTitle("Submit", for: .normal)
            }
            //If we just finished question 5, stop the test and calculate score
            if questionNumber == 6{
                clock.stopTimerTest()
            
                rankscore = calculator.calculateRank(timeLeft: 1800 - clock.leftOver, correctAnswers: totalCorrect)
                db.storeRanking(userName: userName!, userID: userID!, techID: techChoice!, rankScore: rankscore ?? 0)
                
                db.quizTaken(quiz: quizChoice!, userid: userID!, score: rankscore ?? 0, currentDate: dateFormatter.string(from: date))
                
                //If not subscribed take away a daily quiz from the limit
                if isSubscribed == false{
                    quizzesLeft! -= 1
                }
            //Segue to the quiz submitted view
                self.performSegue(withIdentifier: "quizSubmitted", sender: self)
            }
            //If we were not done with the quiz yet reset our answer selection and reload the quiz table
            if questionNumber != 6{
                answerSelection = nil
                quizTable.reloadData()
                errorLabel.text = ""
            }
        }
        
    }
    //Give the next view our ranking score information to present to the user
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quizSubmitted"{
            let nextVC = segue.destination as? QuizSubmittedViewController
            nextVC?.score = rankscore!
        }
    }
    
    

}
