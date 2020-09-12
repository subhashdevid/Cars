//
//  Register VC.swift
//  Star Cars
//
//  Created by Ritesh on 20/10/19.
//

import UIKit
import Alamofire

class Register_VC: UIViewController {

    @IBOutlet var nameTxt: UITextField!
    @IBOutlet var mailTxt: UITextField!
    @IBOutlet var mobileTxt: UITextField!
    @IBOutlet var passwordTxt: UITextField!
    @IBOutlet weak var confrmPass: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        mobileTxt.tag = 100
        mobileTxt.delegate = self
        self.title = "Registration"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5803921569, green: 0.06666666667, blue: 0, alpha: 1)
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.5803921569, green: 0.06666666667, blue: 0, alpha: 1)
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]


    }
    
    
    func validationData() {
        if nameTxt.text?.isEmpty == true {
            self.view.makeToast("please Enter your name.", duration: 3.0, position: .bottom)
        }
        else if mailTxt.text?.isEmpty == true {
            self.view.makeToast("please  Enter your email address.", duration: 3.0, position: .bottom)
        }
        else if mobileTxt.text?.isEmpty == true{
            self.view.makeToast("please Enter your mobile number.", duration: 3.0, position: .bottom)
        }
        else if passwordTxt.text?.isEmpty == true{
        self.view.makeToast("please Enter your password.", duration: 3.0, position: .bottom)
        }
        else if confrmPass.text?.isEmpty == true {
        self.view.makeToast("please Enter your Confirm Password", duration: 3.0, position: .bottom)
        }
        else if (passwordTxt.text == confrmPass.text) == false {
            self.view.makeToast("please Enter correct Password.", duration: 3.0, position: .bottom)
        }
        else if !(mailTxt.text!.isValidEmail){
            self.view.makeToast("please Enter valid email.", duration: 3.0, position: .bottom)
        }
        else if !(mobileTxt.text?.isValidPhone)!{
          self.view.makeToast("please Enter 10 digit mobile number", duration: 3.0, position: .bottom)
        }
        else {
            registerApi()
        }
    }
    
    @IBAction func registerActn(_ sender: Any) {
        if internetConnection.isConnectedToNetwork() == true {
            validationData()
        } else {
            self.view.makeToast("please check your internet.", duration: 3.0, position: .bottom)
        }
    }
    
    func registerApi() {
        Alamofire.request(registerUrl, method: .post, parameters: ["key": "5642vcb546gfnbvb7r6ewc211365vhh34","username": nameTxt.text!, "mobile": mobileTxt.text!, "email": mailTxt.text!, "password": passwordTxt.text!, "status": "0"],encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                print(response)
                let resdic = response.result.value as? NSDictionary
                if resdic!.value(forKey: "code") as! String == "401" {
                    self.view.makeToast("Already Registered.", duration: 3.0, position: .bottom)
                } else if resdic!.value(forKey: "code") as! String == "403" {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "OtpVc") as! OtpVc
                    vc.mobileTxt = self.mobileTxt.text
                    vc.passwordTxt = self.passwordTxt.text!
                    vc.mailTxt = self.mailTxt.text!
                    vc.nameTxt = self.nameTxt.text!
                    self.navigationController?.pushViewController(vc, animated: true)
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

/**
 * extension for valid mobile / empcode
 */
extension Register_VC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField.tag == 100 {
            let charsLimit = 10

                   let startingLength = textField.text?.count ?? 0
                   let lengthToAdd = string.count
                   let lengthToReplace =  range.length
                   let newLength = startingLength + lengthToAdd - lengthToReplace

                   return newLength <= charsLimit
        }
       
        return true
    }
    
    

}


extension String {
    var isValidPhoneNumber: Bool {
        let PHONE_REGEX = "^[0-9]{10}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        return result
        
    }
    
    
}

/**
 *    extension for validation
 */

extension String{
    var isValidEmail: Bool {
        let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
        return testEmail.evaluate(with: self)
    }
    var isValidPhone: Bool {
        let PHONE_REGEX = "^[0-9]{10}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        return result
        
    }
    
}

