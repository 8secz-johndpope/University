//
//  EditDiaryViewController.swift
//  UniversityApp
//
//  Created by Роман Макеев on 08.08.2018.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit

class EditDiaryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem?.title = ""
        let backitem = UIBarButtonItem()
        backitem.title = ""
        backitem.tintColor = UIColor.init(red: 52/255.0, green: 167/255.0, blue: 255/255, alpha: 1)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backitem
        self.navigationItem.title = "🗓 Расписание"
        self.navigationItem.largeTitleDisplayMode = .never
        
        registerCells()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "editWeek", sender: tableView.cellForRow(at: indexPath) as! EditDiaryTableViewCell)
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EditDiaryTableViewCell.nibName) as! EditDiaryTableViewCell
        switch indexPath.row {
        case 0:
            cell.weekDay.text = "Понедельник"
        case 1:
            cell.weekDay.text = "Вторник"
        case 2:
            cell.weekDay.text = "Среда"
        case 3:
            cell.weekDay.text = "Четверг"
        case 4:
            cell.weekDay.text = "Пятница"
        case 5:
            cell.weekDay.text = "Суббота"
        default:
            print("Hello")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func registerCells(){
        tableView.register(UINib(nibName: EditDiaryTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: EditDiaryTableViewCell.nibName)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sender = sender as! EditDiaryTableViewCell
        segue.destination.navigationItem.title = sender.weekDay.text
        let vc  = segue.destination as! EditWeekViewController
        switch sender.weekDay.text {
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
