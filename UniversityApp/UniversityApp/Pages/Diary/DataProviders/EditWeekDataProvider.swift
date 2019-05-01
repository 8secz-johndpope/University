//
//  EditWeekDataProvider.swift
//  UniversityApp
//
//  Created by Роман Макеев on 09.08.2018.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import Foundation
import FirebaseFirestore


protocol EditWeekDataProviderDelegate : class {
    func dataloaded()
}
class EditWeekDataProvider {
    
    weak var delegate : EditWeekDataProviderDelegate?
    var models : [EditWeekModel] = [EditWeekModel]()
    func refresh() {
        models = []
    }
    func getDiary(weekDay: String){
        models = []
        Firestore.firestore().collection("Diary").document(UsersModel.userModel.Institute).collection(UsersModel.userModel.Facultet).document(UsersModel.userModel.Group).collection(weekDay).order(by: "Time").getDocuments { (snapShot, error) in
            if error != nil {
                print("Ошибочка вышла! \n \(error.debugDescription)")
            } else {
                if snapShot?.documents != nil {
                    for document in (snapShot?.documents)!{
                        let model = EditWeekModel()
                        model.name = document.data()["Name"] as! String
                        model.group = document.data()["Group"] as! String
                        model.room = document.data()["Room"] as! String
                        model.week = document.data()["Week"] as! String
                        model.time = document.data()["Time"] as! String
                        self.models.append(model)
                        
                    }
                    self.delegate?.dataloaded()
                    
                }
            }
        }
    }
}
