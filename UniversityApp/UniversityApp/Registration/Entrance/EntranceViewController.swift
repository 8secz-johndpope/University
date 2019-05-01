//
//  EntranceViewController.swift
//  UniversityApp
//
//  Created by 1 on 24.07.18.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit
import VK_ios_sdk
import FirebaseAuth
import FirebaseFirestore
class EntranceViewController: UIViewController,UserDataProviderDelegate{
    static let nibName = "EntranceViewController"
    func transition() {
        Firestore.firestore().collection("Users").whereField("Email", isEqualTo: UsersModel.userModel.email).getDocuments(completion: { (snapShot, error) in
            if snapShot?.documents.count == 0 {
                let vc = UIStoryboard(name: "Filling", bundle: nil).instantiateInitialViewController()
                
                self.present(vc!, animated: true, completion: nil)
            }else {
                Auth.auth().signIn(withEmail: UsersModel.userModel.email, password: UsersModel.userModel.id, completion: { (user, error) in
                    if error == nil{
                        Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid as! String).getDocument(completion: { (snapShot, error) in
                            if error != nil {
                                print ("Error")
                            }else {
                                print(snapShot?.data())
                                UsersModel.userModel.FirstName = snapShot?.data()!["First-name"] as! String
                                UsersModel.userModel.LastName = snapShot?.data()!["Last-name"] as! String
                                UsersModel.userModel.Institute = snapShot?.data()!["Institut"] as! String
                                UsersModel.userModel.email = snapShot?.data()!["Email"] as! String
                                UsersModel.userModel.Facultet = snapShot?.data()!["Facultet"] as! String
                                UsersModel.userModel.Group = snapShot?.data()!["Group"] as! String
                                UsersModel.userModel.SubGroup = snapShot?.data()!["Sub-group"] as! String
                                UsersModel.userModel.Recordbook = snapShot?.data()!["Number-record-book"] as! String
                                
                             }
                            Firestore.firestore().collection("Institute").document(UsersModel.userModel.Institute).getDocument(completion: { (snapShot, error) in
                                if error != nil {
                                    print("Error")
                                }else {
                                    UsersModel.userModel.shortName = snapShot?.data()!["shortName"] as! String
                                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                                    self.present(vc!, animated: true, completion: nil)
                                }
                            })
                        })
                        
                    }
                })
            }
        })
            
        
              
        }
         
    //MARK:
    @IBOutlet weak var entranceBtn: UIButton!
    var dataProvider: UserDataProvider = UserDataProvider()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        entranceBtn.layer.cornerRadius = 10
        dataProvider.sdkInstance?.uiDelegate = self
        dataProvider.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var firstLoad = true
    @IBAction func Entrance(_ sender: Any) {
        if firstLoad{
        dataProvider.authorizationVK()
            firstLoad = false
        }
        
        
    }
   
    
}
extension EntranceViewController : VKSdkUIDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        present(controller, animated: true, completion: nil)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        guard let captchaController = VKCaptchaViewController.captchaControllerWithError(captchaError) else {
            return
        }
        present(captchaController, animated: true, completion: nil)
    }
   
    
    
}
