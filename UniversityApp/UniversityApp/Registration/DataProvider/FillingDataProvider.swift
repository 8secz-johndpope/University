//
//  FillingDataProvider.swift
//  UniversityApp
//
//  Created by Роман Макеев on 22.08.2018.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import Foundation
import FirebaseFirestore
protocol FillingDataProviderDelegate: class {
    func dataLoaded()
    
}

class FillingDataProvider {
    weak var delegate : FillingDataProviderDelegate?
    
    
    var facultet : [String] = []
    var institute : [String] = []
    var group : [String] = []
    
    func loadData(){
        facultet = []
        institute = []
        group = []
        
        Firestore.firestore().collection("Filling").getDocuments { (snapShot, error) in
            if error != nil {
                print("ОШИБКА!\n\n\n \(error) \n\n\n")
            } else {
                for document in (snapShot?.documents)! {
                    if document.data()["Type"] as! String  == "institute" {
                        self.institute.append(document.data()["Name"] as! String)
                    } else if document.data()["Type"] as! String == "facultet" {
                        self.facultet.append(document.data()["Name"] as! String)
                    } else {
                        self.group.append(document.data()["Name"] as! String)
                    }
                    
                }
                print("\n\nВсе ок!\n\n")
                self.delegate?.dataLoaded()
            }
        }
    }
}
