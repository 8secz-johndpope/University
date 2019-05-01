//
//  CurrentTableViewCell.swift
//  UniversityApp
//
//  Created by Роман Макеев on 08.08.2018.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit
protocol CurrentTableViewCellDelegate : class {
    func deleteCell(cell : CurrentTableViewCell)
}

class CurrentTableViewCell: UITableViewCell {

    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    weak var delegate : CurrentTableViewCellDelegate?
    static let nibName =  "CurrentTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteBtn(_ sender: UIButton) {
       delegate?.deleteCell(cell: self)
    }
}
