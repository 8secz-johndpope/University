//
//  AboutMeViewController.swift
//  UniversityApp
//
//  Created by 1 on 24.07.18.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AboutMeViewController: UIViewController, UITextFieldDelegate {
    static let nibName = "AboutMeViewController"

    @IBOutlet weak var surnameLbl: UITextField!
    
    @IBOutlet weak var heightBottomBtn: NSLayoutConstraint!
    @IBOutlet weak var ScrollViewFilling: UIScrollView!
    @IBOutlet weak var subgroupTextLbl: UITextField!
    @IBOutlet weak var numberbookTextLbl: UITextField!
    @IBOutlet weak var nameLbl: UITextField!
    @IBOutlet weak var readyBtn: UIButton!
    var model:UserModel = UserModel()
    var facult = ""
    var group = ""
    var university = ""
  
    let db = Firestore.firestore()
    func searchBar(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "👋 О себе"
        self.navigationItem.hidesBackButton = true
       
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        subgroupTextLbl.delegate = self
        numberbookTextLbl.delegate = self
        nameLbl.delegate = self
        searchBar()
        readyBtn.layer.cornerRadius = 10
        UsersModel.userModel.LastName = surnameLbl.text!
        UsersModel.userModel.FirstName = nameLbl.text!
      
        UsersModel.userModel.Facultet = facult
        UsersModel.userModel.Group = group
        UsersModel.userModel.Institute = university
        UsersModel.userModel.SubGroup = subgroupTextLbl.text!
        UsersModel.userModel.Recordbook = numberbookTextLbl.text!
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //667
        //736
      var height = view.bounds.height
        if height == 667 {
            heightBottomBtn.constant = 150
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func saveUser(){
        Auth.auth().createUser(withEmail:UsersModel.userModel.email, password: UsersModel.userModel.id) {(user,error) in
            if error == nil && user != nil {
                print("User  created")
    
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = UsersModel.userModel.FirstName
                
                guard let uid = Auth.auth().currentUser?.uid else { return }
                
                self.db.collection("Users").document("\(uid)").setData([
                    "Facultet":self.facult,
                    "First-name": self.nameLbl.text!,
                    "Group": self.group,
                    "Institut":self.university,
                    "Last-name":self.surnameLbl.text!,
                    "Sub-group":self.subgroupTextLbl.text!,
                    "Number-record-book":self.numberbookTextLbl.text!,
                    "Avatar-url":UsersModel.userModel.url_image,
                    "Email":UsersModel.userModel.email
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                        UsersModel.userModel.FirstName = self.nameLbl.text!
                        UsersModel.userModel.LastName = self.surnameLbl.text!
                        UsersModel.userModel.Facultet = self.facult
                        UsersModel.userModel.Group = self.group
                        UsersModel.userModel.Avatar = UsersModel.userModel.url_image
                        UsersModel.userModel.SubGroup = self.subgroupTextLbl.text!
                        UsersModel.userModel.Institute = self.university
                        UsersModel.userModel.Recordbook  = self.numberbookTextLbl.text ?? ""
                        
                        Firestore.firestore().collection("Institute").document(UsersModel.userModel.Institute).getDocument(completion: { (snapShot, error) in
                            
                            if error != nil {
                                print(error)
                            }else{
                                UsersModel.userModel.shortName = snapShot?.data()!["shortName"] as! String
                                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                                self.present(vc!, animated: true, completion: nil)
                            }
                            
                        })
                    }
                }
                
            }else {
                print("Error creating user:\(error!.localizedDescription)" )
            }
        }
        
    }

    @IBAction func Savefirabse(_ sender: Any) {
        saveUser()
    }
    

}
