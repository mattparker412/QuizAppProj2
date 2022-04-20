//
//  QuizPageViewController.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/17/22.
//

import UIKit

///This class is never used
class QuizPageViewController: UIViewController {

//    @IBOutlet weak var remainingTime: UILabel!
//    var isSubmitted = false
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//
//    let clock = Clock()
//    @IBAction func startTimer(_ sender: UIButton) {
//        print("button pressed")
//        var time = 1800
//        var minutes : String?
//        var seconds : String?
//        var fullTime : String?
//        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
//            if time > 0 {
//                var display = (time / 3600, (time % 3600) / 60, (time % 3600) % 60)
//                minutes = String(display.1)
//                seconds = String(display.2)
//                fullTime = "\(minutes!):\(seconds!)"
//                self.remainingTime.text = fullTime!
//                time -= 1
//            } else {
//                Timer.invalidate()
//            }
//        }
//    }
//
//
//    @IBAction func submitQuiz(_ sender: Any) {
//        isSubmitted = true
//    }
//
//
//    @IBAction func viewRanking(_ sender: Any) {
//        if(isSubmitted == true){
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "rankingPage") as! RankingViewController
//            //self.navigationController?.pushViewController(nextViewController, animated: true)
//            self.present(nextViewController, animated:false, completion: nil)
//        } else{
//            print("quiz not submitted")
//        }
//    }
//
}
