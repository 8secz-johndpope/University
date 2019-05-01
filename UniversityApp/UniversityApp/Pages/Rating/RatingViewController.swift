//
//  RatingViewController.swift
//  UniversityApp
//
//  Created by Роман Макеев on 24.07.2018.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.barTintColor = UIColor.white
        self.tabBarController?.tabBar.tintColor = UIColor.init(red: 0.1882, green: 0.3686, blue: 0.5647, alpha: 1)
        let storyboard = UIStoryboard(name: "Rating", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! UIViewController
        addChildViewController(controller)
        view.addSubview(controller.view)
        controller.didMove(toParentViewController: self)
        // Do any additional setup after loading the view.
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
