//
//  UserInfoViewController.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/24/22.
//

import UIKit

class UserInfoViewController: UIViewController {
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var swiftScore: UILabel!
    @IBOutlet weak var iOSScore: UILabel!
    @IBOutlet weak var androidScore: UILabel!
    @IBOutlet weak var averageScore: UILabel!
    var userName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        user.text = userName!
        print("user 3")
        print(userName)
        // Do any additional setup after loading the view.
        let scores = (db.getTotalScoreForUser(userName: userName!))
        swiftScore.text = String(scores[0])
        iOSScore.text = String(scores[1])
        androidScore.text = String(scores[2])
        var sumScores = 0
        for score in 0..<scores.count{
            sumScores += scores[score]
        }
        averageScore.text = String(sumScores/3)
    }
    
    @IBAction func blockUser(_ sender: Any) {
        print("block pressed")
    }
    
}
