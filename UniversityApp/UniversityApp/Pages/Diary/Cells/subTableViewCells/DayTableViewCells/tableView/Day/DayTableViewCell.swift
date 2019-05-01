//
//  DayTableViewCell.swift
//  UniversityApp
//
//  Created by Роман Макеев on 27.07.2018.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit


protocol DayTableViewCellDelegate : class {
    func reload()
}
protocol DayTableViewCellDelegate2 : class {
    func select(section: Int)
}

protocol  DayTableViewCellDelegate3 : class {
    func loadData(weekDay: String)
}

class DayTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, MonthTableViewCellDelegate, subViewDelegate {
    
    
    
    weak var delegate3 : DayTableViewCellDelegate3?
    var selectSection = false
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var colView: UICollectionView!
    
    let date = dateDataProvider()
    var month = 0
    var day = 0
    var selectedItem = 19
    weak var delegate2  : DayTableViewCellDelegate2?
    weak var delegate : DayTableViewCellDelegate?
    static let nibName = "DayTableViewCell"
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        registCell()
        date.getDate()
        colView.delegate = self
        colView.dataSource = self
        colView.showsHorizontalScrollIndicator = false
        day = date.today[1] - 1
        month = date.today[0] - 1
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 15
        
    }
    
    func viewDidLayoutSubviews(){
        
       // colView.selectItem(at: IndexPath.init(item: 20, section: 0), animated: false, scrollPosition: .left)
    }
    
    
    func select(section: Int) {
         fisrtupdate = false
        //colView.deselectItem(at: colView.indexPathsForSelectedItems![0], animated: true)
        
        colView.selectItem(at: IndexPath.init(item: 0, section: section), animated: true, scrollPosition: .centeredHorizontally)
        day = colView.indexPathsForSelectedItems![0].item
        month = colView.indexPathsForSelectedItems![0].section
        print(colView.indexPathsForSelectedItems![0].section)
        selectSection = true
        //colView.scrollToItem(at: colView.indexPathsForSelectedItems![0], at: .centeredHorizontally, animated: true)
       
      
    }
    
    
    func set() {
        let cell = colView.cellForItem(at: colView.indexPathsForSelectedItems![0]) as! DayCollectionViewCell
        cell.isSelected = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("yaBoy")
        print(indexPath.item)
        print("Загрузка данных selected")
        
        print(indexPath.item)
        if colView.indexPathsForSelectedItems![0].section != month {
            print("FFFFDJKVdsjbvhsbdchdsbhvcsd")
            delegate2?.select(section: colView.indexPathsForSelectedItems![0].section)
        }
        day = colView.indexPathsForSelectedItems![0].item
        month = colView.indexPathsForSelectedItems![0].section
        delegate3?.loadData(weekDay: date.getWeek(month: colView.indexPathsForSelectedItems![0].section + 1, day: colView.indexPathsForSelectedItems![0].item  + 1))
        print(date.getWeek(month: self.month - 1, day: self.day - 1))
        print(colView.indexPathsForSelectedItems![0].section)
        print("Selected fff \(colView.indexPathsForSelectedItems![0].section + 1)")
        secondUpadate = true
       // selectedItem = indexPath.row
       colView.scrollToItem(at: colView.indexPathsForSelectedItems![0], at: .centeredHorizontally, animated: true)
        fisrtupdate = false
    }
    
    /*
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //colView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        if let cell = colView.cellForItem(at: colView.indexPathsForSelectedItems![0]) as? DayCollectionViewCell{
            print("yay")
            cell.day.textColor = UIColor.red
            cell.week.textColor = UIColor.red
            //colView.reloadData()
            //delegate?.reload()
        }
    }
 */
    /*
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = colView.cellForItem(at: indexPath) as? DayCollectionViewCell{
            print("ага")
            cell.day.textColor = UIColor.black
            cell.week.textColor = UIColor.black
            //colView.reloadData()
            delegate?.reload()
        }
    }
 */

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return date.daysInMonth[section]
        case 1:
            return date.daysInMonth[section]
        case 2:
            return date.daysInMonth[section]
        case 3:
            return date.daysInMonth[section]
        case 4:
            return date.daysInMonth[section]
        case 5:
            return date.daysInMonth[section]
        case 6:
            return date.daysInMonth[section]
        case 7:
            return date.daysInMonth[section]
        case 8:
            return date.daysInMonth[section]
        case 9:
            return date.daysInMonth[section]
        case 10:
            return date.daysInMonth[section]
        case 11:
            return date.daysInMonth[section]
        default:
            return 0
        }
    }
    
    var firstLoad = true
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colView.dequeueReusableCell(withReuseIdentifier: DayCollectionViewCell.nibName, for: indexPath) as! DayCollectionViewCell
        //print(indexPath.item)
        cell.week.text = date.getWeek(month: indexPath.section + 1, day: indexPath.item + 1)
        if (indexPath.section < date.today[0] - 1 ) || (indexPath.section == date.today[0] - 1  && indexPath.item < date.today[1] - 1) {
            
            cell.isActive = false
            cell.day.textColor = UIColor.init(red: 28.0/255, green: 28.0/255, blue: 28.0/255, alpha: 0.16)
            cell.week.textColor = UIColor.init(red: 28.0/255, green: 28.0/255, blue: 28.0/255, alpha: 0.16)
        } else {
            cell.isActive = true
            cell.day.textColor = UIColor.init(red: 28.0/255, green: 28.0/255, blue: 28.0/255, alpha: 0.85)
            cell.week.textColor = UIColor.init(red: 28.0/255, green: 28.0/255, blue: 28.0/255, alpha: 0.85)
        }
        
        if indexPath.item == date.today[1] - 1 && indexPath.section == date.today[0] - 1 && firstLoad {
            cell.isSelected = true
            colView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            print("Загрузка данных first")
            delegate3?.loadData(weekDay: date.getWeek(month: colView.indexPathsForSelectedItems![0].section + 1, day: colView.indexPathsForSelectedItems![0].item + 1 ))
            firstLoad = false
        }
        if selectSection && indexPath.item == 0 && indexPath.section == month{
            cell.isSelected = true
            print("Загрузка данных second")
            delegate3?.loadData(weekDay: date.getWeek(month: colView.indexPathsForSelectedItems![0].section + 1 , day: colView.indexPathsForSelectedItems![0].item + 1 ))
            selectSection = false
        }
        cell.day.text = "\(indexPath.row + 1)"
        return cell
    }
    
    
    
    func registCell(){
        colView.register(UINib(nibName: DayCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: DayCollectionViewCell.nibName)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x  = scrollView.contentOffset.x
       // print("x \(x)")
        
        if (fisrtupdate){
            
            //colView.selectItem(at: colView.indexPath(for: colView.visibleCells[colView.visibleCells.count/2 + 1] ) , animated: true, scrollPosition: .centeredHorizontally)
            var iterators =  colView.indexPathsForVisibleItems
            iterators.sort()
            let iterator = iterators[colView.visibleCells.count/2]
            
            
            let cell = colView.cellForItem(at: iterator) as! DayCollectionViewCell
            
            
            
            
            colView.selectItem(at: iterator, animated: false, scrollPosition: UICollectionViewScrollPosition(rawValue: 0))
            if colView.indexPathsForSelectedItems![0].section != month {
                
                delegate2?.select(section: colView.indexPathsForSelectedItems![0].section)
            }
            day = colView.indexPathsForSelectedItems![0].item
            month = colView.indexPathsForSelectedItems![0].section
           
 
        }
        
        
    }
    
    
   
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        fisrtupdate = true
        //dragging = true
        
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (!decelerate){
        colView.selectItem(at: colView.indexPathsForSelectedItems![0], animated: true, scrollPosition: .centeredHorizontally)
        if colView.indexPathsForSelectedItems![0].section != month {
            
            delegate2?.select(section: colView.indexPathsForSelectedItems![0].section)
        }
        day = colView.indexPathsForSelectedItems![0].item
        month = colView.indexPathsForSelectedItems![0].section
        print("Загрузка данных DIDDragging")
            delegate3?.loadData(weekDay: date.getWeek(month: colView.indexPathsForSelectedItems![0].section + 1 , day: colView.indexPathsForSelectedItems![0].item + 1 ))
        secondUpadate = true
        
        fisrtupdate = true
        }
        
    }
    var fisrtupdate = false
    var secondUpadate = true
    var scrollCount = 0
    
    
    var dragging = false
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
        dragging = false
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        colView.selectItem(at: colView.indexPathsForSelectedItems![0], animated: true, scrollPosition: .centeredHorizontally)
        if colView.indexPathsForSelectedItems![0].section != month {
            
            delegate2?.select(section: colView.indexPathsForSelectedItems![0].section)
        }
        day = colView.indexPathsForSelectedItems![0].item
        month = colView.indexPathsForSelectedItems![0].section
        print("Загрузка данных ENDDecelerating")
        delegate3?.loadData(weekDay: date.getWeek(month: colView.indexPathsForSelectedItems![0].section + 1 , day: colView.indexPathsForSelectedItems![0].item + 1 ))
        secondUpadate = true
        dragging = true
        fisrtupdate = true
 
    }
    
    
    
    
}
