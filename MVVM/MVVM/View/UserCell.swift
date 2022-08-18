//
//  UserCell.swift
//  MVVM
//
//  Created by Nitin Bhatt on 2/12/22.
//

import Foundation
import UIKit

class UserCellTableViewCell : UITableViewCell{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    class var identifier:String{ return String(describing: self) }
    class var nib:UINib{ return UINib(nibName: identifier, bundle: nil)}
    
    var cellViewModel : UserCellViewModel?{
        didSet{
            nameLabel.text = cellViewModel?.name
            emailLabel.text = cellViewModel?.email
            genderLabel.text = cellViewModel?.gender
        }
    }
    
    override func awakeFromNib(){
        super.awakeFromNib()
        initView()
    }
    
    func initView(){
        backgroundColor = .clear
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        emailLabel.text = nil
        genderLabel.text = nil
    }
}
