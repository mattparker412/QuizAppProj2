//
//  RankingViewController.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/18/22.
//

import UIKit
import SideMenu

//Rankings view
class RankingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, MenuControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    //List of tech names and arrays to store the rankings
    var techs = ["Swift","Java","Android"]
    var swiftArray = [Ranking]()
    var androidArray = [Ranking]()
    var javaArray = [Ranking]()
    
    //Height for header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    //Number of sections, one for each tech
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    //Title for each header taken from techs array
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return techs[section]
    }
    
    //Number of rows in each should be the number of rankings in each array
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

    //Don't allow selection of rows
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Set up the content for each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RankingTableViewCell
        cell.leftLabel.textColor = .link
        cell.rightLabel.textColor = .link
        switch indexPath.section{
            //Label the cell with number ranking and username on left
            //Rankscore on right
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
    
    //Side menu functionality
    private var sideMenu: SideMenuNavigationController?
    let views = ["MyAccount","Subscription","Quizzes","Feedback","Ranking","Logout"]
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
    
    //Setup side menu and get top rankings for each tech
    override func viewDidLoad() {
        super.viewDidLoad()
        let menu = MenuController(with: views)
        
        menu.delegate = self
        sideMenu = menuCaller.displaySideMenu(sideMenu: sideMenu, menu: menu, view: view)
        
        //Get top rankings from database for each tech
        swiftArray = db.getTopRanking(techID: 1)
        javaArray = db.getTopRanking(techID: 2)
        androidArray = db.getTopRanking(techID: 3)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    
}


