//
//  MyCollectionViewController.swift
//  CollectionDemo
//
//  Created by admin on 3/22/22.
//

import UIKit
import SideMenu


class QuizCollectionViewController: UICollectionViewController, MenuControllerDelegate {
    
    let techNames = ["Swift", "Java", "Android", "Coming Soon"]
    let techImgs = ["swiftlogo", "javalogo", "androidlogo"]
    var userID : Int? = Int.random(in: 1...1000)
    var db = DBHelper()
    

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menu = MenuController(with: views)
        menu.delegate = self
        sideMenu = menuCaller.displaySideMenu(sideMenu: sideMenu, menu: menu, view: view)
        db.connect()

    }

  

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mcell", for: indexPath) as! QuizCollectionViewCell
        cell.mlb1.text = techNames[indexPath.row]
        cell.mlb1.tintColor = UIColor.black
        cell.img.image = UIImage(named: techImgs[indexPath.row])
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "quizSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quizSegue"{
            if let locationIndex = sender as? NSIndexPath{
                let quizVC = segue.destination as? QuizViewController
                quizVC?.pickQuestion = Int.random(in: 0...4)
                
                
                switch locationIndex.row{
                case 0:
                    
                    quizVC?.quizChoice = db.createQuiz(technologyId: 1)
                    
                    quizVC?.techChoice = 1
                    //quizVC?.view.backgroundColor = UIColor.red
                case 1:
                    quizVC?.quizChoice = db.createQuiz(technologyId: 2)
                    quizVC?.techChoice = 2
                    //quizVC?.view.backgroundColor = UIColor.blue
                case 2:
                    quizVC?.quizChoice = db.createQuiz(technologyId: 3)
                    quizVC?.techChoice = 3
                   // quizVC?.view.backgroundColor = UIColor.green
                default:
                    print("error")
                    
                }
            }
        }
            
        
    }

}
