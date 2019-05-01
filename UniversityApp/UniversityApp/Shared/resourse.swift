//
//  Resourse.swift
//  UniversityApp
//
//  Created by Роман Макеев on 22.08.2018.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import Foundation
import Kingfisher
class resourse{
    static var resource = ImageResource(downloadURL: URL(string: UsersModel.userModel.url_image)!, cacheKey: UsersModel.userModel.url_image)
    
    private init(){}
}
