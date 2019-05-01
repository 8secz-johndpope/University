//
//  FacultetDataProvider.swift
//  UniversityApp
//
//  Created by 1 on 20.08.18.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import Foundation
import Firebase


protocol FacultetDataProviderDelegate : class {
    func dataLoaded()
}

class FacultetDataProvider {
    var models:[String] = Array()
    func getData(){
        let db = Firestore.firestore()
        
        db.collection("Facultet").getDocuments { (snapShot, error) in
            if error != nil {
                print(error.debugDescription)
            } else {
                for document in snapShot!.documents{
                    var model  = ""
                    model = document.data()["name"] as! String
                    self.models.append(model)
                }
                print(self.models)
                
            }
        }
    }
}
