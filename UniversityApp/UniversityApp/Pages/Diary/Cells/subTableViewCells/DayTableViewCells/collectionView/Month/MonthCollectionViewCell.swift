//
//  MonthCollectionViewCell.swift
//  UniversityApp
//
//  Created by Роман Макеев on 29.07.2018.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit

class MonthCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var view: UILabel!
    static let nibName = "MonthCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainView.backgroundColor = UIColor.init(red: 242.0/255, green: 242.0/255, blue: 242.0/255, alpha: 1)
        view.textColor
        = UIColor.init(red: 28.0/255, green: 28.0/255, blue: 28.0/255, alpha: 0.38)
        mainView.layer.cornerRadius = 15
    }
    override var isSelected: Bool{
        didSet{
            if isSelected {
                mainView.backgroundColor = UIColor.init(red: 255.0/255, green: 89.0/255, blue: 100.0/255, alpha: 1)
                view.textColor = UIColor.white
            } else {
                mainView.backgroundColor = UIColor.init(red: 242.0/255, green: 242.0/255, blue: 242.0/255, alpha: 1)
                view.textColor
                    = UIColor.init(red: 28.0/255, green: 28.0/255, blue: 28.0/255, alpha: 0.38)
                mainView.layer.cornerRadius = 15
            }
        }
    }

}
