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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "OTP Verification"
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
    
    
    func resetPasswordApi() {
        SVProgressHUD.show()

        Alamofire.request(create_newpass, method: .post, parameters: ["key": "5642vcb546gfnbvb7r6ewc211365vhh34", "mobile": self.mobileOtpTxt.text!, "newpass" : newPasswordField.text!],encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            SVProgressHUD.dismiss()

            switch response.result {
            case .success:
                print(response)
                
                let respDic = response.result.value as! NSDictionary
                if respDic["code"] as! String == "200" {
                    let alert = UIAlertController(title: "Success!", message: respDic["msg"] as? String, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                        self.navigationController?.popToRootViewController(animated: false)                    }))
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
    
}
