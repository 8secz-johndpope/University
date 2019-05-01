//
//  AddNewViewController.swift
//  UniversityApp
//
//  Created by Роман Макеев on 08.08.2018.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
protocol AddNewViewControllerDelegate : class {
    func dataAdded()
}
class AddNewViewController: UIViewController, UITextFieldDelegate {
   
    
    let white = UIColor.white
    let dark = UIColor.init(red: 28/255.0, green: 28/255.0, blue: 28/255.0, alpha: 0.38)
    let red = UIColor.init(red: 255/255.0, green: 89/255.0, blue: 100/255.0, alpha: 1)
    let gray = UIColor.init(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
    @IBOutlet weak var btnWeek1: UIButton!
    @IBOutlet weak var btnWeek2: UIButton!
    @IBOutlet weak var btnWeekAll: UIButton!
    @IBOutlet weak var btnGroup1: UIButton!
    @IBOutlet weak var btnGroup2: UIButton!
    @IBOutlet weak var btnGroupAll: UIButton!
    
    var canReady = true
    @IBOutlet weak var readyBtn: UIButton!
    @IBOutlet weak var picker: UIDatePicker!
    @IBOutlet weak var roomtextField: UITextField!
    @IBOutlet weak var teachertextField: UITextField!
    @IBOutlet weak var subjectTextField: UITextField!
    var weekDay = "Monday"
    var institute = ""
    var fac = ""
    var group = ""
    var subGroup = ""
    var diaryGroup = "All"
    var diaryWeek = "All"
    var diatyTime = "00:00"
    weak var delegate : AddNewViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomtextField.delegate = self
        teachertextField.delegate = self
        subjectTextField.delegate = self
        btnWeek1.layer.cornerRadius = btnWeek1.bounds.width/2.0
        btnWeek2.layer.cornerRadius = btnWeek2.bounds.width/2.0
        btnWeekAll.layer.cornerRadius = btnWeekAll.bounds.width/2.0
        btnGroup1.layer.cornerRadius = btnGroup1.bounds.width/2.0
        btnGroup2.layer.cornerRadius = btnGroup2.bounds.width/2.0
        btnGroupAll.layer.cornerRadius = btnGroupAll.bounds.width/2.0
        btnWeekAll.backgroundColor = red
        btnGroupAll.backgroundColor = red
        btnWeek1.backgroundColor = gray
        btnWeek2.backgroundColor = gray
        btnGroup1.backgroundColor = gray
        btnGroup2.backgroundColor = gray
        btnWeek1.tintColor = dark
        btnWeek2.tintColor = dark
        btnWeekAll.tintColor = white
        btnGroup1.tintColor = dark
        btnGroup2.tintColor = dark
        btnGroupAll.tintColor = white
        self.navigationItem.backBarButtonItem?.title = ""
        let backitem = UIBarButtonItem()
        backitem.title = ""
        backitem.tintColor = UIColor.init(red: 52/255.0, green: 167/255.0, blue: 255/255, alpha: 1)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backitem
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.title = "Добавить пару"
        let uid = Auth.auth().currentUser?.uid
        Firestore.firestore().collection("Users").document(uid!).getDocument { (snapShot, error) in
            if error != nil {
                print("Ошибочка вышла! \n \(error.debugDescription)")
            } else {
                self.institute = snapShot?.data()!["Institut"] as! String
                self.fac = snapShot?.data()!["Facultet"] as! String
                self.group = snapShot?.data()!["Group"] as! String
                self.subGroup = snapShot?.data()!["Sub-group"] as! String
                print("\(self.institute) \(self.fac) \(self.group) \(self.subGroup)")
            }
        }
        readyBtn.layer.cornerRadius = 10
        readyBtn.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func week1(_ sender: UIButton) {
        self.diaryWeek = "1"
        print("из")
        btnWeek1.backgroundColor = red
        btnWeek2.backgroundColor = gray
        btnWeekAll.backgroundColor = gray
        btnWeek1.tintColor = white
        btnWeek2.tintColor = dark
        btnWeekAll.tintColor = dark
    }
    
    @IBOutlet weak var week2: UIButton!
    @IBAction func week2(_ sender: UIButton) {
        self.diaryWeek = "2"
        btnWeek2.backgroundColor = red
        btnWeek1.backgroundColor = gray
        btnWeekAll.backgroundColor = gray
        btnWeek1.tintColor = dark
        btnWeek2.tintColor = white
        btnWeekAll.tintColor = dark
    }
    @IBAction func weekAll(_ sender: UIButton) {
        self.diaryWeek = "All"
        btnWeekAll.backgroundColor = red
        btnWeek1.backgroundColor = gray
        btnWeek2.backgroundColor = gray
        btnWeek1.tintColor = dark
        btnWeek2.tintColor = dark
        btnWeekAll.tintColor = white
    }
    @IBAction func group1(_ sender: UIButton) {
        self.diaryGroup = "1"
        btnGroup1.backgroundColor = red
        btnGroup2.backgroundColor = gray
        btnGroupAll.backgroundColor = gray
        btnGroup1.tintColor = white
        btnGroup2.tintColor = dark
        btnGroupAll.tintColor = dark
    }
    @IBAction func group2(_ sender: UIButton) {
        self.diaryGroup = "2"
        btnGroup2.backgroundColor = red
        btnGroup1.backgroundColor = gray
        btnGroupAll.backgroundColor = gray
        btnGroup1.tintColor = dark
        btnGroup2.tintColor = white
        btnGroupAll.tintColor = dark
    }
    @IBAction func groupAll(_ sender: UIButton) {
        self.diaryGroup = "All"
        btnGroupAll.backgroundColor = red
        btnGroup2.backgroundColor = gray
        btnGroup1.backgroundColor = gray
        btnGroup1.tintColor = dark
        btnGroup2.tintColor = dark
        btnGroupAll.tintColor = white
    }
    @IBAction func ready(_ sender: UIButton) {
        if canReady{
        let subject = self.subjectTextField.text
        let teacher = self.teachertextField.text
        let room = self.roomtextField.text
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.string(from: picker.date)
        Firestore.firestore().collection("Diary").document(UsersModel.userModel.Institute).collection(UsersModel.userModel.Facultet).document(UsersModel.userModel.Group).collection(weekDay).addDocument(data: ["Name" : subject ?? ""  , "Teacher" : teacher ?? ""  , "Room" : room  ?? "", "Time" : time , "Group" : diaryGroup , "Week" : diaryWeek  ]) {
            error in    if error != nil {print(error)} else {print("Изи")
                self.delegate?.dataAdded()
                self.navigationController?.popViewController(animated: true)}
        }
            canReady = false
        }
        
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
