//
//  FacultetTableViewCell.swift
//  UniversityApp
//
//  Created by 1 on 02.08.18.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit

class FacultetTableViewCell: UITableViewCell {

    static let nibName = "FacultetTableViewCell"
    
    @IBOutlet weak var facultLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
