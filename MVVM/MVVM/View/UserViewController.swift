//
//  UserViewController.swift
//  MVVM
//
//  Created by Nitin Bhatt on 2/13/22.
//

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserCellTableViewCell.nib, forCellReuseIdentifier: UserCellTableViewCell.identifier)
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCellTableViewCell.identifier) as? UserCellTableViewCell else{
            fatalError("nib does not exists")
        }
        
        return cell
    }
}
