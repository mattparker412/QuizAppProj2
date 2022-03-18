//
//  QuizViewController.swift
//  CollectionDemo
//
//  Created by admin on 3/16/22.
//

import UIKit

class QuizViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var quizTable: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    var questionNumber = 1
    var pickQuestion : Int?
    var techChoice : Int?
    var swiftQuestionData = ["What is Swift?", "What was the original name for iOS?", "What is the difference between a Table View and Collection View?", "What is XCode?", "How many ways to pass data from one controller to another?"]
    var swiftQuestionAnswer1 = ["A bird", "Internal Operating System", "They are the same", "Apple's IDE for macOS", "1"]
    var swiftQuestionAnswer2 = ["A plane", "iPhone Operating System", "Table view scrolls horizontally", "A video game about the letter X", "3"]
    var swiftQuestionAnswer3 = ["Something going fast", "Immortal Operating System", "Collection View is a collection of labels", "Microsoft's IDE for Windows", "10"]
    var swiftQuestionAnswer4 = ["A language developed by Apple for iOS", "Illegal Operating System", "Table view scrolls vertically", "A code editor for Android", "5"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else{
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizcell", for: indexPath) as! QuizTableViewCell
        if indexPath.section == 1{
            cell.answerLabel.font = UIFont.systemFont(ofSize: 16)
            cell.selectionStyle = .default
            switch indexPath.row{
            case 0:
                cell.answerLabel.text = swiftQuestionAnswer1[pickQuestion!]
                swiftQuestionAnswer1.remove(at: pickQuestion!)
                print(swiftQuestionAnswer1)
            case 1:
                cell.answerLabel.text = swiftQuestionAnswer2[pickQuestion!]
                swiftQuestionAnswer2.remove(at: pickQuestion!)
            case 2:
                cell.answerLabel.text = swiftQuestionAnswer3[pickQuestion!]
                swiftQuestionAnswer3.remove(at: pickQuestion!)
            case 3:
                cell.answerLabel.text = swiftQuestionAnswer4[pickQuestion!]
                swiftQuestionAnswer4.remove(at: pickQuestion!)
            default:
                print("impossible error")
                
            }
        }
        else if indexPath.section == 0{
            cell.selectionStyle = .none
            cell.answerLabel.font = UIFont.systemFont(ofSize: 24)
            cell.answerLabel.numberOfLines = 3
            cell.answerLabel.text = swiftQuestionData[pickQuestion!]
            swiftQuestionData.remove(at: pickQuestion!)
            print(swiftQuestionData)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 150
        case 1:
            return 43.5
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section{
        case 0:
            return 20
        case 1:
            return 10
        default:
            return 0
        }
    }
    
    
    

    
    @IBOutlet weak var textLabel: UILabel!
    public var text : String? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        switch techChoice{
        case 1:
            textLabel.text = "Swift"
        case 2:
            textLabel.text = "Java"
        case 3:
            textLabel.text = "Android"
        default:
            textLabel.text = "Error"
            
        }

    }
    
    @IBAction func pressNext(_ sender: Any) {
        //store answer
       
        
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
            performSegue(withIdentifier: "backtoquizhome", sender: self)
        }
        if questionNumber != 6{
            quizTable.reloadData()
        }
        
    }

}
