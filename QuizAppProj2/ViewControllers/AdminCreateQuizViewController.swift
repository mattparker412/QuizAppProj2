//
//  AdminCreateQuizViewController.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/20/22.
//

import UIKit

class AdminCreateQuizViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var quizName: UITextField!
    @IBOutlet weak var question: UITextField!
    @IBOutlet weak var wrongAnswerOne: UITextField!
    @IBOutlet weak var wrongAnswerTwo: UITextField!
    @IBOutlet weak var wrongAnswerThree: UITextField!
    @IBOutlet weak var correctAnswer: UITextField!
    var pickedTechnology : String = ""
    var placeHolderCount = 1
    let placeHolderText = [1:"Question One",
                           2:"Question Two",
                           3:"Question Three",
                           4:"Question Four",
                           5:"Question Five"
    ]
    let technologies = ["Apple", "Swift", "Android"]
    
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
        pickedTechnology = technologies[row] as String
    }
    
    @IBAction func submitQuestion(_ sender: Any) {
        //print data that needs to be stored
        print(placeHolderCount)
        guard placeHolderCount < 5 else{
            print("questions cannot exceed 5")
            return
        }
        print("past guard")
        print(pickedTechnology)
        print(quizName.text!)
        print(question.text!)
        print(wrongAnswerOne.text!)
        print(wrongAnswerTwo.text!)
        print(wrongAnswerThree.text!)
        print(correctAnswer.text!)
        //store data from textfields into database
        
        //reset textfields after stored in database
        placeHolderCount += 1
        question.text = ""
        question.placeholder = placeHolderText[placeHolderCount]
        wrongAnswerOne.text = ""
        wrongAnswerTwo.text = ""
        wrongAnswerThree.text = ""
        correctAnswer.text = ""
        
    }
    
    //submits manual quiz to database
    @IBAction func submitManualQuiz(_ sender: Any) {
        print("quiz submitted")
    }
    
    //creates random quiz and stores in database
    @IBAction func createRandomQuiz(_ sender: Any) {
        print("random quiz created")
    }
    
    @IBOutlet weak var technologyPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        technologyPicker.dataSource = self
        technologyPicker.delegate = self
        
    }
    


}

