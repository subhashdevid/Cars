//
//  ProfileVc.swift
//  Star Cars
//
//  Created by Ritesh on 29/10/19.
//

import UIKit
import SVProgressHUD
import Alamofire

class ProfileVc: UIViewController {

    @IBOutlet var nameView: UIView!
    @IBOutlet var mailView: UIView!
    @IBOutlet var phoneView: UIView!
    
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var mailLbl: UILabel!
    @IBOutlet var phoneLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"

        if internetConnection.isConnectedToNetwork() == true {
        profileApi()
        }
        else {
            self.view.makeToast("please check your internet.", duration: 3.0, position: .bottom)
        }
    }
    
    @IBAction func backActn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        self.present(vc, animated: false, completion: nil)
    }
    
    let USERID = UserDefaults.standard.string(forKey: "UserID")

    func profileApi() {
        SVProgressHUD.show()
        Alamofire.request(profileUrl, method: .post, parameters: ["key": "5642vcb546gfnbvb7r6ewc211365vhh34", "userid": USERID],encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            SVProgressHUD.dismiss()
            switch response.result {
            case .success:
                print(response)
                let respDic = response.result.value as! NSDictionary
                print(respDic)
                if respDic.object(forKey: "msg") as! String == "sucess" {
                    
                    self.nameLbl.text = respDic.object(forKey: "username") as? String
                    userName = respDic.object(forKey: "username") as? String
                    self.mailLbl.text = respDic.object(forKey: "email") as? String
                    self.phoneLbl.text = respDic.object(forKey: "mobile") as? String
                    userMobile = respDic.object(forKey: "mobile") as? String
                    
                } else {
                    self.view.makeToast("Something Went Wrong.", duration: 3.0, position: .bottom)
                }
                
                break
            case .failure(let error):
                
                print(error)
            }
        }
    }

}
