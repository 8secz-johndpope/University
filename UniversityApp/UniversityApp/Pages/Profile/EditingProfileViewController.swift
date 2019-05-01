//
//  EditingProfileViewController.swift
//  UniversityApp
//
//  Created by 1 on 01.08.18.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Kingfisher
import FirebaseStorage


class EditingProfileViewController: UIViewController, FillingDataProviderDelegate{
    func dataLoaded() {
        group = fillingDataProvider.group
        univer = fillingDataProvider.institute
        facultet = fillingDataProvider.facultet
        direction.reloadData()
        facultTable.reloadData()
        groupTable.reloadData()
        hiddenView.isHidden = true
        print("\n\n\(group)\n\(univer)\n\(facultet)\n\n")
        for facult in facultet {
            originalfacultets.append(facult)
        }
        for groups in group {
            originalgroup.append(groups)
        }
        for univers in univer {
            originaluniver.append(univers)
        }
        
    }
    
   var startPos = CGFloat(0)
    
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var hiddenView: UIView!
    
    static let nibName = "EditingProfileViewController"
    var facultetdateProvider:FacultetDataProvider = FacultetDataProvider()
    var fillingDataProvider : FillingDataProvider = FillingDataProvider()
   
    var group : [String] = []
    var univer : [String] = []
    var originalfacultets:[String] = Array()
    var facultet:[String] = []
    var originalgroup:[String] = Array()
    var originaluniver:[String] = Array ()
    @IBOutlet weak var heightgroupTable: NSLayoutConstraint!
    @IBOutlet weak var heightGroupTable: NSLayoutConstraint!
    @IBOutlet weak var numberbookTextLbl: UITextField!
    @IBOutlet weak var universityTextLbl: UITextField!
    @IBOutlet weak var LastNameTextLbl: UITextField!
    @IBOutlet weak var firstNameTextLbl: UITextField!
    @IBOutlet weak var groupTextLabel: UITextField!
    @IBOutlet weak var facultTextLabel: UITextField!
    @IBOutlet weak var facultTable: UITableView!
    @IBOutlet weak var groupTable: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var direction: UITableView!
    @IBOutlet weak var rightImageLayout: NSLayoutConstraint!
    @IBOutlet weak var leftImageLayout: NSLayoutConstraint!
    @IBOutlet weak var leftBtnLayout: NSLayoutConstraint!
    @IBOutlet weak var rightBtnLayout: NSLayoutConstraint!
    
    @IBOutlet weak var heightDirection: NSLayoutConstraint!
    @IBOutlet weak var leftSurnameLayout: NSLayoutConstraint!
    @IBOutlet weak var rightSurnameLayout: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenView.isHidden = false
        fillingDataProvider.delegate = self
        fillingDataProvider.loadData()
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        self.navigationController?.navigationBar.isHidden = false
        facultTextLabel.delegate = self
        groupTextLabel.delegate = self
        firstNameTextLbl.delegate = self
        LastNameTextLbl.delegate = self
        universityTextLbl.delegate = self
        numberbookTextLbl.delegate = self
        startPos = container.center.y
        facultTable.layer.cornerRadius = 10.0
        groupTable.layer.cornerRadius = 10.0
        direction.layer.cornerRadius = 10.0
       
        for facult in facultet {
            originalfacultets.append(facult)
        }
        for groups in group {
            originalgroup.append(groups)
        }
        for univers in univer {
            originaluniver.append(univers)
        }
    
