//
//  ForgotPassword VC.swift
//  Star Cars
//
//  Created by Ritesh on 20/10/19.
//

import UIKit
import Alamofire
import Toast_Swift
import SVProgressHUD

class ForgotPassword_VC: UIViewController {

    @IBOutlet var mobileTxt: UITextField!
    
    let virtualLocPushId = 23
    var virtualLocIdArr = [1,2,23,4,56]
    var locIdsArr:NSMutableArray = [[1,2,3], [4,5,6], [7,8,4,56], [4,5,6,56], [1,2]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Forgot Password"
       self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5803921569, green: 0.06666666667, blue: 0, alpha: 1)
       UINavigationBar.appearance().tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
       UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        
        let indexFound = findIndex(id: virtualLocPushId, array: virtualLocIdArr)
        print(indexFound)
        let indexValue = locIdsArr[indexFound] as! NSArray
        print(indexValue.count)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
    }

    @IBAction func submitActn(_ sender: Any) {
        if internetConnection.isConnectedToNetwork() == true {
            validation()
        }
        else{
            self.view.makeToast("please check your internet.", duration: 3.0, position: .bottom)

        }
    }
    
    
    func validation () {
        if self.mobileTxt.text! == "" {
            self.view.makeToast("please enter Mobile No.", duration: 3.0, position: .bottom)

        } else {
            forgotPswrdApi()
        }

    }
    
    func forgotPswrdApi() {
        SVProgressHUD.show()
        Alamofire.request(forgetpassword_otp, method: .post, parameters: ["key": "5642vcb546gfnbvb7r6ewc211365vhh34", "mobile": self.mobileTxt.text!],encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            SVProgressHUD.dismiss()
            switch response.result {
            case .success:
                print(response)
                let respArr = response.result.value as! NSArray
                let respDic = respArr.firstObject as! NSDictionary
                if respDic["code"] as! String == "200" {
                                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "ResetPasswordViewController") as! ResetPasswordViewController
                    self.navigationController?.pushViewController(newViewController, animated: true)
                   
                } else {
                    self.view.makeToast("Something went Wrong.", duration: 3.0, position: .bottom)
                }
                break
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    
    
    func findIndex(id: Int, array: Array<Any>) -> Int {
        
        var index = -1
        
        for items in array {
            
        index += 1
            
            if items as! Int == id {
                
                break
            }
            
        }
        
        return index
        
        
    }
    
    
    
    
    
}
