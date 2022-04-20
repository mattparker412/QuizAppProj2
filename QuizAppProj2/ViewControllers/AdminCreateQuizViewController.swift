//
//  AdminCreateQuizViewController.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/20/22.
//

import UIKit
import UserNotifications

//View controller to create a quiz on admin storyboard
class AdminCreateQuizViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UNUserNotificationCenterDelegate{
    
    // This variable is needed for notification.
    var notificationGranded: Bool = false
    
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var quizName: UITextField!
    @IBOutlet weak var question: UITextField!
    @IBOutlet weak var wrongAnswerOne: UITextField!
    @IBOutlet weak var wrongAnswerTwo: UITextField!
    @IBOutlet weak var wrongAnswerThree: UITextField!
    @IBOutlet weak var correctAnswer: UITextField!
    var pickedTechnology : Int = 1
    
    
    let technologies = ["Swift", "Java", "Android"]
    
   //Only one component in the picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Number of rows in the picker equal to number of technologies
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return technologies.count
    }
    
    //Title for each row is taken from technologies array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return technologies[row]
    }
    
    //When selecting a row, set pickedTechnology variable
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedTechnology = row + 1
    }
    
    //Function to create a notification to the user
    func generateNotification(){
        let content = UNMutableNotificationContent()
        content.title = "There is a new question."
        content.subtitle = " From Quizzer"
        content.body = "There is a new question. Sign into your account and test your knowledge."
        content.categoryIdentifier = "New question"
        
        let ntrigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let nreq = UNNotificationRequest(identifier: "User Local", content: content, trigger: ntrigger)
        UNUserNotificationCenter.current().add(nreq){
            err in if let error = err{
                print("didn't work notification", error)
            }
        }
    }
    
    //Button function to submit the question to the database
    @IBAction func submitQuestion(_ sender: Any) {
        
        //Check if any of the fields are empty
        if (question.text! != "" && wrongAnswerTwo.text! != "" && wrongAnswerOne.text! != "" && wrongAnswerThree.text! != "" && correctAnswer.text! != ""){
            
        //store data from textfields into database
        db.addQuestionToDB(techID: pickedTechnology, question: question.text!, answer1: wrongAnswerOne.text!, answer2: wrongAnswerTwo.text!, answer3: wrongAnswerThree.text!, rightAnswer: correctAnswer.text!)
            //Add a success label and shake
            successLabel.text = "Question added to DB Successfully!"
            successLabel.shake()
            
            //Get notification settings for user and request them if needed
            UNUserNotificationCenter.current().getNotificationSettings{
                notifS in
                switch notifS.authorizationStatus{
                case.notDetermined:
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){ granted, err in
                        if let error = err{
                            print("request failed", error)
                        }
                        self.generateNotification()
                    }
                    //If settings are authorized, create the notification
                case .authorized:
                    self.generateNotification()
                case .denied:
                    print("application not allowed")
                default:
                    print("")
                }
            }
        }
        //If the fields are empty, add an error label and shake
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
    

    
    @IBOutlet weak var technologyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Empty the success/error label of load
        successLabel.text = ""
        successLabel.adjustsFontSizeToFitWidth = true
        successLabel.textColor = .red

        technologyPicker.dataSource = self
        technologyPicker.delegate = self
        
        //Request authorization for notifications on load
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: { [self](granded, err) in
            self.notificationGranded = granded
        })
    }
   

}

//Completion handler is banner 
extension AdminCreateQuizViewController{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner])
    }
}
