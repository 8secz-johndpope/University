//
//  DirectionTableViewCell.swift
//  UniversityApp
//
//  Created by 1 on 20.08.18.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit

class DirectionTableViewCell: UITableViewCell {
    @IBOutlet weak var DirectionLbl: UILabel!
    static let nibName = "DirectionTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
