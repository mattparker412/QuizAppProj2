//
//  RankingViewController.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/18/22.
//

import UIKit
import SideMenu





class RankingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, MenuControllerDelegate {
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    //all the in the arrays is supposed to be queried from the database
//    var scores = [["10000","15000","14000","13000","12050","12510","11051","13775","11200","10501"],["2100","2050","2007","2001","2010","2200","2300","2400","2600","2800",],["3100","3200","3300","3400","3500","3700","370","3650","33651","3100"]]
//    var users = [["user1","user3","user2","user12","user11","user4","user10","user9","user14","user7"],["user8","user9","user1","user12","user22","user21","user4","user3","user2","user6",],["user3","user6","user8","user11","user7","user20","user5","user9","user16","user17"]]
//
//    var data = [["user1 10000","user3 15000","user2 14000","user12 13000","user11 12050","user7 12510","user4 11051","user10 13775","user9 11200","user14 10501"],["user8 2100","2","2","2","2","2","2","2","2","2",],["user3 3100","3","3","3","3","3","3","3","3","3"]]
    var techs = ["Swift","Java","Android"]
    var swiftArray = [Ranking]()
    var androidArray = [Ranking]()
    var javaArray = [Ranking]()
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
        switch section{
        case 0:
            return swiftArray.count
        case 1:
            return javaArray.count
        case 2:
            return androidArray.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RankingTableViewCell
        cell.leftLabel.textColor = .link
        cell.rightLabel.textColor = .link
        switch indexPath.section{
        case 0:
            cell.leftLabel.text = "\(indexPath.row + 1). \t  \(swiftArray[indexPath.row].userName!)"
            cell.rightLabel.text = "Score: \(swiftArray[indexPath.row].ranking)"
        case 1:
            cell.leftLabel.text = "\(indexPath.row + 1). \t  \(javaArray[indexPath.row].userName!)"
            cell.rightLabel.text = "Score: \(javaArray[indexPath.row].ranking)"
        case 2:
            cell.leftLabel.text = "\(indexPath.row + 1). \t  \(androidArray[indexPath.row].userName!)"
            cell.rightLabel.text = "Score: \(androidArray[indexPath.row].ranking)"
        default:
            print("do nothing")
        }
        cell.backgroundColor = .systemGray5
        return cell
    }
    
    private var sideMenu: SideMenuNavigationController?
    let views = ["Subscription","Quizzes","Feedback","Ranking","Logout"]
    let menuCaller = CreateSideMenu()
    
    @IBAction func didTapMenu(){
        present(sideMenu!, animated: true)
    }

    let navigator = NavigateToController()
    func didSelectMenuItem(named: String) {
        sideMenu?.dismiss(animated: true, completion: { [weak self] in
            
            var controllerToNav = self?.navigator.viewControllerSwitch(named: named)
            self?.navigator.navToController(current: self!, storyboard: controllerToNav![0] as! String, identifier: controllerToNav![1] as! String, controller: controllerToNav![2] as! UIViewController)

        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menu = MenuController(with: views)
        
        menu.delegate = self
        sideMenu = menuCaller.displaySideMenu(sideMenu: sideMenu, menu: menu, view: view)
        // Do any additional setup after loading the view.
        swiftArray = db.getTopRanking(techID: 1)
        javaArray = db.getTopRanking(techID: 2)
        androidArray = db.getTopRanking(techID: 3)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    
}


