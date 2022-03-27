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
    @IBOutlet weak var blockButton: UIButton!
    @IBOutlet weak var subDate: UILabel!
    
//    var subscribedDate : Date?
//    var currentDate : Date?
//    var subscribedDate = Date("2014-05-20")
    var userName: String?
    var blockedStatus = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        subDate.text = String(db.getEnd(userId: userID!))
        user.text = userName!
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
    
    override func viewDidLayoutSubviews() {
        if(blockedStatus == 1){
            blockButton.setTitle("unblock", for: .normal)
        }else if (blockedStatus == 0){
            blockButton.setTitle("block", for: .normal)
        }
    }
    @IBAction func blockUser(_ sender: Any) {
        if(db.getBlockStatus(userID: db.getUserID(userName: userName!)) == 1){
            blockedStatus = 0
            db.updateBlockFalse(userID: db.getUserID(userName: userName!))
            blockButton.setTitle("block", for: .normal)
        } else if (db.getBlockStatus(userID: db.getUserID(userName: userName!)) == 0){
            blockedStatus = 1
            db.updateBlockTrue(userID: db.getUserID(userName: userName!))
            blockButton.setTitle("unblock", for: .normal)
        }
        //print(db.getBlockStatus(userID: db.getUserID(userName: userName!)))
    }
    
}
