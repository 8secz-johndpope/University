//
//  ViewFacultetTableViewCell.swift
//  UniversityApp
//
//  Created by 1 on 27.07.18.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit

class ViewFacultetTableViewCell: UITableViewCell {
    static let nibName = "ViewFacultetTableViewCell"

    @IBOutlet weak var viewfacultLbl: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
