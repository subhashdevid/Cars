//
//  ViewController.swift
//  Star Cars
//
//  Created by Ritesh on 20/10/19.
//

import UIKit
import Alamofire
import Toast_Swift
import SVProgressHUD

class ViewController: UIViewController {

    @IBOutlet var mobileTxt: UITextField!
    @IBOutlet var passwordTxt: UITextField!
    @IBOutlet var toolBarView: UIView!
    @IBOutlet var logoImgView: UIImageView!
    @IBOutlet var popUpView: UIView!

//    var userId : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.logoImgView.layer.cornerRadius = 50
        self.logoImgView.layer.masksToBounds = true
        self.logoImgView.layer.borderColor = UIColor.black.cgColor
        self.logoImgView.layer.borderWidth = 2
        self.popUpView.layer.cornerRadius = 10
        mobileTxt.tag = 100
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.isNavigationBarHidden = true
    }

    @IBAction func registerActn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Register_VC") as! Register_VC
        vc.navigationController?.navigationItem.title = "Sign Up"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginActn(_ sender: Any) {

        if self.mobileTxt.text! == "" {
            self.view.makeToast("Please enter Mobile No.", duration: 3.0, position: .bottom)
        } else if self.passwordTxt.text! == "" {
            self.view.makeToast("Please enter your password.", duration: 3.0, position: .bottom)
        } else {
            loginApi()
        }
    }
    @IBAction func forgotPswrdActn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPassword_VC") as! ForgotPassword_VC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    func loginApi() {
        SVProgressHUD.show()
        Alamofire.request(loginUrl, method: .post, parameters: ["key": "5642vcb546gfnbvb7r6ewc211365vhh34", "mobile": self.mobileTxt.text!, "password": self.passwordTxt.text!],encoding: JSONEncoding.default, headers: nil).responseJSON {
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
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home_VC") as! Home_VC
                    
                    let navController = UINavigationController.init(rootViewController: vc)
                    navController.navigationBar.barTintColor = #colorLiteral(red: 0.5803921569, green: 0.06666666667, blue: 0, alpha: 1)

                    navController.navigationBar.isTranslucent = false
                    self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5803921569, green: 0.06666666667, blue: 0, alpha: 1)
                    UINavigationBar.appearance().tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
                    
                    
                    
                    self.appDelegate?.window?.rootViewController = navController
                } else {
                    self.view.makeToast("Invalid Credentials.", duration: 3.0, position: .bottom)
                }
                
                break
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    @IBAction func DoneAction(_ sender: Any) {
        self.view.endEditing(true)
    }
    
}

extension ViewController: UITextFieldDelegate {
    
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

extension UIViewController {
    
    func setupToHideKeyboardOnTapOnView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
