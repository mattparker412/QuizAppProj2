//
//  QuizViewController.swift
//  CollectionDemo
//
//  Created by admin on 3/16/22.
//

import UIKit
import SideMenu
/// Displays a table view of question and answer options
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else{
            return 3
        }
    }
    /**
            Picks answer text and places it into the cells in section 1, places text of question in section 0 of the table view
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizcell", for: indexPath) as! QuizTableViewCell
        
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
        else if indexPath.section == 0{
            cell.selectionStyle = .none
            cell.answerLabel.font = UIFont.systemFont(ofSize: 24)
            cell.answerLabel.adjustsFontSizeToFitWidth = true
            cell.answerLabel.numberOfLines = 3
            print(pickQuestion!)
            cell.answerLabel.text = quizChoice?.questions[remainingQuestions[pickQuestion!]].question
        }
        return cell
    }
    
    /**
            Sets the height for question row as double the height of the answers for visibility
     */
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
    
    /**
     Sets two sections, one for question and the other for the answer options
     */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    /**
        Sets the title of the question section with which question number the user is on
     */
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
    
    /**
     Sets the height of the headers as 20
     */
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
    
    /**
     When a user selects an answer option, sets the answerSelection variable as that row number plus 1 to keep track of their answer
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        answerSelection = indexPath.row + 1
    }
    

    
    @IBOutlet weak var textLabel: UILabel!
    public var text : String? = nil
    var clock = Clock()
    var menu: SideMenuNavigationController?
    let createMenu = CallMenuList()
    var rankscore : Int?
    
    /**
        On View did load sets the clock on a 30 minutes timer
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        var time = clock.countdownTimer(secondsRemaining: 1800, remainingTime : quizTimer, errorLabel : errorLabel)

    }
    
    /**
        When the next button is pressed either reloads data to the next question and stores answer for the last, or submits quiz
        Calculates score when all five questions answered, stores ranking in ranking database table
        Stores the quiz taken in the quizzestaken table with the date to keep track of daily quizzes
     */
    @IBAction func pressNext(_ sender: Any) {
        //store answer
        let calculator = CalculateRanking()
        
        
        if quizTimer.text == "Out of time!"{
            clock.stopTimerTest()
            
            rankscore = calculator.calculateRank(timeLeft: 1800 - clock.leftOver, correctAnswers: totalCorrect)
            db.storeRanking(userName: userName!, userID: userID!, techID: techChoice!, rankScore: rankscore ?? 0)
            
            db.quizTaken(quiz: quizChoice!, userid: userID!, score: rankscore ?? 0, currentDate: dateFormatter.string(from: date))
            if isSubscribed == false{
                quizzesLeft! -= 1
            }
        
            self.performSegue(withIdentifier: "quizSubmitted", sender: self)
        } else{
            if answerSelection == nil{
                errorLabel.text = "An answer must be selected"
                return
            }
            if answerSelection == correctLocation{
                totalCorrect += 1
            }
            remainingQuestions.remove(at: pickQuestion!)
            if questionNumber < 4 {
            pickQuestion = Int.random(in: 0...(4-questionNumber))
            }
            else{
                pickQuestion = 0
            }
            questionNumber += 1
            
            if questionNumber == 5{
                nextButton.setTitle("Submit", for: .normal)
            }
            if questionNumber == 6{
                clock.stopTimerTest()
            
                rankscore = calculator.calculateRank(timeLeft: 1800 - clock.leftOver, correctAnswers: totalCorrect)
                db.storeRanking(userName: userName!, userID: userID!, techID: techChoice!, rankScore: rankscore ?? 0)
                
                print(userName!, "Finished in", 1800-clock.leftOver,"seconds, with rank score of ",rankscore)
                
                print("Total correct answers:",totalCorrect)
                db.quizTaken(quiz: quizChoice!, userid: userID!, score: rankscore ?? 0, currentDate: dateFormatter.string(from: date))
                if isSubscribed == false{
                    quizzesLeft! -= 1
                }
            
                self.performSegue(withIdentifier: "quizSubmitted", sender: self)
            }
            if questionNumber != 6{
                answerSelection = nil
                quizTable.reloadData()
                errorLabel.text = ""
            }
        }
        
    }
    /**
     Gives the next view controller information about the score of the quiz to display when segue is performed
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quizSubmitted"{
            print("entered prepare for segue")
            let nextVC = segue.destination as? QuizSubmittedViewController
            nextVC?.score = rankscore!
        }
    }
}
