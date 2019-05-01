//
//  subjectTableViewCell.swift
//  UniversityApp
//
//  Created by Роман Макеев on 27.07.2018.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit

class subjectTableViewCell: UITableViewCell {

    
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    static let nibName = "subjectTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
