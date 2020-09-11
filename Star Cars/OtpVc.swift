//
//  OtpVc.swift
//  Star Cars
//
//  Created by Ritesh on 10/11/19.
//

import UIKit
import Alamofire

class OtpVc: UIViewController {

    @IBOutlet var otpTxt: UITextField!
    
    var mobileTxt:String?
    var passwordTxt:String?
    var nameTxt:String?
    var mailTxt:String?
    var randomNumber:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getOtpApi()
        self.navigationController?.navigationBar.isTranslucent = false
        self.setupToHideKeyboardOnTapOnView()
    }
    
    @IBAction func submitActn(_ sender: Any) {
        if internetConnection.isConnectedToNetwork() {
        if self.otpTxt.text! == randomNumber! {
            self.registerApi()
        }
    }
        else {
            self.view.makeToast("please check your internet.", duration: 3.0, position: .bottom)
        }
    }
    
    func getOtpApi() {
        randomNumber = self.random()
        Alamofire.request(getOtpUrl, method: .post, parameters: ["authkey": "295442AkP0iZxj45d8865f1","route": "4", "sender": "CARSSR", "country": "91", "message": "Your OTP is \(randomNumber!)", "mobiles": self.mobileTxt!],encoding: URLEncoding.default, headers: nil).responseString { (response) in
            print(response)
        }
//        { (response) in
//            print(response)
//        }
        }
    
//    func getOtpApi() {
//        randomNumber = self.random()
//        Alamofire.request("http://api.msg91.com/api/sendhttp.php", method: .post, parameters: ["authkey": "295442AkP0iZxj45d8865f1","route": "4", "sender": "CARSSR", "country": "91", "message": "Your OTP is \(randomNumber!)", "mobiles": self.mobileTxt!],encoding: JSONEncoding.default, headers: nil).responseString {
//            response in response
//            print(response)
//            switch response.result {
//            case .success:
//                self.view.makeToast("OTP Sent.", duration: 3.0, position: .bottom)
//                break
//            case .failure(let error):
//
//                print(error)
//            }
//        }
//    }
    
    
    func random() -> String {
        var result = ""
        repeat {
            result = String(format:"%04d", arc4random_uniform(10000) )
        } while result.count < 4 || Int(result)! < 1000
        print(result)
        return result
    }
    
    @IBAction func resendActn(_ sender: Any) {
        getOtpApi()
    }
    

    func registerApi() {
        Alamofire.request(registerUrl, method: .post, parameters: ["key": "5642vcb546gfnbvb7r6ewc211365vhh34","username": self.nameTxt!, "mobile": self.mobileTxt!, "email": self.mailTxt!, "password": self.passwordTxt!, "status": "1"],encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                print(response)
                let resdic = response.result.value as? NSDictionary
                if resdic!.value(forKey: "code") as! String == "401" {
                    self.view.makeToast("Already Registered.", duration: 3.0, position: .bottom)
                } else if resdic!.value(forKey: "code") as! String == "200" {
                    
                    self.view.makeToast("User registered Successfully.", duration: 3.0, position: .bottom)
                    userId = resdic!.object(forKey: "userid") as? String
                    UserDefaults.standard.set(userId, forKey: "UserID")
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home_VC") as! Home_VC
                        
                        let navController = UINavigationController.init(rootViewController: vc)
                        navController.navigationBar.barTintColor = #colorLiteral(red: 0.5803921569, green: 0.06666666667, blue: 0, alpha: 1)

                        navController.navigationBar.isTranslucent = false
                        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5803921569, green: 0.06666666667, blue: 0, alpha: 1)
                        UINavigationBar.appearance().tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
                        let appDelegate = UIApplication.shared.delegate as? AppDelegate
                    appDelegate?.window?.rootViewController = navController
               

                } else {
                    self.view.makeToast("Something went wrong. Please try again after sometime.", duration: 3.0, position: .bottom)
                    
                }
                break
            case .failure(let error):
                
                print(error)
            }
        }
    }

}
