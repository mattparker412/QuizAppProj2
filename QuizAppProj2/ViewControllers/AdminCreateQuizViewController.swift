//
//  AdminCreateQuizViewController.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/20/22.
//

import UIKit
import UserNotifications


class AdminCreateQuizViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UNUserNotificationCenterDelegate{
    
    // This variable is needed for notification.
    var notificationGranded: Bool = false
    
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
        
        // ***************** Notification code ****************************
        // Check if authorization for notifications was granded by the user.
         if notificationGranded
         {
             let content = UNMutableNotificationContent()
             content.title = "There is a new quizz."
             content.subtitle = "From Quizzer"
             content.body = "There is a new quizz. Sign into your account and test your knowledge."
             content.categoryIdentifier = "New quizz"
             
             // Set the trigger of the notification ( timer in this case).
             let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
             
             // Set the request of the notification.
             let request = UNNotificationRequest(identifier: "5 seconds.message",
                                                 content: content,
                                                 trigger: trigger)
             
             // Add the notification to the current notification center.
             UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
         }
        
    }
    
    //creates random quiz and stores in database
    @IBAction func createRandomQuiz(_ sender: Any) {
        print("random quiz created")
        // ***************** Notification code ****************************
        // Check if authorization for notifications was granded by the user.
         if notificationGranded
         {
             let content = UNMutableNotificationContent()
             content.title = "There is a new quizz."
             content.subtitle = "From Quizzer"
             content.body = "There is a new quizz. Sign into your account and test your knowledge."
             content.categoryIdentifier = "New quizz"
             
             // Set the trigger of the notification ( timer in this case).
             let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
             
             // Set the request of the notification.
             let request = UNNotificationRequest(identifier: "5 seconds.message",
                                                 content: content,
                                                 trigger: trigger)
             
             // Add the notification to the current notification center.
             UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
         }
    }
    
    @IBOutlet weak var technologyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        technologyPicker.dataSource = self
        technologyPicker.delegate = self
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound], completionHandler: {(granted, error) in})
        
        let content = UNMutableNotificationContent()
        content.title = "New Quizz"
        content.body = "A new " + pickedTechnology + " is available."
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: {(granded, err) in
            self.notificationGranded = granded
        })
    }
    


}
