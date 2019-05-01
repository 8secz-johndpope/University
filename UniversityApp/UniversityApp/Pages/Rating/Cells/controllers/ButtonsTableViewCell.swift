//
//  ButtonsTableViewCell.swift
//  UniversityApp
//
//  Created by Роман Макеев on 26.07.2018.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit

protocol ButtonsTableViewCellDelegate : class {
    func loadFirstData()
    func loadSecondData()
}


class ButtonsTableViewCell: UITableViewCell {

    
    let selectedColor = UIColor.init(red: 255/255, green: 89/255, blue: 100/255, alpha: 1)
    let disableColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
    
    
    
    weak var delegate : ButtonsTableViewCellDelegate?
    
    @IBOutlet weak var btn1: UIButton!
    
    @IBOutlet weak var btn2: UIButton!
    
    @IBAction func btn1(_ sender: UIButton) {
        btn1.backgroundColor = selectedColor
        btn2.backgroundColor = disableColor
       // btn1.titleLabel?.textColor = UIColor.white
        btn1.setTitleColor(UIColor.white, for: .normal)
        btn2.setTitleColor(UIColor.init(red: 28/255, green: 28/255, blue: 28/255, alpha: 0.38), for: .normal)
        self.delegate?.loadFirstData()
    }
    @IBAction func btn2(_ sender: UIButton) {
        btn2.backgroundColor = selectedColor
        btn1.backgroundColor = disableColor
       // btn2.titleLabel?.textColor = UIColor.white
        btn2.setTitleColor(UIColor.white, for: .normal)
        btn1.setTitleColor(UIColor.init(red: 28/255, green: 28/255, blue: 28/255, alpha: 0.38), for: .normal)
        self.delegate?.loadSecondData()
    }
    static let nibName = "ButtonsTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btn1.layer.cornerRadius = 15
        btn2.layer.cornerRadius = 15
        btn2.titleLabel?.textColor = UIColor.init(red: 28/255, green: 28/255, blue: 28/255, alpha: 0.38)
        btn1.titleLabel?.textColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
