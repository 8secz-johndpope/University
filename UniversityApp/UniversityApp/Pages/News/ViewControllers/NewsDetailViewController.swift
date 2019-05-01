//
//  NewsDetailViewController.swift
//  UniversityApp
//
//  Created by Роман Макеев on 25.07.2018.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit
import Hero
import Kingfisher


class NewsDetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var topView: UIView!
    
    static let nibName = "NewsDetailViewController"
    var id = "some"
    
    @IBAction func closeBtn(_ sender: UIButton) {
        hero.dismissViewController()
    }
    
    @IBOutlet weak var imgHeight: NSLayoutConstraint!
    @IBOutlet weak var articleContent: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var mainView: UIView!
    var scrollVal = 0.0
    var panGR: UIPanGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isStatusBarHidden = true
        panGR = UIPanGestureRecognizer(target: self,
                                       action: #selector(handlePan(gestureRecognizer:)))
        view.addGestureRecognizer(panGR)
        mainView.layer.cornerRadius = 10
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        articleDate.hero.id = "date" + id
        articleTitle.hero.id = "title" + id
        articleImageView.hero.id = "img" + id
        mainView.hero.id = "view" + id
        articleTitle.text = model.title
        articleContent.text = model.content
        
        let resourse = ImageResource(downloadURL: URL(string: model.img)!, cacheKey: "\(id)img")
        articleImageView.kf.setImage(with: resourse)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.isStatusBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.shared.isStatusBarHidden = false
    }
    
    @objc func handlePan(gestureRecognizer:UIPanGestureRecognizer) {
       
        let translation = gestureRecognizer.translation(in: nil)
        let progress = translation.y / 2 / view.bounds.height
        switch gestureRecognizer.state {
        case .began:
            hero.dismissViewController()
        case .changed:
            
            Hero.shared.update(progress)
            
            let currentPos = CGPoint(x: translation.x + topView.center.x, y: translation.y + topView.center.y)
            Hero.shared.apply(modifiers: [.position(currentPos)], to: topView)
            
        default:
            if progress + gestureRecognizer.velocity(in: nil).y / view.bounds.height > 0.2 {
            Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
        
    }
    var model : NewsModel = NewsModel()
    func customize(id: String, model: NewsModel){
        hero.isEnabled = true
        self.id = id
        self.model = model
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollVal = Double(scrollView.contentOffset.y)
        print(scrollVal)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
