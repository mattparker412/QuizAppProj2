//
//  AdminAllUsersViewController.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/20/22.
//

import UIKit

/// Displays list of users in table view for admin to see
class AdminAllUsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    private let dataFetcher = DataFetcher()
    private var data = [String]()
    var user: String?
    
    /// Defines number of data in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    /// Returns the specific cell value in a row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for : indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.backgroundColor = UIColor(red: 0/255, green: 117/255, blue: 227/255, alpha: 1)
        return cell
    }
    /// If a row is selected navigate to user info page and populate data in page with this specific user's data
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow //optional, to get from any UIButton for example
        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
        user = currentCell.textLabel!.text
        self.performSegue(withIdentifier: "toUserInfo", sender: self)
    }
    /**
        Spinner animation in footer when loading data
     */
    private func createSpinnerFooter() -> UIView{
        let footerView = UIView(frame: CGRect(x:0,y:0, width: view.frame.size.width, height:100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    /**
            Updates view whenever pagination and data fetching  ends
     */
    override func viewDidLayoutSubviews() {
        var callCount = 0
        tableView.frame = view.bounds
        if callCount < 1{
            callCount += 1
            dataFetcher.fetchData(pagination: false, completion: {[weak self] result in switch result{
                    case .success(let data):
                        self?.data.append(contentsOf: data)
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                    case .failure(_):
                        break
                    }
            })
        }
    }
    /// Section header height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    /// Section header title
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "User List"
    }
    /// Defines table view
    private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0/255, green: 117/255, blue: 227/255, alpha: 1)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.delegate = self
    }
    /**
                Determines if the view has been scrolled down to a specific height. If it is, then begin fetching data and paginating
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height){
            guard !dataFetcher.isPaginating else {
                //data being fetched already
                return
            }
            self.tableView.tableFooterView = createSpinnerFooter()
            dataFetcher.fetchData(pagination: true){[weak self] result in
                DispatchQueue.main.async {
                    self?.tableView.tableFooterView = nil
                }
                switch result{
                case .success(let newData):
                    self?.data.append(contentsOf: newData)
                    DispatchQueue.main.async{
                        self?.tableView.reloadData()
                    }
                case .failure(_):
                    break
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let svc = segue.destination as!  UserInfoViewController
        print("user again")
        print(user!)
        svc.username = user
    }
}


