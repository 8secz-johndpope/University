//
//  EditWeekViewController.swift
//  UniversityApp
//
//  Created by Роман Макеев on 08.08.2018.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit
import FirebaseFirestore
class EditWeekViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, EditWeekDataProviderDelegate, CurrentTableViewCellDelegate, AddNewViewControllerDelegate {
    func dataAdded() {
        dataProvider.refresh()
        dataProvider.getDiary(weekDay: weekDay)
    
    }
    
    func deleteCell(cell: CurrentTableViewCell) {
        var docId = ""
       
        Firestore.firestore().collection("Diary").document(UsersModel.userModel.Institute).collection(UsersModel.userModel.Facultet).document(UsersModel.userModel.Group).collection(weekDay).getDocuments { (snapShot, error) in
            if error != nil {
                print("Ошибка! \n \(error.debugDescription)")
            } else {
                if snapShot?.documents != nil {
                for document in (snapShot?.documents)! {
                    if document.data()["Name"] as! String == cell.nameLabel.text && document.data()["Time"] as! String == cell.timeLabel.text && document.data()["Group"] as! String == cell.groupLabel.text {
                        docId = document.documentID
                        print(docId)
                        Firestore.firestore().collection("Diary").document(UsersModel.userModel.Institute).collection(UsersModel.userModel.Facultet).document(UsersModel.userModel.Group).collection(self.weekDay).document(docId).delete() {err in if error != nil {print(error.debugDescription) }
                        else {self.dataProvider.getDiary(weekDay: self.weekDay)}}
                        self.dataProvider.refresh()
                        print(self.dataProvider.models.count)
                        self.dataProvider.getDiary(weekDay: self.weekDay)
                    }
                }
            }
            }
            
        }
    }
    
    func dataloaded() {
        tableView.reloadData()
    }
    
    var institute = "IMIT"
    var fac = "PM"
    var group = "PM-171"
    var weekDay = "Monday"
    var dataProvider : EditWeekDataProvider = EditWeekDataProvider()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem?.title = ""
        let backitem = UIBarButtonItem()
        backitem.title = ""
        backitem.tintColor = UIColor.init(red: 52/255.0, green: 167/255.0, blue: 255/255, alpha: 1)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backitem
        self.navigationItem.largeTitleDisplayMode = .never
        
        register()
        tableView.reloadData()
        dataProvider.getDiary(weekDay: weekDay)
        dataProvider.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
      // dataProvider.getDiary(weekDay: weekDay, institute: self.institute, fac: self.fac, group: self.group)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == dataProvider.models.count  {
            performSegue(withIdentifier: "addNew", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.models.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row < dataProvider.models.count) {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrentTableViewCell.nibName) as! CurrentTableViewCell
            cell.selectionStyle = .none
            cell.nameLabel.text = dataProvider.models[indexPath.row].name
            cell.roomLabel.text = dataProvider.models[indexPath.row].room
            cell.teacherLabel.text = dataProvider.models[indexPath.row].teacher
            cell.timeLabel.text = dataProvider.models[indexPath.row].time
            cell.groupLabel.text = dataProvider.models[indexPath.row].group
            cell.weekLabel.text = dataProvider.models[indexPath.row].week
            cell.delegate = self
        return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddNewTableViewCell.nibName) as! AddNewTableViewCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func register(){
        tableView.register(UINib(nibName: CurrentTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: CurrentTableViewCell.nibName)
        tableView.register(UINib(nibName: AddNewTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: AddNewTableViewCell.nibName)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddNewViewController
        vc.delegate = self
        let weekDay = self.navigationItem.title
        switch weekDay {
        case "Понедельник"?:
            vc.weekDay = "Monday"
        case "Вторник"?:
            vc.weekDay = "Thuesday"
        case "Среда"?:
            vc.weekDay = "Wensday"
        case "Четверг"?:
            vc.weekDay = "Thursday"
        case "Пятница"?:
            vc.weekDay = "Friday"
        case "Суббота"?:
            vc.weekDay = "Saturday"
        case "Воскресенье"?:
            vc.weekDay = "Sunday"
        default:
            vc.weekDay = "Monday"
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
