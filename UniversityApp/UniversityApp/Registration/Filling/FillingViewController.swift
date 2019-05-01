//
//  FillingViewController.swift
//  UniversityApp
//
//  Created by 1 on 24.07.18.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit
import VK_ios_sdk
class FillingViewController: UIViewController, FillingDataProviderDelegate{
    func dataLoaded() {
        facultet = fillingDataProvider.facultet
        univer = fillingDataProvider.institute
        group = fillingDataProvider.group
        universityTable.reloadData()
        groupTable.reloadData()
        viewfacultTable.reloadData()
        hiddenView.isHidden = true
        for facult in facultet {
            originalFaciltetList.append(facult)
        }
        for univers in univer {
            originaluniver.append(univers)
        }
        for groups in group {
            originalgroup.append(groups)
        }
        print(facultet)
        print(univer)
        print(group)
    }
    
    @IBOutlet weak var containerConst2: NSLayoutConstraint!
    @IBOutlet weak var containerConst: NSLayoutConstraint!
    @IBOutlet weak var hiddenView: UIView!
    
    @IBOutlet weak var container: UIView!
 
    
    static let nibName = "FillingViewController"
  

    @IBOutlet weak var furtherBtn: UIButton!
    
    @IBOutlet weak var universityTextField: UITextField!
    
    @IBOutlet weak var facultetTextField: UITextField!
    
    @IBOutlet weak var heightGroupTable: NSLayoutConstraint!
    @IBOutlet weak var heightUniverTable: NSLayoutConstraint!
    @IBOutlet weak var heightFacultTable: NSLayoutConstraint!
    @IBOutlet weak var groupTextField: UITextField!
    
    @IBOutlet weak var viewfacultTable: UITableView!
    
    @IBOutlet weak var groupTable: UITableView!
    @IBOutlet weak var universityTable: UITableView!
    @IBOutlet weak var celllabel: UILabel!
    
    var fillingDataProvider : FillingDataProvider = FillingDataProvider()
    var facultet:[String] = []
    var univer : [String] = []
    var group : [String] = []
    var originalFaciltetList:[String] = Array()
    var originaluniver:[String] = Array ()
    var originalgroup:[String] = Array()
    var dataProvider: UserDataProvider = UserDataProvider ()
    var model: UserModel = UserModel()
    
    var startPos = CGFloat(0)
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
        startPos = container.center.y
        fillingDataProvider.delegate = self
        fillingDataProvider.loadData()
        facultetTextField.delegate = self
        universityTextField.delegate = self
        groupTextField.delegate = self
        furtherBtn.layer.cornerRadius = 10
        self.viewfacultTable.layer.cornerRadius = 10.0
        hiddenView.isHidden = false
        
        
        universityTextField.addTarget(self, action: #selector(searchRecr(_ :)), for: .editingChanged)
        facultetTextField.addTarget(self, action: #selector(searchRecords(_ :)), for: .editingChanged)
        groupTextField.addTarget(self, action: #selector(search(_ :)), for: .editingChanged)
        groupTable.isHidden = true
         viewfacultTable.isHidden = true
        universityTable.isHidden = true
        customizeTableView()
        setNavBar()
        
            }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    var keyRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var keyboardHeight = CGFloat(0)
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyRect = keyboardRectangle
            self.keyboardHeight = keyboardRectangle.height
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        containerConst2.constant = 0
        return true
    }
    func setNavBar(){
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationItem.title = "🎓 ВУЗ"
    self.navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.isTranslucent = true
    self.navigationController?.navigationBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.9 )
    self.navigationController?.navigationBar.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
       
    }
    @objc func searchRecr(_ textField: UITextField) {
        
        self.univer.removeAll()
        if universityTextField.text?.count != 0 {
            universityTable.isHidden = true
            for groups in originaluniver {
                if let countryToSearch = textField.text{
                    let range = groups.lowercased().range(of: countryToSearch, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        self.univer.append(groups)
                        universityTable.isHidden = false
                        
                        
                    }
                    
                }
            }
            
        } else {
            for groups in originaluniver {
                univer.append(groups)
            }
            universityTable.isHidden = false
            
        }
        universityTable.reloadData()
        var dur = CGFloat(0)
        dur = viewfacultTable.center.y + universityTable.frame.height - (container.frame.height - keyboardHeight )
        if dur > 0{
            //self.container.center = CGPoint(x: self.container.center.x, y: self.startPos - dur)
            
            
            
            
        }
    }
    @objc func search(_ textField: UITextField) {
        
        self.group.removeAll()
        if groupTextField.text?.count != 0 {
            groupTable.isHidden = true
            for groups in originalgroup {
                if let countryToSearch = textField.text{
                    let range = groups.lowercased().range(of: countryToSearch, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        self.group.append(groups)
                        groupTable.isHidden = false
                        
                    }
                    
                }
            }
            
        } else {
            for groups in originalgroup {
                group.append(groups)
            }
            groupTable.isHidden = false
            
            
        }
        groupTable.reloadData()
        var dur = CGFloat(0)
        dur = groupTable.center.y + viewfacultTable.frame.height - (container.frame.height - keyboardHeight )
        if dur > 0{
           // self.container.center = CGPoint(x: self.container.center.x, y: self.startPos - dur)
            
            
            
            
        }
    }
  
