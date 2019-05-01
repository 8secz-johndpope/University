//
//  MonthTableViewCell.swift
//  UniversityApp
//
//  Created by Роман Макеев on 29.07.2018.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit

protocol MonthTableViewCellDelegate : class {
    func select(section : Int)
}




class MonthTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, DayTableViewCellDelegate2 {
   
    
    func select(section: Int) {
        colView.selectItem(at: IndexPath.init(row: section, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        currentMonth = colView.indexPathsForSelectedItems![0].item
    }
    
    let date = dateDataProvider()
    
    var currentMonth = 6
    
    static let nibName = "MonthTableViewCell"
    
    @IBOutlet weak var colView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        colView.delegate = self
        colView.dataSource = self
        colView.showsHorizontalScrollIndicator = false
        date.getDate()
        currentMonth = date.today[0] - 1
        
        register()
        
        // Initialization code
    }

    weak var delegate : MonthTableViewCellDelegate?
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

        // Configure the view for the selected state
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.select(section: indexPath.item)
        colView.scrollToItem(at: colView.indexPathsForSelectedItems![0], at: .centeredHorizontally, animated: true)
         currentMonth = colView.indexPathsForSelectedItems![0].item
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colView.dequeueReusableCell(withReuseIdentifier: MonthCollectionViewCell.nibName, for: indexPath) as! MonthCollectionViewCell
        switch indexPath.item {
        case 0:
            cell.view.text = "Январь"
        case 1:
            cell.view.text = "Февраль"
        case 2:
            cell.view.text = "Март"
        case 3:
            cell.view.text = "Апрель"
        case 4:
            cell.view.text = "Май"
        case 5:
            cell.view.text = "Июнь"
        case 6:
            cell.view.text = "Июль"
        case 7:
            cell.view.text = "Август"
        case 8:
            cell.view.text = "Сентябрь"
        case 9:
            cell.view.text = "Октябрь"
        case 10:
            cell.view.text = "Ноябрь"
        case 11:
            cell.view.text = "Декабрь"
        default:
            cell.view.text = "none"
        }
        return cell
    }
    
    
    func register(){
        colView.register(UINib(nibName: MonthCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: MonthCollectionViewCell.nibName)
    }
    
}
