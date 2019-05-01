//
//  NewsMainViewController.swift
//  UniversityApp
//
//  Created by Роман Макеев on 24.07.2018.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit

class NewsMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NewsDataProviderDelegate {
    
    
    
    var loaded = false
    
    var dataProvider : NewsDataProvider = NewsDataProvider()
    var id = 0
    
    @IBOutlet weak var toptableViewConstraint: NSLayoutConstraint!
    
    func setNavBar(){
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "📌 Новости"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.9 )
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        dataProvider.getData()
        dataProvider.delegate = self
        
        //let height = self.navigationController?.navigationBar.frame.size.height
        //self.tableView.contentInset = UIEdgeInsetsMake(height!,0,0,0);
        setNavBar()
        customizeCells()
        tableView.rowHeight = tableView.estimatedRowHeight
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllArticlesTableViewCell.nibName) as! AllArticlesTableViewCell
        id = indexPath.row
        //cell.selectionStyle =  .default
        if loaded{
        cell.customizeCell(id: String(self.id), model: dataProvider.models[indexPath.row])
        }
        
        cell.selectionStyle = .none
        
        
        return cell
    }
    
    func customizeCells(){
        tableView.register(UINib(nibName: AllArticlesTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: AllArticlesTableViewCell.nibName)
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       id = indexPath.row
      
       performSegue(withIdentifier: "ShowNewsDetail", sender: tableView.cellForRow(at: indexPath))
        
       // ArticleRoute.showArticle(id: String(indexPath.row), fromVc: self)
    }
    var flaq = true
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
       // print(y)
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
           // self.navigationController?.navigationBar.addSubview(visualEffectView)
            //self.navigationController?.navigationBar.sendSubview(toBack: visualEffectView)
                visualEffectView.layer.zPosition = -1
                self.navigationController?.navigationBar.insertSubview(visualEffectView, at: 0)
                self.navigationController?.navigationBar.layer.zPosition = 10000
                
            flaq = false
            }
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let toVC = segue.destination as? NewsDetailViewController {
            let cell = sender as! AllArticlesTableViewCell
            toVC.customize(id: String(id), model: dataProvider.models[id])
            
            
        }
       
        
        
        
    }
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    func dataLoaded() {
        tableView.reloadData()
        activity.stopAnimating()
        loaded = true
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
