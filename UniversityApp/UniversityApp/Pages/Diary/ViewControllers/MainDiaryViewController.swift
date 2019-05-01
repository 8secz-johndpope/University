//
//  MainDiaryViewController.swift
//  UniversityApp
//
//  Created by Роман Макеев on 27.07.2018.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol subViewDelegate : class {
    func set()
}

class MainDiaryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DayTableViewCellDelegate, DiaryDataProviderDelegate, DayTableViewCellDelegate3 {
    
    var number = 0
    func loadData(weekDay: String) {
        self.activityIndicator.startAnimating()
        number = 0
        mainTableView.reloadData()
        var week = ""
        print("Here \(weekDay)")
        switch weekDay {
        case "пн":
            week = "Monday"
        case "вт":
            week = "Thuesday"
        case "ср":
            week = "Wensday"
        case "чт":
            week = "Thursday"
        case "пт":
            week = "Friday"
        case "сб":
            week = "Saturday"
        case "вс":
            week = "Sunday"
        default:
            week = ""
        }
        dataProvider.getData(weekDay: week)
    }
    
    func dataLoaded() {
      number = dataProvider.models.count
        print(dataProvider.models.count)
      mainTableView.reloadData()
        print("reload")
        self.activityIndicator.stopAnimating()
    }
    
    func reload() {
        print("reload")
        subTableView.reloadData()
    }
    
    var secondStart = CGFloat(0)
    var startPosition = CGFloat(0)
    

