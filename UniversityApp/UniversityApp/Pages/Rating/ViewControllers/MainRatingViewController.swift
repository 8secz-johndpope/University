//
//  MainRatingViewController.swift
//  UniversityApp
//
//  Created by Роман Макеев on 26.07.2018.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit

class MainRatingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ButtonsTableViewCellDelegate {
    
    
    var flaq1 = true
    var flaq2 = false
    var state = 1
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func setNavBar(){
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "🌟 Мой рейтинг"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.9 )
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        customize()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if  section == 1 {
            return 1
        } else if (state == 1){
            return 12
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: RatingTableViewCell.nibName) as! RatingTableViewCell
            cell.selectionStyle = .none
            
        return cell
        } else  if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonsTableViewCell.nibName) as! ButtonsTableViewCell
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        } else if (state == 1 ){
            let cell = tableView.dequeueReusableCell(withIdentifier: TotalTableViewCell.nibName) as! TotalTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MissTableViewCell.nibName) as! MissTableViewCell
            return cell
        }
    }
    
    
    func customize(){
        tableView.register(UINib(nibName: RatingTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: RatingTableViewCell.nibName)
        tableView.register(UINib(nibName: ButtonsTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: ButtonsTableViewCell.nibName)
        tableView.register(UINib(nibName: TotalTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: TotalTableViewCell.nibName)
        tableView.register(UINib(nibName: MissTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: MissTableViewCell.nibName)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    var flaq = true
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        print(y)
        if (flaq && (self.navigationController?.navigationBar.frame.size.height)! <= CGFloat(44.0)  ){
            if let navBar = self.navigationController{
                let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
                let bounds = self.navigationController?.navigationBar.bounds.insetBy(dx: 0, dy: -(statusBarHeight)).offsetBy(dx: 0, dy: -(statusBarHeight))
                // Create blur effect.
                let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
                visualEffectView.frame = bounds!
                // Set navigation bar up.
                // self.navigationController?.navigationBar.isTranslucent = true
                // self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
                visualEffectView.layer.zPosition = -1
                self.navigationController?.navigationBar.addSubview(visualEffectView)
                self.navigationController?.navigationBar.sendSubview(toBack: visualEffectView)
                flaq = false
            }
        }
        
        
    }
    
    
    
    func loadFirstData() {
        print("FirstData")
        state = 1
        tableView.reloadData()
    }
    
    func loadSecondData() {
        print("SecondData")
        state = 2
        tableView.reloadData()
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