    //MARK:- searchRecords
    @objc func searchRecords(_ textField: UITextField) {
        self.facultet.removeAll()
        if facultetTextField.text?.count != 0 {
            viewfacultTable.isHidden = true
            for facult in originalFaciltetList {
                if let countryToSearch = textField.text{
                    let range = facult.lowercased().range(of: countryToSearch, options: .caseInsensitive, range: nil, locale: nil)
                    
                    if range != nil {
                        self.facultet.append(facult)
                         viewfacultTable.isHidden = false
                        
                    }
                    
                }
            }
        } else {
            for facult in originalFaciltetList {
                facultet.append(facult)
            }
             viewfacultTable.isHidden = true
        }
         viewfacultTable.reloadData()
        var dur = CGFloat(0)
        dur = viewfacultTable.center.y + viewfacultTable.frame.height - (keyboardHeight )
        if dur > 0{
           // self.container.center = CGPoint(x: self.container.center.x, y: self.startPos - dur)
            
            
            
            
        }
    }
   
    func customizeTableView(){
        viewfacultTable.register(UINib(nibName:ViewFacultetTableViewCell.nibName, bundle:nil), forCellReuseIdentifier: ViewFacultetTableViewCell.nibName)
        universityTable.register(UINib(nibName:UniversTableViewCell.nibName, bundle:nil), forCellReuseIdentifier: UniversTableViewCell.nibName)
        groupTable.register(UINib(nibName:GroupsTableViewCell.nibName, bundle:nil), forCellReuseIdentifier: GroupsTableViewCell.nibName)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func furtherPresent(_ sender: Any) {
        var flaq = false
        var institute = false
        var group = false
        var facultet = false
        for inst in fillingDataProvider.institute {
            if universityTextField.text == inst{institute = true}
        }
        for fac in fillingDataProvider.facultet {
            if facultetTextField.text == fac{facultet = true}
        }
        for gro in fillingDataProvider.group {
            if groupTextField.text == gro{group = true}
        }
        if (group && institute && facultet){
            flaq  = true
        }
        if flaq {
        let vc = UIStoryboard(name: "Filling", bundle: nil).instantiateViewController(withIdentifier: AboutMeViewController.nibName ) as! AboutMeViewController
        vc.model = self.dataProvider.userModel
        vc.university = self.universityTextField.text!
        print(vc.university)
        vc.facult = self.facultetTextField.text!
        vc.group = self.groupTextField.text!
        self.navigationController?.pushViewController(vc, animated: true)
        } else {
            print("\n\nHelloworld\n\n")
            let alertController = UIAlertController(title: "Ошибка", message:
                "Поля заполнены не правильно!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
}
extension FillingViewController : UITableViewDelegate,UITableViewDataSource , UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == viewfacultTable{
            var height: CGFloat = 0
            let count = facultet.count
            if count <= 4 {
                height = 50 * CGFloat(count)
            } else {height = 200}
            heightFacultTable.constant = height
            
        return facultet.count
        } else if tableView == universityTable{
            var height: CGFloat = 0
            let count = univer.count
            
            if count <= 4 {
                height = 50 * CGFloat(count)
            } else {height = 200}
            heightUniverTable.constant = height
            
            return univer.count
        } else {
            var height: CGFloat = 0
            let count = group.count
            if count <= 4 {
                height = 50 * CGFloat(count)
            } else {height = 200}
            heightGroupTable.constant = height
            
            return group.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == viewfacultTable {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewFacultetTableViewCell.nibName) as! ViewFacultetTableViewCell
        cell.viewfacultLbl.text = facultet[indexPath.row]
        return cell
        }else if tableView == universityTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: UniversTableViewCell.nibName) as! UniversTableViewCell
            cell.univerLabels.text = univer[indexPath.row]
            return cell
        } else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: GroupsTableViewCell.nibName) as! GroupsTableViewCell
            cell.grouplabels.text = group[indexPath.row]
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == viewfacultTable{
            return UITableViewAutomaticDimension
        }else {
        return 60
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        containerConst2.constant = 0
        if tableView == viewfacultTable{
        tableView.deselectRow(at: indexPath, animated: true)
        facultetTextField.text = facultet[indexPath.row]
        viewfacultTable.isHidden = true
        }else if tableView == universityTable {
            tableView.deselectRow(at: indexPath, animated: true)
            universityTextField.text = univer[indexPath.row]
            universityTable.isHidden = true
        }else {
            tableView.deselectRow(at: indexPath, animated: true)
            groupTextField.text = group[indexPath.row]
            groupTable.isHidden = true
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        var dur = CGFloat(0)
        print("BKJHFVKJVJHABVCKJHKVDJS")
        
        if textField == groupTextField {
            groupTable.isHidden = false
            viewfacultTable.isHidden = true
            universityTable.isHidden = true
            print("\(startPos)\n")
            dur = groupTable.frame.maxY - keyRect.minY
            if dur > 0 && keyboardHeight > 0{
                print(dur)
                //self.container.center = CGPoint(x: self.container.center.x, y: self.startPos - dur)
                UIView.animate(withDuration: Double(0.5 * 2),
                               delay: 0,
                               // 6
                    options: UIViewAnimationOptions.curveEaseOut,
                    animations: {self.containerConst2.constant =  -dur - 15},
                    completion: nil)
                print("NENENNENENENENNE")
                
                
            }
            
        } else if textField == facultetTextField {
            groupTable.isHidden = true
            viewfacultTable.isHidden = false
            universityTable.isHidden = true
            dur = viewfacultTable.frame.maxY - keyRect.minY
            if dur > 0 && keyboardHeight > 0{
                print(dur)
                //self.container.center = CGPoint(x: self.container.center.x, y: self.startPos - dur)
                UIView.animate(withDuration: Double(0.5 * 2),
                               delay: 0,
                               // 6
                    options: UIViewAnimationOptions.curveEaseOut,
                    animations: {self.containerConst2.constant =  -dur - 15},
                    completion: nil)
                print("NENENNENENENENNE")
                
                
            }
            
            
        }else  if textField == universityTextField  {
            universityTable.isHidden = false
            groupTable.isHidden = true
            viewfacultTable.isHidden = true
            dur = universityTable.frame.maxY - keyRect.minY
            if dur > 0 && keyboardHeight > 0{
                print(dur)
                print("\n\nnfnfn: \(universityTable.frame.maxY) \(keyRect.minY)")
                //self.container.center = CGPoint(x: self.container.center.x, y: self.startPos - dur)
                
                UIView.animate(withDuration: Double(0.5 * 2),
                               delay: 0,
                               // 6
                    options: UIViewAnimationOptions.curveEaseOut,
                    animations: {self.containerConst2.constant =  -dur - 15},
                    completion: nil)
                print("NENENNENENENENNE")
                
                
            }
            
        }else {
            universityTable.isHidden = true
            groupTable.isHidden = true
            viewfacultTable.isHidden = true
        }
        
    }
    
}