    @IBOutlet weak var height: NSLayoutConstraint!
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var viewTopContrant: NSLayoutConstraint!
    @IBOutlet weak var subTableView: UITableView!
    
    
    func setNavBar(){
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.title = "🗓 Расписание"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.9 )
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        firstnav = true
        if !firstupdate{
            
            if let cell = subTableView.cellForRow(at: IndexPath.init(item: 0, section: 0)) as? DayTableViewCell{
                cell.delegate3?.loadData(weekDay: cell.date.getWeek(month: cell.colView.indexPathsForSelectedItems![0].section + 1, day: cell.colView.indexPathsForSelectedItems![0].item + 1))
                print("HELACopter")
            }
            
        }
    }
    
    weak var delegate : subViewDelegate?
    var dataProvider = DiaryDataProvider()

    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    @IBOutlet weak var mainTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        view.addSubview(activityIndicator)
        registerCells()
        setNavBar()
        dataProvider.delegate = self
        //subView.clipsToBounds = true
        subView.backgroundColor = UIColor.clear
        subView.layer.cornerRadius = 15
        subView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        subTableView.backgroundColor = UIColor.white
        subTableView.layer.cornerRadius = 15
        subTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        subView.layer.masksToBounds = false
        subView.layer.shadowColor = UIColor.init(red: 28/255, green: 28/255, blue: 28/255, alpha: 0.16).cgColor
        subView.layer.shadowOpacity = 5
        subView.layer.shadowOffset = CGSize.zero
        subView.layer.shadowRadius = 5
        
        startPosition = subView.center.y
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(MainDiaryViewController.handlePan(recognizer:)))
        subView.addGestureRecognizer(pan)
        
        
        subTableView.showsVerticalScrollIndicator = false
        
        
        
        
        let dot = UIView(frame: CGRect(x: UIScreen.main.bounds.width/2.0 - 4,y: -4,width: 8,height: 8))
        dot.layer.cornerRadius = 4
        dot.clipsToBounds = true
        dot.backgroundColor = UIColor.init(red: 255/255.0, green: 89/255.0, blue: 100/255.0, alpha: 1)
        subView.addSubview(dot)
        
        //subView.layer.shadowPath = UIBezierPath(rect: subView.bounds).cgPath
        /*
        if let applicationDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate? {
            if let window:UIWindow = applicationDelegate.window {
                let someView:UIView = UIView(frame: UIScreen.main.bounds)
                someView.backgroundColor = UIColor.black.withAlphaComponent(0.75)
                window.addSubview(someView)
            }
        }
 */
        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var firstupdate = true
    override func viewDidLayoutSubviews() {
        
        if firstupdate{
        if let cell = subTableView.cellForRow(at: IndexPath.init(item: 0, section: 0)) as? DayTableViewCell{
            cell.delegate3 = self
        let index = cell.day
        let section = cell.month
        cell.colView.selectItem(at: IndexPath.init(item: index , section: section ), animated: true, scrollPosition: .centeredHorizontally)
        cell.delegate2 = subTableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! MonthTableViewCell
         //   cell.colView.scrollToItem(at: IndexPath.init(item: index, section: 0), at: .centeredHorizontally, animated: true)
        
        
            
        }
        if let cell = subTableView.cellForRow(at: IndexPath.init(item: 1, section: 0)) as? MonthTableViewCell {
            let index = cell.currentMonth
            cell.colView.selectItem(at: IndexPath.init(item: index, section: 0), animated: false, scrollPosition: .centeredHorizontally)
            cell.delegate = subTableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! DayTableViewCell
        }
            firstupdate = false
        }
    }
 
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == mainTableView {
            return number
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == mainTableView {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: subjectTableViewCell.nibName) as! subjectTableViewCell
            cell.nameLabel.text = dataProvider.models[indexPath.row].name
            cell.timeLabel.text = dataProvider.models[indexPath.row].time
            cell.teacherLabel.text = "\(dataProvider.models[indexPath.row].teacher) \n \(dataProvider.models[indexPath.row].room)"
            return cell}
        else if indexPath.row == 0 {
            let cell = subTableView.dequeueReusableCell(withIdentifier: DayTableViewCell.nibName) as! DayTableViewCell
            cell.layer.cornerRadius = 10
            cell.delegate = self
            delegate = cell

            return cell
        } else {
            let cell = subTableView.dequeueReusableCell(withIdentifier: MonthTableViewCell.nibName) as! MonthTableViewCell
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == mainTableView {
            return mainTableView.estimatedRowHeight
        } else {
            if indexPath.row == 0 {
                return 80
            } else {
                return 37
            }
        }
        
    }
    
 
    func registerCells(){
        mainTableView.register(UINib(nibName: subjectTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: subjectTableViewCell.nibName)
        subTableView.register(UINib(nibName: DayTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: DayTableViewCell.nibName)
        subTableView.register(UINib(nibName: MonthTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: MonthTableViewCell.nibName)
    }
    
    

  
    
    var subViewState = false
    var firstSub = true
    @objc func handlePan(recognizer:UIPanGestureRecognizer) {
        if firstSub {
        
            startPosition = subView.center.y
            firstSub = false
        }
      
        delegate?.set()
        
            
            let translation = recognizer.translation(in: self.view)
            print("\(subView.center.y)")
            if let view = recognizer.view {
                view.center = CGPoint(x:view.center.x ,
                                      y:view.center.y + translation.y)
            }
            if (subView.center.y <=  startPosition - 62) {
              
            subView.center.y = startPosition - 62
        }
        if (subView.center.y >= startPosition) {
            subView.center.y = startPosition
            print("тут")
            self.firstnav = true
            
        }
        
            // print("trans 1 \(recognizer.translation(in: self.view))")
            recognizer.setTranslation(CGPoint.zero, in: self.view)
            // print("trans 2 \(recognizer.translation(in: self.view))")
            if recognizer.state == UIGestureRecognizerState.ended {
                // 1
                let endPosition = startPosition - subView.center.y
                let velocity = recognizer.velocity(in: self.view)
                let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
                let slideMultiplier = magnitude / 200
                //print("magnitude: \(magnitude), slideMultiplier: \(slideMultiplier)")
                
                // 2
                let slideFactor = 0.1 * slideMultiplier     //Increase for more of a slide
                // 3
                var finalPoint = CGPoint(x: subView.center.x , y: startPosition)
                if (endPosition > 40.0){
                    finalPoint = CGPoint(x: recognizer.view!.center.x, y : startPosition - 62)
                }
                
                
                
                if (finalPoint.y == startPosition) {
                    hiddenView.isHidden = true
                    self.navigationController?.navigationBar.subviews.forEach({ (view) in
                        view.removeFromSuperview()
                    })
                } else {
                    hiddenView.isHidden = false
                    if (self.navigationController?.navigationBar.subviews != nil){
                    self.navigationController?.navigationBar.subviews.forEach({ (view) in
                        view.removeFromSuperview()
                    })
                    }
                    let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
                    let bounds = self.navigationController?.navigationBar.bounds.insetBy(dx: 0, dy: -(statusBarHeight)).offsetBy(dx: 0, dy: -(statusBarHeight))
                    let someView:UIView = UIView(frame: bounds!)
                    someView.backgroundColor = UIColor.black.withAlphaComponent(0.54)
                    self.navigationController?.navigationBar.addSubview(someView)
                }
                
                // 5
                UIView.animate(withDuration: Double(slideFactor * 2),
                               delay: 0,
                               // 6
                    options: UIViewAnimationOptions.curveEaseOut,
                    animations: {recognizer.view!.center = finalPoint },
                    completion: nil)
                print("Start \(startPosition) endPosition \(endPosition) realPosition \(subView.center.y)")
            }
            
        
    }
    
    
    
    
    var firstnav = true
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        if firstnav {
        if (scrollView.superview == mainTableView.superview && (self.navigationController?.navigationBar.frame.size.height)! <= CGFloat(44.0)  ){
            if self.navigationController != nil{
                let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
                let bounds = self.navigationController?.navigationBar.bounds.insetBy(dx: 0, dy: -(statusBarHeight)).offsetBy(dx: 0, dy: -(statusBarHeight))
                // Create blur effect.
                let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
                visualEffectView.frame = bounds!
                // Set navigation bar up.
                // self.navigationController?.navigationBar.isTranslucent = true
                // self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
                visualEffectView.layer.zPosition = -1
                visualEffectView.isUserInteractionEnabled = false
                self.navigationController?.navigationBar.addSubview(visualEffectView)
                self.navigationController?.navigationBar.sendSubview(toBack: visualEffectView)
                firstnav = false
            }
        }
        }
        
        
        
        
    }
    
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backitem = UIBarButtonItem()
        backitem.title = "Back"
        segue.destination.navigationController?.navigationBar.topItem?.backBarButtonItem = backitem
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
