//
//  MainProfileViewController.swift
//  UniversityApp
//
//  Created by 1 on 01.08.18.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit
import FirebaseAuth
import Kingfisher
import FirebaseUI
class MainProfileViewController: UIViewController {
    static let nibName = "MainProfileViewController"

    //MARK: Name variable
    
    @IBOutlet weak var fullName: UILabel!
    
    @IBOutlet weak var aboutInfoTextLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var leftImageLayout: NSLayoutConstraint!
    @IBOutlet weak var rightImageLayout: NSLayoutConstraint!
    @IBOutlet weak var rightNameLayout: NSLayoutConstraint!
    @IBOutlet weak var leftNameLayout: NSLayoutConstraint!
    @IBOutlet weak var rightAppointmentLayout: NSLayoutConstraint!
    @IBOutlet weak var leftAppointmentLayout: NSLayoutConstraint!
    @IBOutlet weak var leftUpBtnLayout: NSLayoutConstraint!
    @IBOutlet weak var rightUpBtnLayout: NSLayoutConstraint!
    @IBOutlet weak var leftDownBtnLayout: NSLayoutConstraint!
    @IBOutlet weak var rightDownBtnLayout: NSLayoutConstraint!
    @IBOutlet weak var topUpBtnLayout: NSLayoutConstraint!
    
    @IBOutlet weak var topNameLayout: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
     
        
        
    }
    //MARK: - Верстка экрана
    func getData(){
       
        resourse.resource = ImageResource(downloadURL: URL(string: UsersModel.userModel.url_image)!, cacheKey: UsersModel.userModel.url_image)
        profileImage.kf.setImage(with: resourse.resource)
        fullName.text = UsersModel.userModel.FirstName + " " + UsersModel.userModel.LastName
        aboutInfoTextLbl.text = "ВолГУ" + "," + UsersModel.userModel.shortName + "," + UsersModel.userModel.Group
     }
    
    func Layout(){
       rightImageLayout.constant = (UIScreen.main.bounds.width - 151)/2
       leftImageLayout.constant = (UIScreen.main.bounds.width - 151)/2
       rightNameLayout.constant = (UIScreen.main.bounds.width - 157)/2
       leftNameLayout.constant = (UIScreen.main.bounds.width - 157)/2
       rightAppointmentLayout.constant = (UIScreen.main.bounds.width - 145)/2
       leftAppointmentLayout.constant = (UIScreen.main.bounds.width - 145)/2
       leftUpBtnLayout.constant = (UIScreen.main.bounds.width - 189)/2
       rightUpBtnLayout.constant = (UIScreen.main.bounds.width - 189)/2
       leftDownBtnLayout.constant = (UIScreen.main.bounds.width - 49)/2
       rightDownBtnLayout.constant = (UIScreen.main.bounds.width - 49)/2
        if UIScreen.main.bounds.height < 667{
            topNameLayout.constant = (topNameLayout.constant)/2
            topUpBtnLayout.constant = (topUpBtnLayout.constant)/2
        } else if UIScreen.main.bounds.height > 667 {
             topNameLayout.constant = (topNameLayout.constant)*1.8
             topUpBtnLayout.constant = (topUpBtnLayout.constant)*1.8
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
          Layout()
        getData()
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        navigationController?.navigationBar.isHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func editing(_ sender: Any) {
        let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: EditingProfileViewController.nibName) as! EditingProfileViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func Exit(_ sender: Any) {
        try! Auth.auth().signOut()
        
        let vc = UIStoryboard(name: "Entrance", bundle: nil).instantiateViewController(withIdentifier: EntranceViewController.nibName) as! EntranceViewController
        self.present(vc, animated: true, completion: nil)
    }
    

  

}
