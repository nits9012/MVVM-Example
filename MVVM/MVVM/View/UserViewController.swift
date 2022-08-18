//
//  UserViewController.swift
//  MVVM
//
//  Created by Nitin Bhatt on 2/13/22.
//

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel = {
        UserViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UsersCell.nib, forCellReuseIdentifier: UsersCell.identifier)
        
        initViewModel()
    }
    
    func initViewModel(){
        viewModel.getUsers(completion: {isSuccess,errorMessage in
            if isSuccess == false{
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        })
        
        viewModel.reloadTableView = { [self] in
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userCellViewModels.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersCell.identifier, for: indexPath) as? UsersCell else{
            fatalError("xib does not exists")
        }
        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellViewModel
        
        return cell
    }
}
