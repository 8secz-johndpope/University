//
//  AppDelegate.swift
//  UniversityApp
//
//  Created by Роман Макеев on 23.07.2018.
//  Copyright © 2018 Роман Макеев. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import Firebase
import FirebaseFirestore
import VK_ios_sdk
import FirebaseAuth
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Fabric.with([Crashlytics.self])
        FirebaseApp.configure()
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        
        try! Auth.auth().signOut()
        if Auth.auth().currentUser != nil {
            Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid as! String).getDocument(completion: { (snapShot, error) in
                if error != nil {
                    print("Error")
                }else {
                    UsersModel.userModel.FirstName = snapShot?.data()!["First-name"] as! String
                    UsersModel.userModel.LastName = snapShot?.data()!["Last-name"] as! String
                    UsersModel.userModel.Institute = snapShot?.data()!["Institut"] as! String
                    UsersModel.userModel.email = snapShot?.data()!["Email"] as! String
                    UsersModel.userModel.Facultet = snapShot?.data()!["Facultet"] as! String
                    UsersModel.userModel.Group = snapShot?.data()!["Group"] as! String
                    UsersModel.userModel.SubGroup = snapShot?.data()!["Sub-group"] as! String
                    UsersModel.userModel.url_image = snapShot?.data()!["Avatar-url"] as! String
                    UsersModel.userModel.Recordbook = snapShot?.data()!["Number-record-book"] as! String

                }
               
                Firestore.firestore().collection("Institute").document(UsersModel.userModel.Institute).getDocument(completion: { (snapShot, error) in
                    if error != nil {
                        print("Error")
                    }else {
                        print(snapShot!.data())
                        UsersModel.userModel.shortName = snapShot?.data()!["shortName"] as! String
                        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let apptVC = storyboard.instantiateInitialViewController()
                        self.window?.rootViewController = apptVC
                    }
                })
                
            })

        }else {
            let storyboard: UIStoryboard = UIStoryboard(name: "Entrance", bundle: nil)
            let apptVC = storyboard.instantiateInitialViewController()
            self.window?.rootViewController = apptVC
        }
        return true
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String)
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

