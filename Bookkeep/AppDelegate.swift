//
//  AppDelegate.swift
//  Bookkeep
//
//  Created by aa on 2020/9/11.
//  Copyright © 2020 Bookkeep. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let serialQueue : DispatchQueue = DispatchQueue(label: "serialQueue")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            GlobalValues.appVersion = version
        }
        //appBuild CFBundleVersion
        if let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            GlobalValues.appBuild = build
        }

        serialQueue.sync {
            AppInit()   //初始化DB
            AppOpen()   //資料庫開啟
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func AppInit(){
        //初始化db
        let fm = FileManager.default
        
        let appUrl = try! fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let dbPath = (appUrl.path as NSString).appendingPathComponent("account.db")
        print(dbPath)
        let isExists = fm.fileExists(atPath: dbPath)
        if !isExists {
            let defaultDBPath = (Bundle.main.resourcePath! as NSString).appendingPathComponent("account.db")
            do {
                try fm.copyItem(atPath: defaultDBPath, toPath: dbPath)
                print("success")
            } catch  {
                print(error)
            }
        }
    }
    func AppOpen() {

        accountDB = FMDatabase.init(path:getDBPath())
        if let db = accountDB {
            if !db.open(){
                print("FMDatabase無法開啟")
            }else{
                print("FMDatabase可以開啟")
            }
        }
        accountDBqueue = FMDatabaseQueue.init(path: getDBPath())
        
        Setup().initVar()
    }


}

