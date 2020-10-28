//
//  ResetPasswordViewController.swift
//  Star Cars
//
//  Created by shikha on 11/09/20.
//

import UIKit
import Alamofire
import Toast_Swift
import SVProgressHUD


class ResetPasswordViewController: UIViewController {
    
    @IBOutlet var mobileOtpTxt: UITextField!
    @IBOutlet var newPasswordField: UITextField!
    @IBOutlet var confirmNewPasswordField: UITextField!
    @IBOutlet var submitBtn: UIButton!
    
    var randomNumber:String?
    var mobilenumber:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "OTP Verification"
        self.getOTPforReset()
        self.submitBtn.addTarget(self, action: #selector(submitActn), for: .touchUpInside)
    }
    
    
    @objc func submitActn(_ sender: Any) {
        if internetConnection.isConnectedToNetwork() == true {
            validation()
        }
        else{
            self.view.makeToast("please check your internet.", duration: 3.0, position: .bottom)
            
        }
    }
    
    
    func validation () {
        
        var count = 0
        if self.mobileOtpTxt.text! == "" {
            self.view.makeToast("please enter OTP.", duration: 3.0, position: .bottom)
            count = count + 1
        }
        else {
            if self.mobileOtpTxt.text != randomNumber {
                 count = count + 1
                self.view.makeToast("Please enter correct OTP.", duration: 3.0, position: .bottom)
            }
        }
        
        if self.newPasswordField.text! == "" {
            count = count + 1
            self.view.makeToast("Please enter new password.", duration: 3.0, position: .bottom)
        }
        
        if self.newPasswordField.text != "" {
            
            if confirmNewPasswordField.text != newPasswordField.text {
                count = count + 1
                self.view.makeToast("New Password and Confirm didn't match.", duration: 3.0, position: .bottom)
                
            }
            
        }
          
        if count == 0 {
            self.resetPasswordApi()
        }
        
    }
    
   func getOTPforReset() {
            randomNumber = self.random()
            Alamofire.request(getOtpUrl, method: .post, parameters: ["authkey": "295442AkP0iZxj45d8865f1","route": "4", "sender": "CARSSR", "country": "91", "message": "Your OTP is \(randomNumber!)", "mobiles": self.mobilenumber!],encoding: URLEncoding.default, headers: nil).responseString { (response) in
               
            
    
                 let res = response
                     print(res)
                    
    
    
    }
    //        { (response) in
    //            print(response)
    //        }
            }
    
    func random() -> String {
        var result = ""
        repeat {
            result = String(format:"%04d", arc4random_uniform(10000) )
        } while result.count < 4 || Int(result)! < 1000
        print(result)
        return result
    }
    
    
    func resetPasswordApi() {
        SVProgressHUD.show()

        Alamofire.request(create_newpass, method: .post, parameters: ["key": "5642vcb546gfnbvb7r6ewc211365vhh34", "mobile": self.mobilenumber!, "newpass" : newPasswordField.text!],encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            SVProgressHUD.dismiss()

            switch response.result {
            case .success:
                print(response)
                
                let respDic = response.result.value as! NSDictionary
                if respDic["code"] as! String == "200" {
                    let alert = UIAlertController(title: "Success!", message: respDic["msg"] as? String, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                        self.loginApi()
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                    
                    // next page
                } else {
                    self.view.makeToast("Something went Wrong.", duration: 3.0, position: .bottom)
                }
                break
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    func loginApi() {
        SVProgressHUD.show()
        Alamofire.request(loginUrl, method: .post, parameters: ["key": "5642vcb546gfnbvb7r6ewc211365vhh34", "mobile": self.mobilenumber!, "password": self.newPasswordField.text!],encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            SVProgressHUD.dismiss()
            switch response.result {
            case .success:
                print(response)
                let respDic = response.result.value as! NSDictionary
                print(respDic)
                if respDic.object(forKey: "msg") as! String == "sucess" {
                    UserDefaults.standard.set(respDic.object(forKey: "id"), forKey: "UserID")
                    UserDefaults.standard.set(respDic.object(forKey: "email"), forKey: "Emailid")
                    UserDefaults.standard.set(respDic.object(forKey: "mobile"), forKey: "mobile")
                    UserDefaults.standard.set(respDic.object(forKey: "username"), forKey: "username")
                    UserDefaults.standard.set(respDic.object(forKey: "password"), forKey: "password")
                    let USERID = UserDefaults.standard.string(forKey: "UserID")
                    print(USERID ?? "")
                    let userid = respDic.object(forKey: "id")
                    userId = "\(userid ?? 10)"
                    
                    self.checkLocationofUser()
                   
                } else {
                    self.view.makeToast("Invalid Credentials.", duration: 3.0, position: .bottom)
                }
                
                break
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    
    
    func checkLocationofUser() {
        
        let city = UserDefaults.standard.object(forKey: "userCity")
        
        if city == nil {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LocationVc") as! LocationVc
            let navController = UINavigationController.init(rootViewController: vc)
                       navController.navigationBar.barTintColor = #colorLiteral(red: 0.5803921569, green: 0.06666666667, blue: 0, alpha: 1)
                       
                       navController.navigationBar.isTranslucent = false
                       self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5803921569, green: 0.06666666667, blue: 0, alpha: 1)
                       UINavigationBar.appearance().tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                       UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
            
            self.navigationController?.pushViewController(vc, animated: true)
        
        }else{
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home_VC") as! Home_VC
                
                let navController = UINavigationController.init(rootViewController: vc)
                navController.navigationBar.barTintColor = #colorLiteral(red: 0.5803921569, green: 0.06666666667, blue: 0, alpha: 1)

                navController.navigationBar.isTranslucent = false
                self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5803921569, green: 0.06666666667, blue: 0, alpha: 1)
                UINavigationBar.appearance().tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.window?.rootViewController = navController
        }
        
    }
    
}
