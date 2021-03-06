//
//  SideMenu.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/24/22.
//

import Foundation
import UIKit

/// Delegate tells viewcontroller what was tapped on to change contents
protocol MenuControllerDelegate{
    func didSelectMenuItem(named: String)
}


/// Controller holds table view in it and shows list of items in side menu
class MenuController: UITableViewController{
    
    public var delegate: MenuControllerDelegate?
    private let color = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
    private let menuItems: [String]
    
    /// Custom initializer to initialize menu with content
    init(with menuItems: [String]){
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    /// Initializer handler for init optional
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///  Loads color of table view in side menu
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = color
        view.backgroundColor = color
    }
    
    /// Defines  number of table view rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    /// Returns the cell and its properties in the rows
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = color
        cell.contentView.backgroundColor = color
        return cell
    }
    
    /// Handles selection of row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        //relay to delegate about menu item selection
        let selectedItem = menuItems[indexPath.row]
        if selectedItem == "Quizzes" && quizzesLeft == 0{
            print("No quizzes left today")
        }
        else{
            delegate?.didSelectMenuItem(named: selectedItem)
        }
    }
}

