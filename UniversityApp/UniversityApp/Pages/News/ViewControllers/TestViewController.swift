//
//  TestViewController.swift
//  UniversityApp
//
//  Created by Роман Макеев on 26.07.2018.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    @IBOutlet weak var lbl: UILabel!
    var str = "some"
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl.text = str
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
