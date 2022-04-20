//
//  MyCollectionViewController.swift
//  CollectionDemo
//
//  Created by admin on 3/22/22.
//

import UIKit
import SideMenu

//Class showing the three technology options as cells to take a quiz
class QuizCollectionViewController: UICollectionViewController, MenuControllerDelegate {
    
    let techNames = ["Swift", "Java", "Android", "Coming Soon"]
    let techImgs = ["swiftlogo", "javalogo", "androidlogo"]
    

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
    
    //Setup side menu
    override func viewDidLoad() {
        super.viewDidLoad()
        let menu = MenuController(with: views)
        menu.delegate = self
        sideMenu = menuCaller.displaySideMenu(sideMenu: sideMenu, menu: menu, view: view)
    }

  

    // MARK: UICollectionViewDataSource

    //Only one section in the collection view
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    
    //Three items for the three technologies
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    //Customize the cell for each item using array of tech names and images
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mcell", for: indexPath) as! QuizCollectionViewCell
        cell.mlb1.text = techNames[indexPath.row]
        cell.mlb1.tintColor = UIColor.black
        cell.img.image = UIImage(named: techImgs[indexPath.row])
    
        return cell
    }
    
    //When selecting an item in the collection, perform the quiz segue
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "quizSegue", sender: indexPath)
    }
    
    //Do some setup for the segue to next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "quizSegue"{
            if let locationIndex = sender as? NSIndexPath{
                
                let quizVC = segue.destination as? QuizViewController
                //Select a random integer to randomize which question is asked first
                quizVC?.pickQuestion = Int.random(in: 0...4)
                
                
                switch locationIndex.row{
                    
                    //If chose Swift technology, create quiz in that tech
                case 0:
                    quizVC?.quizChoice = db.createQuiz(technologyId: 1)
                    quizVC?.techChoice = 1
                    
                    //If chose Java technology
                case 1:
                    quizVC?.quizChoice = db.createQuiz(technologyId: 2)
                    quizVC?.techChoice = 2
                    
                    //If chose Android technology
                case 2:
                    quizVC?.quizChoice = db.createQuiz(technologyId: 3)
                    quizVC?.techChoice = 3
                default:
                    print("error")
                    
                }
            }
        }
            
        
    }

}
