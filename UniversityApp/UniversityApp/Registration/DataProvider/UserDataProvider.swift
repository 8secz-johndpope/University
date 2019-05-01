//
//  UserDataProvider.swift
//  UniversityApp
//
//  Created by 1 on 10.08.18.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import Foundation
import VK_ios_sdk
protocol UserDataProviderDelegate : class{
    func transition ()
}


class UserDataProvider: NSObject,VKSdkDelegate {
    
    weak var delegate: UserDataProviderDelegate?
    var sdkInstance: VKSdk?
    var userModel = UserModel()
    
    
    override init() {
        super.init()
        
        let vkAppId = "6656509"
        sdkInstance = VKSdk.initialize(withAppId: vkAppId)
        sdkInstance?.register(self)
        
    }
    let vkScope = ["id,first_name,last_name,email,photo_max"]
    
    func authorizationVK(){
        VKSdk.wakeUpSession(vkScope) { (state, error) in
            if state == .authorized {
                self.getVKUserInfo()
                
            } else if state == .initialized {
                VKSdk.authorize(self.vkScope)
                
            } else {
                print("Error")
            }
        }
    }
    
    private func getVKUserInfo() {
        VKApi.users().get([VK_API_FIELDS : vkScope]).execute(resultBlock: { (response) in
            debugPrint(response)
            guard let parsedModel = response?.parsedModel as? VKUsersArray,
                let user = parsedModel.firstObject() else { return }
            if let userId = VKSdk.accessToken().userId {
              UsersModel.userModel.id = userId
            }
            if let firstName = user.first_name
            {
               UsersModel.userModel.name = firstName
            }
            if let lastName = user.last_name {
                UsersModel.userModel.surname = lastName
            }
            if let avatarURL = user.photo_max {
                UsersModel.userModel.url_image = avatarURL as! String
            }
            let  emailUser = VKSdk.accessToken().email
            if emailUser != nil {
                UsersModel.userModel.email = emailUser!
            }else {
                let  userId = VKSdk.accessToken().userId
                UsersModel.userModel.email = userId! + "@mail.ru"
            }
            self.delegate?.transition()
            
        }, errorBlock: { _ in
            
        })
    }
    //MARK: - VK Delegate
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        getVKUserInfo()
    }
    
    func vkSdkUserAuthorizationFailed() {
        print("Error")
    }
    
   
}
