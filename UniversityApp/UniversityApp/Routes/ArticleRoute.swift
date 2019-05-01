//
//  ArticleRoute.swift
//  UniversityApp
//
//  Created by Роман Макеев on 25.07.2018.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import Foundation
import UIKit

class ArticleRoute {
    static func showArticle(id: String, fromVc: UIViewController){
        let toVc = UIStoryboard(name: "News", bundle: nil).instantiateViewController(withIdentifier: NewsDetailViewController.nibName) as! NewsDetailViewController
      
        toVc.navigationController?.hero.isEnabled = true
        toVc.isHeroEnabled = true
        
        
    }
}
