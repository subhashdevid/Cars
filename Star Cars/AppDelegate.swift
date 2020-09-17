//
//  AppDelegate.swift
//  Star Cars
//
//  Created by Ritesh on 20/10/19.
//

import UIKit
import SVProgressHUD
import Alamofire
import IQKeyboardManagerSwift

var userId:String?
var brandId:Int?
var selectedCarBrand:String = "Select Brand"
var selectedCarModel:String = "Select Model"
var selectedFuelType:String = "Select Fuel Type"
var selectedPickup:String = "Need Home Pickup"



var userSelectedTime:String?
var userSelectedCarBrand:String?
var userSelectedCarModel:String?
var userSelectedFuelType:String?
var userSelectedPickup:String?
var userCity:String?
var userCatId:String?
var userName:String?
var userMobile:String?


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        let USERID = UserDefaults.standard.string(forKey: "UserID")
        let city = UserDefaults.standard.object(forKey: "userCity")

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if USERID == nil || city == nil {
            let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            let navController = UINavigationController.init(rootViewController: vc)
            navController.navigationBar.barTintColor = #colorLiteral(red: 0.5803921569, green: 0.06666666667, blue: 0, alpha: 1)
            navController.navigationBar.isTranslucent = false
            navController.navigationBar.tintColor = .white
            self.window?.rootViewController = navController


        } else {
            
            let vc = storyboard.instantiateViewController(withIdentifier: "Home_VC") as! Home_VC
            let navController = UINavigationController.init(rootViewController: vc)
            navController.navigationBar.barTintColor = #colorLiteral(red: 0.5803921569, green: 0.06666666667, blue: 0, alpha: 1)
            navController.navigationBar.isTranslucent = false
            navController.navigationBar.tintColor = .white
            self.window?.rootViewController = navController
            
            navController.navigationBar.barTintColor = #colorLiteral(red: 0.5803921569, green: 0.06666666667, blue: 0, alpha: 1)
            UINavigationBar.appearance().tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
            
            
            
        }
        
        
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