        facultTextLabel.addTarget(self, action: #selector(searchRecords(_ :)), for: .editingChanged)
        groupTextLabel.addTarget(self, action: #selector(searchRec(_ :)), for: .editingChanged)
        universityTextLbl.addTarget(self, action: #selector(searchNow(_ :)), for: .editingChanged)
        facultTable.isHidden = true
        groupTable.isHidden = true
        direction.isHidden = true
       
        profileImage.kf.setImage(with: resourse.resource)
        
        LastNameTextLbl.text = UsersModel.userModel.LastName
        firstNameTextLbl.text = UsersModel.userModel.FirstName
        universityTextLbl.text = UsersModel.userModel.Institute
        groupTextLabel.text = UsersModel.userModel.Group
        facultTextLabel.text = UsersModel.userModel.Facultet
        numberbookTextLbl.text = UsersModel.userModel.Recordbook
        customizeTableView()
        Layout()
      
    }
    
    func Layout(){
        rightImageLayout.constant = (UIScreen.main.bounds.width - 151)/2
        leftImageLayout.constant = (UIScreen.main.bounds.width - 151)/2
        leftBtnLayout.constant = (UIScreen.main.bounds.width - 119)/2
        rightBtnLayout.constant = (UIScreen.main.bounds.width - 119)/2
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

   

    }
    @IBAction func down(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func uploadImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    func customizeTableView(){
        facultTable.register(UINib(nibName:FacultetTableViewCell.nibName, bundle:nil), forCellReuseIdentifier: FacultetTableViewCell.nibName)
         groupTable.register(UINib(nibName:ViewGroupTableViewCell.nibName, bundle:nil), forCellReuseIdentifier: ViewGroupTableViewCell.nibName)
       direction.register(UINib(nibName:DirectionTableViewCell.nibName, bundle:nil), forCellReuseIdentifier: DirectionTableViewCell.nibName)
        
    }
    func sortMassiv (){
       
        for facult in facultet {
            originalfacultets.append(facult)
        }
    }
    @objc func searchNow(_ textField: UITextField) {
        
        self.univer.removeAll()
        if universityTextLbl.text?.count != 0 {
            direction.isHidden = true
            for univ in originaluniver {
                if let countryToSearch = textField.text{
                    let range = univ.lowercased().range(of: countryToSearch, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        self.univer.append(univ)
                        direction.isHidden = false
                    }
                    
                }
            }
            
        } else {
            for univ in originaluniver {
                univer.append(univ)
            }
            direction.isHidden = false
            
        }
        direction.reloadData()
    }
    @objc func searchRec(_ textField: UITextField) {
      
        self.group.removeAll()
        if groupTextLabel.text?.count != 0 {
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
    }
    @objc func searchRecords(_ textField: UITextField) {
       
        self.facultet.removeAll()
        if facultTextLabel.text?.count != 0 {
            facultTable.isHidden = true
            for facult in originalfacultets {
                if let countryToSearch = textField.text{
                    let range = facult.lowercased().range(of: countryToSearch, options: .caseInsensitive, range: nil, locale: nil)        
                    if range != nil {
                        self.facultet.append(facult)
                        facultTable.isHidden = false
                    }
                    
                }
            }
        } else {
            for facult in originalfacultets {
                facultet.append(facult)
            }
            facultTable.isHidden = false
        }
        facultTable.reloadData()
    }
    
    @IBAction func SetData(_ sender: Any) {
        var flaq = false
        var institute = false
        var group = false
        var facultet = false
        for inst in fillingDataProvider.institute {
            if universityTextLbl.text == inst{institute = true}
        }
        for fac in fillingDataProvider.facultet {
            if facultTextLabel.text == fac{facultet = true}
        }
        for gro in fillingDataProvider.group {
            if groupTextLabel.text == gro{group = true}
        }
        if (group && institute && facultet){
            flaq  = true
        }
        if flaq {
        hiddenView.isHidden = false
        guard let uid = Auth.auth().currentUser?.uid  else {return}
        var data = Data()
        let storageRef = Storage.storage().reference().child("images/\(uid)")
        data = UIImagePNGRepresentation(profileImage.image!)!
        
        storageRef.putData(data, metadata: nil) { (metadata, error) in
            if error != nil {
                print("Все плохо \(error?.localizedDescription)")
            }else {
                Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid as! String).updateData([
                    "Facultet":self.facultTextLabel.text!,
                    "First-name":self.firstNameTextLbl.text!,
                    "Group": self.groupTextLabel.text!,
                    "Institut":self.universityTextLbl.text!,
                    "Last-name":self.LastNameTextLbl.text!,
                    "Sub-group":UsersModel.userModel.SubGroup,
                    "Number-record-book":self.numberbookTextLbl.text!,
                    "Email":UsersModel.userModel.email
                    
                ]){ err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully rewritten!")
                        UsersModel.userModel.Facultet = self.facultTextLabel.text!
                        UsersModel.userModel.FirstName = self.firstNameTextLbl.text!
                        UsersModel.userModel.Group = self.groupTextLabel.text!
                        UsersModel.userModel.Institute = self.universityTextLbl.text!
                        UsersModel.userModel.LastName = self.LastNameTextLbl.text!
                        UsersModel.userModel.Recordbook = self.numberbookTextLbl.text!
                        Firestore.firestore().collection("Institute").document(UsersModel.userModel.Institute).getDocument(completion: { (snapShot, error) in
                            if error != nil {
                                print("Error")
                            }else {
                                UsersModel.userModel.shortName = snapShot?.data()!["shortName"] as! String
                                storageRef.downloadURL { (url, error) in
                                    if error != nil {
                                        print(error)
                                    }else {
                                        Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid as! String).updateData(["Avatar-url" : url?.absoluteString ], completion: { (err) in
                                            if let err = err{
                                                print("")
                                            }else {
                                                UsersModel.userModel.url_image = (url?.absoluteString)!
                                                
                                                resourse.resource = ImageResource(downloadURL: URL(string: UsersModel.userModel.url_image)!, cacheKey: UsersModel.userModel.url_image)
                                                self.navigationController?.popViewController(animated: true)
                                            }
                                            
                                        })
                                    }
                                }
                                
                            }
                        })
                        
                    }
            }
        }
        
            }
  
        
        
       
        } else {
            print("\n\nHelloworld\n\n")
            let alertController = UIAlertController(title: "Ошибка", message:
                "Поля заполнены не правильно!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}
extension EditingProfileViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate ,UITextFieldDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImage.image = image
        dismiss(animated:true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == facultTable {
            var height: CGFloat = 0
            let count = facultet.count
            if count <= 4 {
            height = 50 * CGFloat(count)
            } else {height = 200}
            heightGroupTable.constant = height
         return facultet.count
        }else if tableView == direction {
            var height: CGFloat = 0
            let count = univer.count
            if count <= 4 {
                height = 50 * CGFloat(count)
            } else {height = 200}
            heightDirection.constant = height
            return univer.count
        }else {
            var height: CGFloat = 0
            let count = group.count
            if count <= 4 {
                height = 50 * CGFloat(count)
            } else {height = 200}
            heightgroupTable.constant = height
            return group.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if tableView == facultTable{
                let cell = tableView.dequeueReusableCell(withIdentifier: FacultetTableViewCell.nibName) as! FacultetTableViewCell
            cell.facultLabel.text = facultet[indexPath.row]
            return cell
        } else if tableView == direction{
            let cell = tableView.dequeueReusableCell(withIdentifier: DirectionTableViewCell.nibName) as! DirectionTableViewCell
            cell.DirectionLbl.text = univer[indexPath.row]
            return cell
        }
        else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: ViewGroupTableViewCell.nibName) as! ViewGroupTableViewCell
            cell.viewGroupTextLabel.text = group[indexPath.row]
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == facultTable{
           
                return UITableViewAutomaticDimension
            
        }else{
                return 60
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == facultTable{
        tableView.deselectRow(at: indexPath, animated: true)
        facultTextLabel.text = facultet[indexPath.row]
        facultTable.isHidden = true
        }else if tableView == groupTable{
            tableView.deselectRow(at: indexPath, animated: true)
            groupTextLabel.text = group[indexPath.row]
            groupTable.isHidden = true
        }else if tableView == direction{
            tableView.deselectRow(at: indexPath, animated: true)
            universityTextLbl.text = univer[indexPath.row]
            direction.isHidden = true
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       self.container.center.y = startPos
        textField.resignFirstResponder()
     
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        UIView.animate(withDuration: Double(0.5 * 2),
                       delay: 0,
                       // 6
            options: UIViewAnimationOptions.curveEaseOut,
            animations: {self.container.center = CGPoint(x: self.container.center.x, y: self.startPos - 300) },
            completion: nil)
        if textField == groupTextLabel && groupTextLabel.text?.characters.count == 0{
             groupTable.isHidden = false
             facultTable.isHidden = true
             direction.isHidden = true
        } else if textField == facultTextLabel && facultTextLabel.text?.characters.count == 0  {
            groupTable.isHidden = true
            facultTable.isHidden = false
            direction.isHidden = true
        }else  if textField == universityTextLbl && universityTextLbl.text?.characters.count == 0 {
            direction.isHidden = false
            groupTable.isHidden = true
            facultTable.isHidden = true
        }else {
            direction.isHidden = true
            groupTable.isHidden = true
            facultTable.isHidden = true
        }

    }
    
}
