//
//  DayCollectionViewCell.swift
//  UniversityApp
//
//  Created by Роман Макеев on 27.07.2018.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var week: UILabel!
    @IBOutlet weak var day: UILabel!
    static let nibName = "DayCollectionViewCell"
   var isActive = true
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if isActive{
        day.textColor = UIColor.init(red: 28.0/255, green: 28.0/255, blue: 28.0/255, alpha: 0.85)
        week.textColor = UIColor.init(red: 28.0/255, green: 28.0/255, blue: 28.0/255, alpha: 0.85)
        } else {
            day.textColor = UIColor.init(red: 28.0/255, green: 28.0/255, blue: 28.0/255, alpha: 0.16)
            week.textColor = UIColor.init(red: 28.0/255, green: 28.0/255, blue: 28.0/255, alpha: 0.16)
        }
    }
    
    override var isSelected: Bool {
        didSet{
        if isSelected {
            week.textColor = UIColor.init(red: 255.0/255, green: 89.0/255, blue: 100.0/255, alpha: 1)
            day.textColor = UIColor.init(red: 255.0/255, green: 89.0/255, blue: 100.0/255, alpha: 1)
        } else if isActive{
            day.textColor = UIColor.init(red: 28.0/255, green: 28.0/255, blue: 28.0/255, alpha: 0.85)
            week.textColor = UIColor.init(red: 28.0/255, green: 28.0/255, blue: 28.0/255, alpha: 0.85)
        } else {
            day.textColor = UIColor.init(red: 28.0/255, green: 28.0/255, blue: 28.0/255, alpha: 0.16)
            week.textColor = UIColor.init(red: 28.0/255, green: 28.0/255, blue: 28.0/255, alpha: 0.16)
            }
        }
    }
    

}
