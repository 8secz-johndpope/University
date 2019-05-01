//
//  AllArticlesTableViewCell.swift
//  UniversityApp
//
//  Created by Роман Макеев on 24.07.2018.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit
import Hero
import Kingfisher

class AllArticlesTableViewCell: UITableViewCell {

   
    @IBOutlet weak var cellDate: UILabel!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var articelImageViewCell: UIImageView!
    static let nibName = "AllArticlesTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //articelImageViewCell.hero.id = "img"
        //mainView.hero.id = "view"
        
        // Initialization code
    }
    
    func customizeCell(id : String, model : NewsModel){
        articelImageViewCell.hero.id = "img" + id
        mainView.hero.id = "view" + id
        cellDate.hero.id = "date" + id
        cellTitle.hero.id = "title" + id
        cellTitle.text = model.title
        cellDate.text = model.date
        let resourse = ImageResource(downloadURL: URL(string: model.img)!, cacheKey: "\(id)img")
        articelImageViewCell.kf.setImage(with: resourse)
       // articelImageViewCell.frame.size.width = cellTitle.bounds.width
        
        
        articelImageViewCell.contentMode = UIViewContentMode.scaleAspectFill
        articelImageViewCell.clipsToBounds = true
        articelImageViewCell.layer.cornerRadius = 15
        //articelImageViewCell.contentMode = UIViewContentMode.scaleAspectFit
        print(articelImageViewCell.bounds.width)
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
