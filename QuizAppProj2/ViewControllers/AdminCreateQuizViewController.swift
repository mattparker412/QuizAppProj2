//
//  AdminCreateQuizViewController.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/20/22.
//

import UIKit

class AdminCreateQuizViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var quizName: UITextField!
    @IBOutlet weak var question: UITextField!
    @IBOutlet weak var wrongAnswerOne: UITextField!
    @IBOutlet weak var wrongAnswerTwo: UITextField!
    @IBOutlet weak var wrongAnswerThree: UITextField!
    @IBOutlet weak var correctAnswer: UITextField!
    var pickedTechnology : Int = 1
    //var placeHolderCount = 1
    
    
    let technologies = ["Swift", "Java", "Android"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return technologies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return technologies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedTechnology = row + 1
    }
    
    @IBAction func submitQuestion(_ sender: Any) {
        //print data that needs to be stored
       // print(placeHolderCount)
      //  guard placeHolderCount < 5 else{
       //     print("questions cannot exceed 5")
       //     return
       // }
       // print("past guard")
        print(pickedTechnology)
       // print(quizName.text!)
        print(question.text!)
        print(wrongAnswerOne.text!)
        print(wrongAnswerTwo.text!)
        print(wrongAnswerThree.text!)
        print(correctAnswer.text!)
        if (question.text! != "" && wrongAnswerTwo.text! != "" && wrongAnswerOne.text! != "" && wrongAnswerThree.text! != "" && correctAnswer.text! != ""){
        //store data from textfields into database
        db.addQuestionToDB(techID: pickedTechnology, question: question.text!, answer1: wrongAnswerOne.text!, answer2: wrongAnswerTwo.text!, answer3: wrongAnswerThree.text!, rightAnswer: correctAnswer.text!)
            successLabel.text = "Question added to DB Successfully!"
            successLabel.shake()
        }
        else{
            print("fields empty")
            successLabel.text = "Please fill out all available fields"
            successLabel.shake()
        }
        //reset textfields after stored in database
        question.text = ""
        wrongAnswerOne.text = ""
        wrongAnswerTwo.text = ""
        wrongAnswerThree.text = ""
        correctAnswer.text = ""
        
    }
    
//    //submits manual quiz to database
//    @IBAction func submitManualQuiz(_ sender: Any) {
//        print("quiz submitted")
//    }
//
//    //creates random quiz and stores in database
//    @IBAction func createRandomQuiz(_ sender: Any) {
//        print("random quiz created")
//    }
    
    @IBOutlet weak var technologyPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        successLabel.text = ""
        successLabel.adjustsFontSizeToFitWidth = true
        successLabel.textColor = .red

        technologyPicker.dataSource = self
        technologyPicker.delegate = self
        
    }
    


}

