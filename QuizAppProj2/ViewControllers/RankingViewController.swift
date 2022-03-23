//
//  RankingViewController.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/18/22.
//

import UIKit

class RankingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    //all the in the arrays is supposed to be queried from the database
    var scores = [["10000","15000","14000","13000","12050","12510","11051","13775","11200","10501"],["2100","2050","2007","2001","2010","2200","2300","2400","2600","2800",],["3100","3200","3300","3400","3500","3700","370","3650","33651","3100"]]
    var users = [["user1","user3","user2","user12","user11","user4","user10","user9","user14","user7"],["user8","user9","user1","user12","user22","user21","user4","user3","user2","user6",],["user3","user6","user8","user11","user7","user20","user5","user9","user16","user17"]]
    
    var data = [["user1 10000","user3 15000","user2 14000","user12 13000","user11 12050","user7 12510","user4 11051","user10 13775","user9 11200","user14 10501"],["user8 2100","2","2","2","2","2","2","2","2","2",],["user3 3100","3","3","3","3","3","3","3","3","3"]]
    var techs = ["Swift","Android","iOS"]
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return techs[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row]
        cell.backgroundColor = .systemGray4
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        print(users[0][0])
    }
    
    
    
}


