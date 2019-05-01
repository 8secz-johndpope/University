//
//  NewsDataProvider.swift
//  UniversityApp
//
//  Created by Роман Макеев on 06.08.2018.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseFirestore


protocol NewsDataProviderDelegate : class {
    func dataLoaded()
}


class NewsDataProvider {
    var models = [NewsModel]()
    weak var delegate : NewsDataProviderDelegate?
    func getData(){
        let db = Firestore.firestore()
        
        db.collection("News").getDocuments { (snapShot, error) in
            if error != nil {
                print(error.debugDescription)
            } else {
                for document in snapShot!.documents{
                    let model : NewsModel = NewsModel()
                    model.title = document.data()["Title"] as! String
                    print(model.title)
                    model.content = document.data()["Content"] as! String
                    print(model.content)
                   // model.date = document.data()["Date"] as! String
                    model.date = "06.08.2018" 
                    model.img = document.data()["Image"] as! String
                    self.models.append(model)
                }
                self.delegate?.dataLoaded()
            }
        }
    }
}
