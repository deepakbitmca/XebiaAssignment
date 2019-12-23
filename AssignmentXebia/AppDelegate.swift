//
//  AppDelegate.swift
//  AssignmentXebia
//
//  Created by Deepak Chauhan on 12/22/19.
//  Copyright © 2019 Deepak Chauhan. All rights reserved.
//

import UIKit
import SwiftSpinner
import MMDrawerController
import Reachability

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var drawerContainer: MMDrawerController?
    
    var window: UIWindow?
    let reachability = Reachability()!
    var appVersionString: String!

    // MARK: Current Delegate
    /*
     @Auther : Deepak Chauhan
     @Parameter : Nil
     @Description : It is creating the appdelegate object
     */
    @objc public class func currentDelegate () -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    // MARK: Current Delegate
    /*
     @Auther : Deepak Chauhan
     @Parameter : Nil
     @Description : It is creating To Add Loading
     */
    func addLoading () {
        SwiftSpinner.show("Loading")
        SwiftSpinner.sharedInstance.outerColor = Macros.primaryColor
        SwiftSpinner.sharedInstance.innerColor = Macros.primaryColor
    }
    
    // MARK: Current Delegate
    /*
     @Auther : Deepak Chauhan
     @Parameter : Nil
     @Description : It is creating To Remove Loading
     */
    func removeLoading () {
        SwiftSpinner.hide()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Override point for customization after application launch.
        ConnectionManager.sharedInstance.urlString = Macros.MainURL as String
        window?.makeKeyAndVisible()
        
        buildNavigationDrawer()
        
        //declare this inside of viewWillAppear
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
        
        return true
    }

    // MARK: - Set the Tabbar and Side Menu
    func buildNavigationDrawer() {
        
            // RecordList.storyboard
            let storyboard = UIStoryboard(name: "RecordList", bundle: nil)
            let navMainController = storyboard.instantiateViewController(withIdentifier: "navigationVCRecordList") as! UINavigationController
            let recordListVC:RecordListViewController = storyboard.instantiateViewController(withIdentifier: "RecordListViewController") as! RecordListViewController
            navMainController.setViewControllers([recordListVC], animated: true)
            
            // Main.storyboard
            let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
            var leftSideMenuNav = storyboardMain.instantiateViewController(withIdentifier: "leftNavigationVC") as! UINavigationController
            let leftSideMenu:LeftMenuViewController = storyboardMain.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
            leftSideMenuNav = UINavigationController(rootViewController:leftSideMenu)
            leftSideMenuNav.setNavigationBarHidden(true, animated: false)
            
            // Cerate MMDrawerController
            AppDelegate.currentDelegate().drawerContainer = MMDrawerController(center: navMainController, leftDrawerViewController: leftSideMenuNav, rightDrawerViewController: nil)
            AppDelegate.currentDelegate().drawerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.panningCenterView
            AppDelegate.currentDelegate().drawerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.panningCenterView
            
            // Assign MMDrawerController to our window's root ViewController
            window?.rootViewController = drawerContainer
        
    }
    
    // MARK: - Reachablity Class Method
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            isNetworkAvailable = true
        case .cellular:
            print("Reachable via Cellular")
            isNetworkAvailable = true
        case .none:
            print("Network not reachable")
            isNetworkAvailable = false
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

