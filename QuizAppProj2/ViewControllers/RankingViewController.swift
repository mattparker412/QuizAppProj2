//
//  RankingViewController.swift
//  QuizAppProj2
//
//  Created by John Figueroa on 3/18/22.
//

import UIKit

class RankingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    
    private let dataFetcher = DataFetcher()
    private var data = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for : indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    private func createSpinnerFooter() -> UIView{
        let footerView = UIView(frame: CGRect(x:0,y:0, width: view.frame.size.width, height:100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        dataFetcher.fetchData(completion: {[weak self] result in switch result{
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

    //creates tableview
    private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(tableView)
        tableView.dataSource = self

        //implement tableviews delegate
        tableView.delegate = self
    }

    
// When scrolling down too quickly, it seems like program gets malloc errors. need to debuk/error check this later
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height - 100 - scrollView.frame.size.height{
            guard !dataFetcher.isPaginating else {
                //data being fetched already
                return
            }
            self.tableView.tableFooterView = createSpinnerFooter()
            dataFetcher.fetchData(pagination: true, completion: {[weak self] result in
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
            })
        }
    }
}


