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
    
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var quizName: UITextField!
    @IBOutlet weak var question: UITextField!
    @IBOutlet weak var wrongAnswerOne: UITextField!
    @IBOutlet weak var wrongAnswerTwo: UITextField!
    @IBOutlet weak var wrongAnswerThree: UITextField!
    @IBOutlet weak var correctAnswer: UITextField!
    var pickedTechnology : Int = 1
    
    
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
                print("didn't gimme da loot", error)
            }
        }
    }
    
    @IBAction func submitQuestion(_ sender: Any) {
        print(pickedTechnology)
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
                case .authorized:
                    self.generateNotification()
                case .denied:
                    print("application not allowed")
                default:
                    print("")
                }
            }
            
            
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
    

    
    @IBOutlet weak var technologyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        successLabel.text = ""
        successLabel.adjustsFontSizeToFitWidth = true
        successLabel.textColor = .red

        technologyPicker.dataSource = self
        technologyPicker.delegate = self
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: { [self](granded, err) in
            self.notificationGranded = granded
            print("inside notificaiton")
            print(self.notificationGranded)
        })
        print("outside notificaiton")
        print(self.notificationGranded)
    }
   

}


extension AdminCreateQuizViewController{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner])
    }
}
