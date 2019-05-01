//
//  GroupsTableViewCell.swift
//  UniversityApp
//
//  Created by 1 on 20.08.18.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {

    static let nibName = "GroupsTableViewCell"
    @IBOutlet weak var grouplabels: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
